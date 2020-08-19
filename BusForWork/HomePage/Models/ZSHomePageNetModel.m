//
//  ZSHomePageNetModel.m
//  BusForWork
//
//  Created by 周传森 on 2019/8/12.
//  Copyright © 2019年 森. All rights reserved.
//

#import "ZSHomePageNetModel.h"
#import "ZSHomePageUIModel.h"
#import "LineInfoModel+CoreDataProperties.h"
@implementation ZSHomePageNetModel
+ (void)loadLineDetail:(ZSBusLine)line block:(void(^)(NSArray <ZSHomePageUIModel *> * dataArr, NSError * error))block
{
    [ZSNetWork get:[ZSTools getLineDetailURL:line] parms:nil complete:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        [self extractResponse:response line:line block:block];
    }];
}

+ (void)extractResponse:(NSDictionary *)response line:(ZSBusLine)line block:(void(^)(NSArray <ZSHomePageUIModel *> * dataArr, NSError * error))block
{
//    NSLog(@"response is %@",response);
    
    NSDictionary * jsonr = [response objectForKey:@"jsonr"];
    
    NSDictionary * data = [jsonr objectForKey:@"data"];
    
    NSArray * buses = [data objectForKey:@"buses"];
    
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    for (NSDictionary * dic in buses) {
        NSArray * travels = [dic objectForKey:@"travels"];
        if (travels.count == 0) {
            continue;
        }
        
        NSDictionary * travelsDic = [travels firstObject];

        NSInteger currentOrder = [[dic objectForKey:@"order"] integerValue];
        NSInteger selectedOrder = [[travelsDic objectForKey:@"order"] integerValue];
        if ((selectedOrder - currentOrder) > 10) {
            continue;
        }
        ZSHomePageUIModel * model = [[ZSHomePageUIModel alloc] init];
        model.lineName = [ZSTools getLineNameByLine:line];
        model.speed = [NSString stringWithFormat:@"%.1f",[[dic objectForKey:@"speed"] doubleValue]];
        
        /*
        model.arriveTime = [NSString stringWithFormat:@"%@",[ZSTools timestampSubtractNowTimestamp:[[travelsDic objectForKey:@"arrivalTime"] doubleValue]]];
        model.arriveIntTime = [ZSTools secondTimestampSubtractNowTimestamp:[[travelsDic objectForKey:@"arrivalTime"] doubleValue]];
        */
        
        
        model.arriveTime = [NSString stringWithFormat:@"%@",[ZSTools secondTimeFormat:[[travelsDic objectForKey:@"travelTime"] doubleValue]]];
        model.arriveIntTime = [[travelsDic objectForKey:@"travelTime"] doubleValue];
        
        
        model.currentOrder = currentOrder;
        model.selectedOrder = selectedOrder;
        model.station = [NSString stringWithFormat:@"%ld",model.selectedOrder - model.currentOrder];
        
        
        [self configureDistanceAndStationName:line forModel:model subDictance:[NSString stringWithFormat:@"%@",dic[@"distanceToSc"]]];
        [self configureDiscriptionStr:model];
        [arr addObject:model];
    }
    
    
    block(arr,nil);
    
    
}

+ (void)configureDiscriptionStr:(ZSHomePageUIModel *)model
{
    if ([model.station integerValue] == 0) {
        if (model.arriveIntTime == 0) {
            model.descriptionStr = @"已到站";
            model.arriveType = ZSBusArriveType_didArrive;
        }
        else
        {
            model.descriptionStr = @"即将到站";
            model.arriveType = ZSBusArriveType_willArrive;
        }
    }
    else
    {
//        model.descriptionStr = @"未到站";
        model.arriveType = ZSBusArriveType_unArrive;
        
    }
}

+ (void)configureDistanceAndStationName:(ZSBusLine)line
                               forModel:(ZSHomePageUIModel *)model
                            subDictance:(NSString *)distanceToSc
{
    __block NSArray * lineInfoModelArr;
    [[ZSBusCoreData shareCoreData] getLineInfo:line result:^(NSArray<LineInfoModel *> * _Nonnull lineInfoArr) {
        lineInfoModelArr = [lineInfoArr copy];
    }];
    
    NSInteger currentDistanceToStartStation = -1;
    NSInteger selectedDistanceToStartStation = -1;
    for (LineInfoModel * lineInfoModel in lineInfoModelArr) {
        if (lineInfoModel.order == model.currentOrder) {
            model.descriptionStr = [NSString stringWithFormat:@"-->%@",lineInfoModel.sn];
            currentDistanceToStartStation = lineInfoModel.distanceToStation;
        }
        if (lineInfoModel.order == model.selectedOrder) {
            selectedDistanceToStartStation = lineInfoModel.distanceToStation;
        }
        if ((currentDistanceToStartStation != -1) && (selectedDistanceToStartStation != -1)) {
            break;
        }
    }
    
    NSInteger dist = selectedDistanceToStartStation - currentDistanceToStartStation;
    if (dist == 0) {
        model.distance = distanceToSc;
    }
    else
    {
        model.distance = [NSString stringWithFormat:@"%ld",(long)dist];
    }
    
}


@end
