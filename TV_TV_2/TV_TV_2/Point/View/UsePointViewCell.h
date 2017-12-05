//
//  UsePointViewCell.h
//  BTG
//
//  Created by liyy on 2017/11/17.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UsePointViewCell : UITableViewCell

@property (nonatomic, retain) NSObject *model;

@property (nonatomic, retain) UIImageView *giftIV;

@property (nonatomic, retain) UIImageView *infoIV;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *distanceLabel;
@property (nonatomic, retain) UILabel *discountLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
