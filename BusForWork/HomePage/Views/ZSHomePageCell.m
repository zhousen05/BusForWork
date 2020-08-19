//
//  ZSHomePageCell.m
//  BusForWork
//
//  Created by 周传森 on 2019/8/12.
//  Copyright © 2019年 森. All rights reserved.
//

#import "ZSHomePageCell.h"
#import "ZSHomePageUIModel.h"
@implementation ZSHomePageCell
{
    UILabel * _nameLab;
    UILabel * _timeLab;
    UILabel * _stationCountLab;
    UILabel * _speedLab;
    UILabel * _distanceLab;
    UILabel * _destirptionLab;
}

- (void)resetUI:(ZSHomePageUIModel *)model
{
    _nameLab.text = model.lineName;
    _timeLab.text = [NSString stringWithFormat:@"%@",model.arriveTime];
    _stationCountLab.text = [NSString stringWithFormat:@"%@站",model.station];
    _speedLab.text = [NSString stringWithFormat:@"%@km/s",model.speed];
    _distanceLab.text = [NSString stringWithFormat:@"%@米",model.distance];
    _destirptionLab.text = model.descriptionStr;
    switch (model.arriveType) {
        case ZSBusArriveType_unArrive:
            _destirptionLab.textColor = [UIColor blackColor];
            _destirptionLab.font = [UIFont systemFontOfSize:14];
            break;
        case ZSBusArriveType_willArrive:
            _destirptionLab.textColor = [UIColor orangeColor];
            _destirptionLab.font = [UIFont systemFontOfSize:16];


            break;
        case ZSBusArriveType_didArrive:
            _destirptionLab.textColor = [UIColor redColor];
            _destirptionLab.font = [UIFont systemFontOfSize:16];
            break;
            
        default:
            break;
    }
}

- (void)loadSubViews
{
    [super loadSubViews];

    CGFloat leftSpace = 10;
    _nameLab = [ZSTools instanceLabelWithFrame:CGRectMake(leftSpace, 0, (SCREEN_WIDTH - leftSpace *2)/2, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor colorWithRed:73/255.0 green:203/255.0 blue:248/255.0 alpha:1] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_nameLab];
    
    _timeLab = [ZSTools instanceLabelWithFrame:CGRectMake(_nameLab.right, _nameLab.y, _nameLab.width, 30) font:[UIFont boldSystemFontOfSize:18] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_timeLab];
    
    _stationCountLab = [ZSTools instanceLabelWithFrame:CGRectMake(_timeLab.x, _nameLab.bottom, _timeLab.width, 20) font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] textAlignment:_timeLab.textAlignment];
    [self.contentView addSubview:_stationCountLab];
    
    
    _distanceLab = [ZSTools instanceLabelWithFrame:CGRectMake(_nameLab.x, _nameLab.bottom, _timeLab.width, _stationCountLab.height) font:_stationCountLab.font textColor:_stationCountLab.textColor textAlignment:_stationCountLab.textAlignment];
    [self.contentView addSubview:_distanceLab];
    
    
    
    _speedLab = [ZSTools instanceLabelWithFrame:CGRectMake(_nameLab.x, _distanceLab.bottom, _distanceLab.width, _distanceLab.height) font:_stationCountLab.font textColor:_stationCountLab.textColor textAlignment:_stationCountLab.textAlignment];
    [self.contentView addSubview:_speedLab];
    
    _destirptionLab = [ZSTools instanceLabelWithFrame:CGRectMake(_timeLab.x, _stationCountLab.bottom, _stationCountLab.width, _stationCountLab.height) font:[UIFont systemFontOfSize:16] textColor:[UIColor blackColor] textAlignment:_stationCountLab.textAlignment];
    [self.contentView addSubview:_destirptionLab];
    
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 75, SCREEN_WIDTH, 5)];
    line.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    [self.contentView addSubview:line];

    
}

@end
