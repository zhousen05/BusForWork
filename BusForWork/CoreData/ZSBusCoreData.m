//
//  ZSBusCoreData.m
//  BusForWork
//
//  Created by 周传森 on 2019/8/10.
//  Copyright © 2019 森. All rights reserved.
//

#import "ZSBusCoreData.h"
#import "ZSBusCoreDataModel.h"
#import "LineInfoModel+CoreDataProperties.h"



@implementation ZSBusCoreData
{
    NSMutableArray <ZSBusCoreDataModel *> * _dataArr;
    BOOL _isAM;
}
+ (ZSBusCoreData *)shareCoreData
{
    static ZSBusCoreData * coreData;
    static dispatch_once_t coreDataOnceToken;
    dispatch_once(&coreDataOnceToken, ^{
        coreData = [[ZSBusCoreData alloc] init];
    });
    return coreData;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArr = [[NSMutableArray alloc] init];
        _isAM = [ZSTools loadIsAM];
    }
    return self;
}

- (void)getLineInfo:(ZSBusLine)line result:(void(^)(NSArray <LineInfoModel *>* lineInfoArr))resultBlock
{
    //从内存加载
    NSArray * lineInfo;
    for (ZSBusCoreDataModel * model in _dataArr) {
        if (model.busLine == line) {
            lineInfo = model.lineInfo;
            break;
        }
    }
    
    //从数据库加载
    if (!lineInfo || lineInfo.count == 0) {
        lineInfo = [self loadLineInfoFromSQL:line];
        if (lineInfo && lineInfo.count > 0) {
            [self loadLineInfoToRAM:lineInfo line:line];
        }
    }
    
    
    //从网络加载
    if (!lineInfo || lineInfo.count == 0) {
        [self loadLineInfoFromeNet:line result:resultBlock];
    }
    else
    {
        resultBlock(lineInfo);
    }
}

- (NSArray *)loadLineInfoFromSQL:(ZSBusLine)line
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"LineInfoModel"];
    
    NSPredicate * pre = [NSPredicate predicateWithFormat:@"lineNum = %d && isAM = %d", line,_isAM];
    
    request.predicate = pre;
    
    NSError * error;
    NSAsynchronousFetchResult * result = [self.persistentContainer.viewContext executeRequest:request error:&error];
    
//    <NSFetchRequest: 0x2813adb90> (entity: LineInfoModel; predicate: (lineNum == 3 AND isAM == 0); sortDescriptors: ((null)); type: NSManagedObjectResultType; )

    
    if (error) {
        return nil;
    }
    
    NSArray * arr = result.finalResult;
    
    return arr;

}

- (void)loadLineInfoFromeNet:(ZSBusLine)line result:(void(^)(NSArray <LineInfoModel *>*))resultBlock
{
    __weak ZSBusCoreData * weakSelf = self;
    [ZSBusCoreDataModel loadLineInfoFromNet:line block:^(NSArray<LineInfoModel *> * _Nullable lineInfoArr) {
        //加载到内存
        [weakSelf loadLineInfoToRAM:lineInfoArr line:line];
        resultBlock(lineInfoArr);
    }];
}



- (void)loadLineInfoToRAM:(NSArray<LineInfoModel *> *)lineInfoArr line:(ZSBusLine)line
{
    BOOL isExist = NO;
    for (ZSBusCoreDataModel * model in _dataArr) {
        if (model.busLine == line) {
            isExist = YES;
            break;
        }
    }
    
    if (isExist == NO) {
        ZSBusCoreDataModel * model = [[ZSBusCoreDataModel alloc] init];
        model.busLine = line;
        model.lineInfo = [lineInfoArr copy];
        [_dataArr addObject:model];
    }

}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Model"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}


@end
