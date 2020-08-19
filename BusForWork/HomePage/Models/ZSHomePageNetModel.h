//
//  ZSHomePageNetModel.h
//  BusForWork
//
//  Created by 周传森 on 2019/8/12.
//  Copyright © 2019年 森. All rights reserved.
//

#import "ZSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class ZSHomePageUIModel;
@interface ZSHomePageNetModel : ZSBaseModel
+ (void)loadLineDetail:(ZSBusLine)line block:(void(^)(NSArray <ZSHomePageUIModel *> * dataArr, NSError * error))block;
@end

NS_ASSUME_NONNULL_END
