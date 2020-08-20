//
//  ZSHomePageLogic.m
//  BusForWork
//
//  Created by 周传森 on 2019/8/10.
//  Copyright © 2019 森. All rights reserved.
//

#import "ZSHomePageLogic.h"
#import "ZSHomePageNetModel.h"
#import "ZSHomePageUIModel.h"
@implementation ZSHomePageLogic
{
    BOOL _isAM;
    NSArray * _lineArr;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isAM = [ZSTools loadIsAM];
        _dataArr = [[NSMutableArray alloc] init];
        _lineArr = @[[NSNumber numberWithInteger:ZSBusLine_324],
                    [NSNumber numberWithInteger:ZSBusLine_M358],
                    [NSNumber numberWithInteger:ZSBusLine_M222],
//                    [NSNumber numberWithInteger:ZSBusLine_334],
                    [NSNumber numberWithInteger:ZSBusLine_H22],
                     [NSNumber numberWithInteger:ZSBusLine_H31]
//                    [NSNumber numberWithInteger:ZSBusLine_H11]
                    ];
    }
    return self;
}

- (void)loadDatas
{
    
    [self loadLineInfos];
//    [self loadLineDetails];
    
}

- (void)loadLineInfos
{
    __weak ZSHomePageLogic * weakSelf = self;
    
    
    dispatch_queue_t queue = dispatch_queue_create("loadLineInfoQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    for (NSNumber * number in _lineArr) {
        NSInteger line = [number integerValue];
        
        dispatch_group_enter(group);
        dispatch_group_async(group, queue, ^{
            [[ZSBusCoreData shareCoreData] getLineInfo:line result:^(NSArray<LineInfoModel *> * _Nonnull lineInfoArr) {
                dispatch_group_leave(group);
            }];
        });
    }
    
    dispatch_group_notify(group, queue, ^{
        [weakSelf loadLineDetails];
    });

}

- (void)loadLineDetails
{
    __weak ZSHomePageLogic * weakSelf = self;

    dispatch_queue_t queue = dispatch_queue_create("loadLineDetailQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    
    __block NSMutableArray * tempArr = [[NSMutableArray alloc] init];
    
    NSLock * lock = [[NSLock alloc] init];
    for (NSNumber * number in _lineArr) {
        NSInteger line = [number integerValue];
        
        dispatch_group_enter(group);
        dispatch_group_async(group, queue, ^{
            [ZSHomePageNetModel loadLineDetail:line block:^(NSArray<ZSHomePageUIModel *> * _Nonnull dataArr, NSError * _Nonnull error) {
                [lock lock];
                [tempArr addObjectsFromArray:dataArr];
                dispatch_group_leave(group);
                [lock unlock];
            }];
        });
        
    }
    
    dispatch_group_notify(group, queue, ^{
        [weakSelf.dataArr removeAllObjects];
        [weakSelf.dataArr addObjectsFromArray:tempArr];
        [weakSelf orderData];
    });
   

}

- (void)orderData
{
    
    [_dataArr sortUsingComparator:^NSComparisonResult(ZSHomePageUIModel  * obj1, ZSHomePageUIModel*  obj2) {
        return [@(obj1.arriveIntTime) compare:@(obj2.arriveIntTime)];
    }];
    
    [self reloadUI];
}

- (void)reloadUI
{
    __weak ZSHomePageLogic * weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(didLoadData)]) {
            [weakSelf.delegate didLoadData];
        }
    });
}
@end
