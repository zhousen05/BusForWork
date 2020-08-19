//
//  LineInfoModel+CoreDataProperties.h
//  BusForWork
//
//  Created by 周传森 on 2019/8/10.
//  Copyright © 2019 森. All rights reserved.
//
//

#import "LineInfoModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface LineInfoModel (CoreDataProperties)

+ (NSFetchRequest<LineInfoModel *> *)fetchRequest;

@property (nonatomic) int64_t distanceToSp;
@property (nonatomic) double lat;
@property (nonatomic) double lng;
@property (nonatomic) int64_t order;
@property (nonatomic) int64_t lineNum;
@property (nullable, nonatomic, copy) NSString *sId;
@property (nullable, nonatomic, copy) NSString *sn;
@property (nullable, nonatomic, copy) NSString *lineName;
@property (nonatomic) BOOL isAM;
@property (nonatomic) int64_t distanceToStation;//从出发点到当前站的距离

@end

NS_ASSUME_NONNULL_END
