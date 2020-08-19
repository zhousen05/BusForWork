//
//  ZSBusCoreData.h
//  BusForWork
//
//  Created by 周传森 on 2019/8/10.
//  Copyright © 2019 森. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LineInfoModel;

//typedef enum : NSUInteger {
//    ZSBusLine_324,
//    ZSBusLine_M358,
//    ZSBusLine_H22,
//    ZSBusLine_H11,
//} ZSBusLine;


NS_ASSUME_NONNULL_BEGIN

@interface ZSBusCoreData : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

+ (ZSBusCoreData *)shareCoreData;

- (void)getLineInfo:(ZSBusLine)line result:(void(^)(NSArray <LineInfoModel *>* lineInfoArr))resultBlock;

@end

NS_ASSUME_NONNULL_END
