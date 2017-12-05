//
//  PointViewHeadCell.m
//  BTG
//
//  Created by liyy on 2017/11/17.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import "PointViewHeadCell.h"
#import <Masonry.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation PointViewHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColorFromRGB(0xfbfbfb);
        
        _headView = [[UIView alloc] init];
        _headView.backgroundColor = UIColorFromRGB(0xf7f3eb);
        [self addSubview:_headView];
        [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.height.equalTo(@116);
        }];
        
        [self addItemView];
        
        UIView *whiteView = [[UIView alloc] init];
        whiteView.backgroundColor = UIColorFromRGB(0xFFFFFF);
        [self addSubview:whiteView];
        [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headView.mas_bottom);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.height.equalTo(@20);
        }];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void) addItemView {
    UIImageView *iv = [[UIImageView alloc] init];
    iv.image = [UIImage imageNamed:@"avatar"];
    [_headView addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.centerY.equalTo(_headView);
        make.width.equalTo(@70);
        make.height.equalTo(@70);
    }];
    
    UILabel *memberLabel = [[UILabel alloc] init];
    memberLabel.text = @"普通会员";
    memberLabel.font = [UIFont systemFontOfSize:18.0];
    memberLabel.textColor = UIColorFromRGB(0xc2a070);
    [_headView addSubview:memberLabel];
    [memberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iv.mas_right).offset(24);
        make.top.equalTo(@40);
    }];
    
    UIImageView *InfoIV = [[UIImageView alloc] init];
    InfoIV.image = [UIImage imageNamed:@"Info"];
    [self addSubview:InfoIV];
    [InfoIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(memberLabel).offset(16);
        make.top.equalTo(memberLabel).offset(-8);
    }];
    
    UILabel *pointLabel = [[UILabel alloc] init];
    pointLabel.text = @"38,999 积分";
    pointLabel.font = [UIFont systemFontOfSize:24.0];
    pointLabel.textColor = UIColorFromRGB(0xc2a070);
    [_headView addSubview:pointLabel];
    [pointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(memberLabel.mas_left);
        make.top.equalTo(memberLabel.mas_bottom).offset(10);
    }];
}

@end
