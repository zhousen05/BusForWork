//
//  ZSNetWork.m
//  网易
//
//  Created by 周传森 on 2019/2/16.
//  Copyright © 2019 森. All rights reserved.
//

#import "ZSNetWork.h"


@interface ZSNetWork ()
@property (nonatomic,strong) NSURLSession * _seeeion;
@property (nonatomic,strong) NSURLSessionDataTask * _task;
@end

@implementation ZSNetWork

+ (instancetype)shareZSNetWork
{
    static ZSNetWork *  zsNetWork;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        zsNetWork = [[ZSNetWork alloc] init];
    });
    return zsNetWork;
}

+ (void)get:(NSString *)url parms:(NSDictionary * _Nullable)parms complete:(void (^)(NSDictionary * _Nullable, NSError * _Nullable))complete
{
    NSMutableString * httpString = [[NSMutableString alloc] init];
    [httpString appendString:url];
    if (parms) {
        [httpString appendString:@"?"];
        for (NSString * key in parms.allKeys) {
            [httpString appendString:[NSString stringWithFormat:@"%@=%@",key,parms[key]]];
        }
        [httpString deleteCharactersInRange:NSMakeRange(httpString.length - 1, 1)];
    }
    
    
    NSURL * finnalUrl = [NSURL URLWithString:httpString];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:finnalUrl];
    
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self extractData:data error:error url:finnalUrl.absoluteString parms:parms complete:complete];
    }];
    [task resume];
    
}

+ (void)post:(NSString *)url parms:(NSDictionary *)parms complete:(void (^)(NSDictionary * _Nullable, NSError * _Nullable))complete
{
    
}

+ (void)extractData:(NSData *)data error:(NSError *)error url:(NSString *)urlString parms:(NSDictionary *)parms complete:(void (^)(NSDictionary * _Nullable, NSError * _Nullable))complete
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (error) {
//            NSLog(@"urlPath:%@->postError:%@",urlString,error);
            if ([error.domain isEqualToString:@"NSURLErrorDomain"]) {
                complete(nil,[NSError errorWithDomain:error.localizedDescription code:-100 userInfo:nil]);
            }
            else
            {
                complete(nil,error);
            }
        }
        else
        {
            
            NSData * finnalData = [self stringDataToDictionaryData:data];
         
            NSError * exrErr;
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:finnalData options:NSJSONReadingMutableLeaves error:&exrErr];
            if (exrErr) {
                
                NSString * string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"string is %@",string);
                
                
//                NSLog(@"urlPath:%@->解析错误:%@",urlString,exrErr);
                if (string.length > 0) {
                    complete(nil,[NSError errorWithDomain:[NSString stringWithFormat:@"非法的返回数据:%@",string] code:-100 userInfo:nil]);
                }
                else
                {
                    complete(nil,[NSError errorWithDomain:@"非法的返回数据" code:-100 userInfo:nil]);
                }
                
            }
            else
            {
//                NSLog(@"urlPath:%@->params:%@->result:%@",urlString,parms,dic);
                complete(dic,nil);
            }
        }
    });
}

+ (NSData *)stringDataToDictionaryData:(NSData *)data
{
    NSString * string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSArray * dataArr0 = [string componentsSeparatedByString:@"YGKJ##"];
    
    NSString * string1 = [dataArr0 firstObject];
    
    NSArray * dataArr1 = [string1 componentsSeparatedByString:@"**YGKJ"];
    
    NSString * finnalString = [dataArr1 lastObject];
    
    NSData * finnalData = [finnalString dataUsingEncoding:NSUTF8StringEncoding];

    return finnalData;
}
@end
