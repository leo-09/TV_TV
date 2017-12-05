//
//  EarnPointViewCell.m
//  BTG
//
//  Created by liyy on 2017/11/17.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import "EarnPointViewCell2.h"
#import <Masonry.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation EarnPointViewCell2

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"EarnPointViewCell2";
    // 1.缓存中
    EarnPointViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[EarnPointViewCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        self.backgroundColor = UIColorFromRGB(0xf5f5f5);
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"每日签到";
        _nameLabel.font = [UIFont systemFontOfSize:16.0];
        _nameLabel.textColor = UIColorFromRGB(0x333333);
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.centerY.equalTo(self);
        }];
        
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.text = @"+10";
        _valueLabel.font = [UIFont systemFontOfSize:16.0];
        _valueLabel.textColor = UIColorFromRGB(0xc2a070);
        [self addSubview:_valueLabel];
        [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        _btn = [[UIButton alloc] init];
        [_btn setTitle:@"签到领取" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_btn];
        [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-20));
            make.centerY.equalTo(self);
            make.width.equalTo(@86);
            make.height.equalTo(@34);
        }];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = UIColorFromRGB(0xF2F2F2);
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(@0);
            make.height.equalTo(@1);
        }];
    }
    
    return self;
}

@end
