//
//  ZSHomePageCell.h
//  BusForWork
//
//  Created by 周传森 on 2019/8/12.
//  Copyright © 2019年 森. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSBaseTableViewCell.h"
@class ZSHomePageUIModel;
NS_ASSUME_NONNULL_BEGIN

@interface ZSHomePageCell : ZSBaseTableViewCell
- (void)resetUI:(ZSHomePageUIModel *)model;
@end

NS_ASSUME_NONNULL_END
