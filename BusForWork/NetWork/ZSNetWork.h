//
//  ZSNetWork.h
//  网易
//
//  Created by 周传森 on 2019/2/16.
//  Copyright © 2019 森. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZSNetWork : NSObject

//+ (instancetype)shareZSNetWork;

//+ (void)loadUrl:(NSString * )url finish:(void (^)(NSDictionary * _Nullable dic, NSError * _Nullable error))finish;

+ (void)get:(NSString *)url parms:(NSDictionary * _Nullable)parms complete:(void (^) (NSDictionary * _Nullable response,NSError * _Nullable error))complete;

+ (void)post:(NSString *)url parms:(NSDictionary * _Nullable)parms complete:(void (^) (NSDictionary * _Nullable response,NSError * _Nullable error))complete;

@end

NS_ASSUME_NONNULL_END
