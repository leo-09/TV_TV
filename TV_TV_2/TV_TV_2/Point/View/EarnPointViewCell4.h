//
//  EarnPointViewCell.h
//  BTG
//
//  Created by liyy on 2017/11/17.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EarnPointViewCell4 : UITableViewCell

@property (nonatomic, retain) UIView *bgView;
@property (nonatomic, retain) UILabel *nameLabel;       // 卡名称
@property (nonatomic, retain) UILabel *timeLabel;       // 时间
@property (nonatomic, retain) UILabel *pointLabel;      // 积分
@property (nonatomic, retain) UILabel *styleLabel;      // 线下／线上消费

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
