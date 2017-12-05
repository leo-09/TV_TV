//
//  GivePointViewCell.m
//  BTG
//
//  Created by liyy on 2017/11/17.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import "GivePointViewCell.h"
#import <Masonry.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

// ---------------- 设置圆角和边框 ----------------
#define CTXViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

@implementation GivePointViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"GivePointViewCell";
    // 1.缓存中
    GivePointViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[GivePointViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        
        _randomBtn = [[UIButton alloc] init];
        _randomBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_randomBtn setTitle:@"   随机分配" forState:UIControlStateNormal];
        [_randomBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        [_randomBtn setTitleColor:UIColorFromRGB(0xc2a070) forState:UIControlStateSelected];
        [_randomBtn setImage:[UIImage imageNamed:@"give_point_default"] forState:UIControlStateNormal];
        [_randomBtn setImage:[UIImage imageNamed:@"give_point_selected"] forState:UIControlStateSelected];
        _randomBtn.selected = YES;
        [_randomBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:_randomBtn];
        [_randomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.width.equalTo(@(SCREEN_WIDTH / 2));
            make.height.equalTo(@85);
        }];
        
        _averageBtn = [[UIButton alloc] init];
        _averageBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_averageBtn setTitle:@"   平均分配" forState:UIControlStateNormal];
        [_averageBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        [_averageBtn setTitleColor:UIColorFromRGB(0xc2a070) forState:UIControlStateSelected];
        [_averageBtn setImage:[UIImage imageNamed:@"give_point_default"] forState:UIControlStateNormal];
        [_averageBtn setImage:[UIImage imageNamed:@"give_point_selected"] forState:UIControlStateSelected];
        [_averageBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:_averageBtn];
        [_averageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.right.equalTo(@0);
            make.width.equalTo(@(SCREEN_WIDTH / 2));
            make.height.equalTo(@85);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = UIColorFromRGB(0xf5f5f5);
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.top.equalTo(_averageBtn.mas_bottom);
            make.height.equalTo(@6);
        }];
        
        // 赠送总积分
        UILabel *pointLabel = [[UILabel alloc] init];
        pointLabel.text = @"赠送总积分";
        pointLabel.font = [UIFont systemFontOfSize:16.0];
        pointLabel.textColor = UIColorFromRGB(0x333333);
        [self addSubview:pointLabel];
        [pointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.equalTo(lineView.mas_bottom).offset(42);
            make.width.equalTo(@82);
        }];
        
        _pointTF = [[UITextField alloc] init];
        _pointTF.placeholder = @"请输入赠送总积分";
        _pointTF.textColor = UIColorFromRGB(0x333333);
        _pointTF.font = [UIFont systemFontOfSize:16.0];
        _pointTF.borderStyle = UITextBorderStyleRoundedRect;
        _pointTF.keyboardType = UIKeyboardTypeNumberPad;
        _pointTF.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_pointTF];
        [_pointTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(pointLabel);
            make.left.equalTo(pointLabel.mas_right).offset(15);
            make.right.equalTo(@(-15));
            make.height.equalTo(@46);
        }];
        
        // 红包份数
        UILabel *countLabel = [[UILabel alloc] init];
        countLabel.text = @"红包份数";
        countLabel.font = [UIFont systemFontOfSize:16.0];
        countLabel.textColor = UIColorFromRGB(0x333333);
        [self addSubview:countLabel];
        [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.equalTo(pointLabel.mas_bottom).offset(42);
            make.width.equalTo(@82);
        }];
        
        _countTF = [[UITextField alloc] init];
        _countTF.placeholder = @"请输入赠送份数";
        _countTF.textColor = UIColorFromRGB(0x333333);
        _countTF.font = [UIFont systemFontOfSize:16.0];
        _countTF.borderStyle = UITextBorderStyleRoundedRect;
        _countTF.keyboardType = UIKeyboardTypeNumberPad;
        _countTF.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_countTF];
        [_countTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(countLabel);
            make.left.equalTo(countLabel.mas_right).offset(15);
            make.right.equalTo(@(-15));
            make.height.equalTo(@46);
        }];
        
        // 留言
        _textView = [[UITextView alloc] init];
        _textView.delegate = self;
        _textView.textColor = UIColorFromRGB(0x333333);
        _textView.font = [UIFont systemFontOfSize:16.0];
        CTXViewBorderRadius(_textView, 4.0, 1, UIColorFromRGB(0xf2f2f2));
        [self addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_countTF.mas_bottom).offset(30);
            make.left.equalTo(@15);
            make.right.equalTo(@(-15));
            make.height.equalTo(@90);
        }];
        
        // tintLabel
        _tintLabel = [[UILabel alloc] init];
        _tintLabel.text = @"给好友留句问候吧!";
        _tintLabel.font = [UIFont systemFontOfSize:15.0];
        _tintLabel.textColor = UIColorFromRGB(0xcecece);
        [self addSubview:_tintLabel];
        [_tintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_textView.mas_left).offset(6);
            make.top.equalTo(_textView.mas_top).offset(8);
        }];
        
        // 发送积分红包
        UIButton *subscribeBtn = [[UIButton alloc] init];
        [subscribeBtn setTitle:@"发 送 积 分 红 包" forState:UIControlStateNormal];
        [subscribeBtn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        subscribeBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
//        [subscribeBtn addTarget:self action:@selector(subscribe) forControlEvents:UIControlEventTouchDown];
        [self addSubview:subscribeBtn];
        [subscribeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.height.equalTo(@50);
        }];
    }
    
    return self;
}

- (void) clickBtn:(UIButton *)btn {
    if (btn == self.randomBtn) {
        self.averageBtn.selected = NO;
        self.randomBtn.selected = YES;
    } else {
        self.averageBtn.selected = YES;
        self.randomBtn.selected = NO;
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        _tintLabel.hidden = NO;
    } else {
        _tintLabel.hidden = YES;
    }
}

@end
