//
//  BrandShopCell.m
//  BTG
//
//  Created by liyy on 2017/11/6.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import "BrandShopCell.h"
#import "UILabel+CustomLab.h"
#import "UIColor+color.h"
#import <Masonry.h>

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define UIColorFromRGBA(rgbValue,trans) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:trans]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// ---------------- 设置圆角和边框 ----------------
#define CTXViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

@implementation BrandShopCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"BrandShopCell";
    // 1.缓存中
    BrandShopCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[BrandShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

/**
 *  构造方法(在初始化对象的时候会调用)
 *  一般在这个方法中添加需要显示的子控件
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(@0);
            make.height.equalTo(@10);
        }];
        
        _infoIV = [[UIImageView alloc] init];
        _infoIV.image = [UIImage imageNamed:@"use_point_icon"];
        [self addSubview:_infoIV];
        [_infoIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(lineView.mas_top);
            make.width.equalTo(@((SCREEN_WIDTH - 40) * (125.0 / 340.0)));
        }];
        
        UIView *pointView = [[UILabel alloc] init];
        // 背景
        NSArray *colors = @[(__bridge id)UIColorFromRGB(0xffab02).CGColor,
                            (__bridge id)UIColorFromRGB(0xff7e06).CGColor];
        CGRect frame = CGRectMake(0, 0, 36, 20);
        [UIColor setObliqueGradualChangingColor:pointView colors:colors frame:frame];
        CTXViewBorderRadius(pointView, 10, 0, [UIColor clearColor]);
        [self addSubview:pointView];
        [pointView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_infoIV.mas_left).offset(10);
            make.bottom.equalTo(_infoIV.mas_bottom).offset(-10);
            make.width.equalTo(@36);
            make.height.equalTo(@20);
        }];
        
        _pointLabel = [[UILabel alloc] init];
        _pointLabel.text = @"9.9";
        _pointLabel.textAlignment = NSTextAlignmentCenter;
        [_pointLabel setCustomFontWithBold:YES withSize:15 withTextColor:UIColorFromRGB(0x000000)];
        [self addSubview:_pointLabel];
        [_pointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(pointView);
        }];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"全聚德烤鸭店";
        [_nameLabel setCustomFontWithBold:NO withSize:15 withTextColor:UIColorFromRGB(0x333333)];
        _nameLabel.numberOfLines = 2;
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.right.equalTo(_infoIV.mas_left).offset(-10);
            make.top.equalTo(@14);
        }];
        
        _distanceLabel = [[UILabel alloc] init];
        _distanceLabel.text = @"距离1.88km";
        [_distanceLabel setCustomFontWithBold:NO withSize:12 withTextColor:UIColorFromRGB(0xbfbfbf)];
        [self addSubview:_distanceLabel];
        [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLabel.mas_left);
            make.right.equalTo(_nameLabel.mas_right);
            make.bottom.equalTo(lineView.mas_top).offset(-10);
        }];
        
        _discountLabel = [[UILabel alloc] init];
        _discountLabel.text = @"3.9折";
        [_discountLabel setCustomFontWithBold:YES withSize:16 withTextColor:UIColorFromRGB(0x0b5ec0)];
        [self addSubview:_discountLabel];
        [_discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_distanceLabel.mas_left);
            make.bottom.equalTo(_distanceLabel.mas_top).offset(-10);
        }];
    }
    
    return self;
}

@end
