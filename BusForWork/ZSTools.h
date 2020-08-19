//
//  ZSTools.h
//  BusForWork
//
//  Created by 周传森 on 2019/8/12.
//  Copyright © 2019年 森. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN



typedef enum : NSUInteger {
    ZSBusLine_324 = 0,
    ZSBusLine_M358,
    ZSBusLine_M222,
    ZSBusLine_334,
    ZSBusLine_H22,
    ZSBusLine_H11,
} ZSBusLine;

@interface ZSTools : NSObject

+ (BOOL)loadIsAM;

+ (NSString *)getLineNameByLine:(ZSBusLine)line;

+ (NSString *)getLineDetailURL:(ZSBusLine)line;
+ (NSString *)getLineInfoURL:(ZSBusLine)line;

+ (NSString *)getNowTimeTimestamp;

+ (NSString *)timestampSubtractNowTimestamp:(double)timestamp;

+ (NSInteger)secondTimestampSubtractNowTimestamp:(double)timestamp;

+ (NSString *)secondTimeFormat:(NSInteger)seconds;

+ (BOOL)isTime:(NSString *)time1 afterTime:(NSString *)time2;

+ (UILabel *)instanceLabelWithFrame:(CGRect)frame
                               font:(UIFont *)font
                          textColor:(UIColor *)textColor
                      textAlignment:(NSTextAlignment)textAlignment;
@end

NS_ASSUME_NONNULL_END
