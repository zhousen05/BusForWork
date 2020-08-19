//
//  LineInfoModel+CoreDataProperties.m
//  BusForWork
//
//  Created by 周传森 on 2019/8/10.
//  Copyright © 2019 森. All rights reserved.
//
//

#import "LineInfoModel+CoreDataProperties.h"

@implementation LineInfoModel (CoreDataProperties)

+ (NSFetchRequest<LineInfoModel *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"LineInfoModel"];
}

@dynamic distanceToSp;
@dynamic lat;
@dynamic lng;
@dynamic order;
@dynamic lineNum;
@dynamic sId;
@dynamic sn;
@dynamic lineName;
@dynamic isAM;
@dynamic distanceToStation;
@end
