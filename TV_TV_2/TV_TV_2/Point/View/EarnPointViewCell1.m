//
//  EarnPointViewCell.m
//  BTG
//
//  Created by liyy on 2017/11/17.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import "EarnPointViewCell1.h"

#import <Masonry.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation EarnPointViewCell1

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"EarnPointViewCell1";
    // 1.缓存中
    EarnPointViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[EarnPointViewCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        
        _giftIV = [[UIImageView alloc] init];
        _giftIV.image = [UIImage imageNamed:@"home_background"];
        [self addSubview:_giftIV];
        [_giftIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@20);
            make.left.equalTo(@15);
            make.right.equalTo(@(-15));
            make.bottom.equalTo(@(-20));
        }];
    }
    
    return self;
}

@end
