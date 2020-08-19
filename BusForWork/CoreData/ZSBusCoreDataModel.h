//
//  ZSBusCoreDataModel.h
//  BusForWork
//
//  Created by 周传森 on 2019/8/10.
//  Copyright © 2019 森. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LineInfoModel;
NS_ASSUME_NONNULL_BEGIN

@interface ZSBusCoreDataModel : NSObject
@property (nonatomic, assign) ZSBusLine busLine;
@property (nonatomic, copy) NSArray <LineInfoModel *>* lineInfo;

+ (void)loadLineInfoFromNet:(ZSBusLine)line block:(void(^)(NSArray <LineInfoModel *>* _Nullable lineInfoArr))block;
@end

NS_ASSUME_NONNULL_END
