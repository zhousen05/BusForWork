//
//  ZSTools.m
//  BusForWork
//
//  Created by 周传森 on 2019/8/12.
//  Copyright © 2019年 森. All rights reserved.
//

#import "ZSTools.h"

@implementation ZSTools

+ (BOOL)loadIsAM
{
//    return YES;
    
    
//    NSNumber * isAM = [[NSUserDefaults standardUserDefaults] objectForKey:@"isAM"];
//    if (isAM) {
//        return ([isAM intValue] == 1) ? YES : NO;
//    }
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setAMSymbol:@"AM"];
    
    [dateFormatter setPMSymbol:@"PM"];
    
    [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mmaaa"];
    
    NSDate *date = [NSDate date];
    
    NSString * s = [dateFormatter stringFromDate:date];
    
    BOOL result = [s containsString:@"AM"] ? YES : NO;
//    [[NSUserDefaults standardUserDefaults] setObject:((result == YES) ? @1:@0) forKey:@"isAM"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    return result;
    
}

+ (NSString *)getLineNameByLine:(ZSBusLine)line
{
    NSString * lineName;
    switch (line) {
        case ZSBusLine_324:
            lineName = @"324";
            break;
        case ZSBusLine_M358:
            lineName = @"M358";
            break;
        case ZSBusLine_M222:
            lineName = @"M222";
            break;
        case ZSBusLine_334:
            lineName = @"334";
            break;
        case ZSBusLine_H22:
            lineName = @"H22";
            break;
        case ZSBusLine_H11:
            lineName = @"H11";
            break;
        case ZSBusLine_H31:
            lineName = @"H31";
            break;
            
        default:
            break;
    }
    return lineName;
}


+ (NSString *)getLineInfoURL:(ZSBusLine)line
{
    BOOL isAM = [self loadIsAM];
    NSString * url;
    if (isAM) {
        switch (line) {
            case ZSBusLine_324:
                url = ZSBusLineInfo_324_AM;
                break;
            case ZSBusLine_M358:
                url = ZSBusLineInfo_M358_AM;
                break;
            case ZSBusLine_M222:
                url = ZSBusLineInfo_M222_AM;
                break;
            case ZSBusLine_334:
                url = ZSBusLineInfo_334_AM;
                break;
            case ZSBusLine_H22:
                url = ZSBusLineInfo_H22_AM;
                break;
            case ZSBusLine_H11:
                url = ZSBusLineInfo_H11_AM;
                break;
            case ZSBusLine_H31:
                url = ZSBusLineInfo_H31_AM;
                break;
                
            default:
                break;
        }
    }
    else
    {
        switch (line) {
            case ZSBusLine_324:
                url = ZSBusLineInfo_324_PM;
                break;
            case ZSBusLine_M358:
                url = ZSBusLineInfo_M358_PM;
                break;
            case ZSBusLine_M222:
                url = ZSBusLineInfo_M222_PM;
                break;
            case ZSBusLine_334:
                url = ZSBusLineInfo_334_PM;
                break;
            case ZSBusLine_H22:
                url = ZSBusLineInfo_H22_PM;
                break;
            case ZSBusLine_H11:
                url = ZSBusLineInfo_H11_PM;
                break;
            case ZSBusLine_H31:
                url = ZSBusLineInfo_H31_PM;
                break;
                
            default:
                break;
        }
    }
    return url;
}

+ (NSString *)getLineDetailURL:(ZSBusLine)line
{
    BOOL isAM = [self loadIsAM];
    NSString * url;
    if (isAM) {
        switch (line) {
            case ZSBusLine_324:
                url = ZSBusLineDetail_324_AM;
                break;
            case ZSBusLine_M358:
                url = ZSBusLineDetail_M358_AM;
                break;
            case ZSBusLine_M222:
                url = ZSBusLineDetail_M222_AM;
                break;
            case ZSBusLine_334:
                url = ZSBusLineDetail_334_AM;
                break;
            case ZSBusLine_H22:
                url = ZSBusLineDetail_H22_AM;
                break;
            case ZSBusLine_H11:
                url = ZSBusLineDetail_H11_AM;
                break;
            case ZSBusLine_H31:
                url = ZSBusLineDetail_H31_AM;
                break;
            default:
                break;
        }
    }
    else
    {
        switch (line) {
            case ZSBusLine_324:
                url = ZSBusLineDetail_324_PM;
                break;
            case ZSBusLine_M358:
                url = ZSBusLineDetail_M358_PM;
                break;
            case ZSBusLine_M222:
                url = ZSBusLineDetail_M222_PM;
                break;
            case ZSBusLine_334:
                url = ZSBusLineDetail_334_PM;
                break;
            case ZSBusLine_H22:
                url = ZSBusLineDetail_H22_PM;
                break;
            case ZSBusLine_H11:
                url = ZSBusLineDetail_H11_PM;
                break;
            case ZSBusLine_H31:
                url = ZSBusLineDetail_H31_PM;
                
                break;
                
            default:
                break;
        }
    }
    return url;
}



+(NSString *)getNowTimeTimestamp
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    
    return timeSp;
}

+ (NSString *)timestampSubtractNowTimestamp:(double)timestamp
{

    NSInteger seconds = [self secondTimestampSubtractNowTimestamp:timestamp];
    
    return [self secondTimeFormat:seconds];

}

+ (NSString *)secondTimeFormat:(NSInteger)seconds
{
    NSString * timeString;
    if (seconds >= 60) {
        NSString * min = [NSString stringWithFormat:@"%ld",seconds/60];
        if (seconds/60 < 10) {
            min = [NSString stringWithFormat:@"0%@",min];
        }
        timeString = [NSString stringWithFormat:@"%@分%ld秒",min,seconds%60];
        if (seconds%60 < 10) {
            timeString = [NSString stringWithFormat:@"%@分0%ld秒",min,seconds%60];
        }
    }
    else
    {
        timeString = [NSString stringWithFormat:@"%ld秒",(long)seconds];
        if (seconds < 10) {
            timeString = [NSString stringWithFormat:@"%ld秒",(long)seconds];
        }
    }
    return timeString;
    
}

+ (NSInteger)secondTimestampSubtractNowTimestamp:(double)timestamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    
    //    NSDate * dateta = [[NSDate alloc] initWithTimeIntervalSinceNow:timestamp];
    
    NSDate * dateta = [[NSDate alloc] initWithTimeIntervalSince1970:timestamp/1000];
    
    NSInteger seconds = [dateta timeIntervalSinceNow];
    
    return seconds;
}

+ (BOOL)isTime:(NSString *)time1 afterTime:(NSString *)time2
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"mm:ss"];
    
    NSDate*dateA = [dateFormatter dateFromString:time1];
    
    NSDate*dateB = [dateFormatter dateFromString:time2];
//    后面的大
    return ([dateA compare:dateB] == NSOrderedDescending) ? NO : YES;
}

+ (UILabel *)instanceLabelWithFrame:(CGRect)frame
                               font:(UIFont *)font
                          textColor:(UIColor *)textColor
                      textAlignment:(NSTextAlignment)textAlignment
{
    UILabel * lab = [[UILabel alloc] initWithFrame:frame];
    lab.font = font;
    lab.textColor = textColor;
    lab.textAlignment = NSTextAlignmentLeft;
    return lab;
}



@end
