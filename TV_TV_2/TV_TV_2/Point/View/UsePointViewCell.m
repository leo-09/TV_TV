//
//  UsePointViewCell.m
//  BTG
//
//  Created by liyy on 2017/11/17.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import "UsePointViewCell.h"
#import <Masonry.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation UsePointViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"UsePointViewCell";
    // 1.缓存中
    UsePointViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[UsePointViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        
        _giftIV = [[UIImageView alloc] init];
        _giftIV.image = [UIImage imageNamed:@"home_background"];
        [self addSubview:_giftIV];
        [_giftIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@20);
            make.left.equalTo(@15);
            make.right.equalTo(@(-15));
            make.bottom.equalTo(@(-20));
        }];
        
        _infoIV = [[UIImageView alloc] init];
        _infoIV.image = [UIImage imageNamed:@"home_background"];
        [self addSubview:_infoIV];
        [_infoIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.height.equalTo(@214);
        }];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"全聚德烤鸭店";
        _nameLabel.font = [UIFont systemFontOfSize:16.0];
        _nameLabel.textColor = UIColorFromRGB(0x333333);
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.equalTo(_infoIV.mas_bottom).offset(10);
        }];
        
        _distanceLabel = [[UILabel alloc] init];
        _distanceLabel.text = @"距离1.88km";
        _distanceLabel.font = [UIFont systemFontOfSize:12.0];
        _distanceLabel.textColor = UIColorFromRGB(0xbfbfbf);
        [self addSubview:_distanceLabel];
        [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-15));
            make.top.equalTo(_infoIV.mas_bottom).offset(10);
        }];
        
        _discountLabel = [[UILabel alloc] init];
        _discountLabel.text = @"折扣3.9";
        _discountLabel.font = [UIFont systemFontOfSize:12.0];
        _discountLabel.textColor = UIColorFromRGB(0xc2a070);
        [self addSubview:_discountLabel];
        [_discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLabel.mas_left);
            make.bottom.equalTo(@(-10));
        }];
    }
    
    return self;
}

- (void) setModel:(NSObject *)model {
    if (model) {
        _giftIV.hidden = YES;
        
        _infoIV.hidden = NO;
        _nameLabel.hidden = NO;
        _distanceLabel.hidden = NO;
        _discountLabel.hidden = NO;
    } else {
        _giftIV.hidden = NO;
        
        _infoIV.hidden = YES;
        _nameLabel.hidden = YES;
        _distanceLabel.hidden = YES;
        _discountLabel.hidden = YES;
    }
}

@end
