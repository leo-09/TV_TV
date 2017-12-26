//
//  BrandProductCell.h
//  BTG
//
//  Created by liyy on 2017/11/6.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 精选产品Cell
 */
@interface BrandProductCell : UITableViewCell

@property (nonatomic, retain) UIImageView *infoIV;
@property (nonatomic, retain) UILabel *pointLabel;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *storeLabel;
@property (nonatomic, retain) UILabel *discountLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
