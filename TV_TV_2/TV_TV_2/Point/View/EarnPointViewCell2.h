//
//  EarnPointViewCell.h
//  BTG
//
//  Created by liyy on 2017/11/17.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EarnPointViewCell2 : UITableViewCell

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *valueLabel;
@property (nonatomic, retain) UIButton *btn;
@property (nonatomic, retain) UIView *lineView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
