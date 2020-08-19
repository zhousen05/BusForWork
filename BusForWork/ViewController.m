//
//  ViewController.m
//  BusForWork
//
//  Created by 周传森 on 2019/8/10.
//  Copyright © 2019 森. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
//    double distance = [self distanceBetweenOrderBy:22.572452 :22.567286 :114.054703 :114.051];//687.24
    
//        double distance = [self distanceBetweenOrderBy:22.572452 :22.612774 :114.054703 :114.039604];//687.24
    
    double distance = [self getDistance:22.572452 lng1:114.054703 lat2:22.567286 lng2:114.051];//689
    NSLog(@"distance is %.2f",distance);
}

-(double)distanceBetweenOrderBy:(double) lat1 :(double) lat2 :(double) lng1 :(double) lng2{
    
    CLLocation *curLocation = [[CLLocation alloc] initWithLatitude:lat1 longitude:lng1];
    
    CLLocation *otherLocation = [[CLLocation alloc] initWithLatitude:lat2 longitude:lng2];
    
    double  distance  = [curLocation distanceFromLocation:otherLocation];
    
    return  distance;
    
}



- (float)radians:(float)degrees{
    return (degrees*3.14159265)/180.0;
}
//根据经纬度换算出直线距离

- (float)getDistance:(float)lat1 lng1:(float)lng1 lat2:(float)lat2 lng2:(float)lng2
{
    //地球半径
    int R = 6378137;
    //将角度转为弧度
    float radLat1 = [self radians:lat1];
    float radLat2 = [self radians:lat2];
    float radLng1 = [self radians:lng1];
    float radLng2 = [self radians:lng2];
    //结果
    float s = acos(cos(radLat1)*cos(radLat2)*cos(radLng1-radLng2)+sin(radLat1)*sin(radLat2))*R;
    //精度
    s = round(s* 10000)/10000;
    return  round(s);
}

@end
