//
//  ZSBusCoreDataModel.m
//  BusForWork
//
//  Created by 周传森 on 2019/8/10.
//  Copyright © 2019 森. All rights reserved.
//

#import "ZSBusCoreDataModel.h"
#import "LineInfoModel+CoreDataClass.h"
@implementation ZSBusCoreDataModel

+ (void)loadLineInfoFromNet:(ZSBusLine)line block:(void(^)(NSArray <LineInfoModel *>* _Nullable lineInfoArr))block
{
    
    NSString * url = [ZSTools getLineInfoURL:line];
    
    [ZSNetWork get:url parms:nil complete:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        //保存到数据库
        if (error) {
            block(nil);
        }
        else
        {
            [self extractDictionary:response line:line block:block];
        }
//        NSLog(@"response is %@",response);
    }];
}

+ (void)extractDictionary:(NSDictionary *)response line:(ZSBusLine)line block:(void(^)(NSArray <LineInfoModel *>* _Nullable lineInfoArr))block
{
    NSDictionary * jsonr = [response objectForKey:@"jsonr"];
    NSDictionary * data = [jsonr objectForKey:@"data"];
    NSArray * stations = [data objectForKey:@"stations"];
    
    if (stations.count > 0) {
        

        NSMutableArray * arr = [NSMutableArray arrayWithCapacity:stations.count];
        BOOL isAM = [ZSTools loadIsAM];
        for (NSDictionary * dic in stations) {
            LineInfoModel * model = (LineInfoModel *)[NSEntityDescription insertNewObjectForEntityForName:@"LineInfoModel" inManagedObjectContext:[ZSBusCoreData shareCoreData].persistentContainer.viewContext];
            model.distanceToSp = [dic[@"distanceToSp"] integerValue];
            model.lat = [dic[@"lat"] doubleValue];
            model.lng = [dic[@"lng"] doubleValue];
            model.order = [dic[@"order"] integerValue];
            model.lineNum = line;
            model.sId = dic[@"sId"] ;
            model.sn = dic[@"sn"];
            model.lineName = [ZSTools getLineNameByLine:line];
            model.distanceToSp = [dic[@"distanceToSp"] integerValue];
            model.isAM = isAM;
            [arr addObject:model];
        }
        [self configureDistanceToStation:arr];
        [[ZSBusCoreData shareCoreData] saveContext];
        NSLog(@"line %lu succeed inset to db",(unsigned long)line);
        block(arr);
    }
    else
    {
        block(nil);
    }
}

+ (void)configureDistanceToStation:(NSArray <LineInfoModel *>*)arr
{
    for (int i = 0; i < arr.count; i++) {
        LineInfoModel * model = arr[i];
        if (i == 0) {
            model.distanceToStation = 0;
        }
        else
        {
            LineInfoModel * lastModel = arr[i - 1];
            model.distanceToStation = lastModel.distanceToStation + model.distanceToSp;
        }
    }
}

//+ (NSString *)getURLWithLine:(ZSBusLine)line isAM:(BOOL)isAM
//{
//    NSString * url;
//    if (isAM) {
//        switch (line) {
//            case ZSBusLine_324:
//                url = ZSBusLine_324_AM;
//                break;
//
//            default:
//                break;
//        }
//    }
//    else
//    {
//        switch (line) {
//            case ZSBusLine_324:
//                url = ZSBusLine_324_AM;
//                break;
//
//            default:
//                break;
//        }
//    }
//    return url;
//}

@end
