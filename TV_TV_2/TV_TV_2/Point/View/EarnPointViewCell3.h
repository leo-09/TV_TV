//
//  EarnPointViewCell.h
//  BTG
//
//  Created by liyy on 2017/11/17.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickBtnIndex) (int index);

@interface EarnPointViewCell3 : UITableViewCell

@property (nonatomic, retain) UIButton *selectBtn;
@property (nonatomic, retain) UIView *indicatorView;

@property (nonatomic, copy) ClickBtnIndex clickBtnIndex;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
