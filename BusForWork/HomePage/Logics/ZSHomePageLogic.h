//
//  ZSHomePageLogic.h
//  BusForWork
//
//  Created by 周传森 on 2019/8/10.
//  Copyright © 2019 森. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZSHomePageLogicDelegate <NSObject>

- (void)didLoadData;

@end


@interface ZSHomePageLogic : NSObject
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, weak) id<ZSHomePageLogicDelegate>delegate;
- (void)loadDatas;
@end

NS_ASSUME_NONNULL_END
