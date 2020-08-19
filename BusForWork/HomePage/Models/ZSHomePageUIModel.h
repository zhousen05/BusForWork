//
//  ZSHomePageUIModel.h
//  BusForWork
//
//  Created by 周传森 on 2019/8/12.
//  Copyright © 2019年 森. All rights reserved.
//

#import "ZSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ZSBusArriveType_unArrive,
    ZSBusArriveType_willArrive,
    ZSBusArriveType_didArrive,
} ZSBusArriveType;


@interface ZSHomePageUIModel : ZSBaseModel
@property (nonatomic, copy) NSString * lineName;
@property (nonatomic, copy) NSString * speed;
@property (nonatomic, copy) NSString * arriveTime;
@property (nonatomic, copy) NSString * station;
@property (nonatomic, copy) NSString * distance;
@property (nonatomic, copy) NSString * descriptionStr;
@property (nonatomic, assign) ZSBusArriveType arriveType;

@property (nonatomic, assign) NSInteger selectedOrder;
@property (nonatomic, assign) NSInteger currentOrder;
@property (nonatomic, assign) NSInteger arriveIntTime;
@end

NS_ASSUME_NONNULL_END
