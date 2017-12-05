//
//  EarnPointViewCell.m
//  BTG
//
//  Created by liyy on 2017/11/17.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import "EarnPointViewCell3.h"
#import <Masonry.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

@implementation EarnPointViewCell3

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"EarnPointViewCell3";
    // 1.缓存中
    EarnPointViewCell3 *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[EarnPointViewCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        
        UIView *whiteView = [[UIView alloc] init];
        whiteView.backgroundColor = UIColorFromRGB(0xFFFFFF);
        [self addSubview:whiteView];
        [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.top.equalTo(@0);
            make.height.equalTo(@20);
        }];
        
        UIView *bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = UIColorFromRGB(0xFFFFFF);
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.top.equalTo(whiteView.mas_bottom).offset(4);
            make.bottom.equalTo(@0);
        }];
        
        // bottomView的子View
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = UIColorFromRGB(0xF2F2F2);
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(@(-26));
            make.height.equalTo(@1);
        }];
        
        NSArray *array = @[ @"明细", @"流出", @"流入" ];
        for (int i = 0; i < array.count; i++) {
            UIButton *btn = [[UIButton alloc] init];
            btn.tag = i;
            [btn setTitle:array[i] forState:UIControlStateNormal];
            [btn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
            [btn setTitleColor:UIColorFromRGB(0xc2a070) forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchDown];
            [bottomView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@0);
                make.bottom.equalTo(lineView.mas_top);
                make.left.equalTo(@(i * SCREEN_WIDTH / 3));
                make.width.equalTo(@(SCREEN_WIDTH / 3));
            }];
            
            if (i == 0) {
                self.selectBtn = btn;
                btn.selected = YES;
            }
        }
        
        _indicatorView = [[UIView alloc] init];
        _indicatorView.backgroundColor = UIColorFromRGB(0xc2a070);
        [bottomView addSubview:_indicatorView];
        [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.selectBtn);
            make.bottom.equalTo(self.selectBtn.mas_bottom);
            make.height.equalTo(@2);
            make.width.equalTo(@80);
        }];
    }
    
    return self;
}

- (void) clickBtn:(UIButton *)btn {
    self.selectBtn.selected = NO;
    self.selectBtn = btn;
    self.selectBtn.selected = YES;
    
    CGFloat x = self.selectBtn.frame.origin.x - (80 - self.selectBtn.frame.size.width) / 2;
    CGFloat y = self.selectBtn.frame.origin.y + (self.selectBtn.frame.size.height - 2);
    _indicatorView.frame = CGRectMake(x, y, 80, 2);
    
    if (self.clickBtnIndex) {
        self.clickBtnIndex((int)btn.tag);
    }
}

@end
