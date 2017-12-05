//
//  EarnPointViewCell.m
//  BTG
//
//  Created by liyy on 2017/11/17.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import "EarnPointViewCell4.h"
#import <Masonry.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation EarnPointViewCell4

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"EarnPointViewCell4";
    // 1.缓存中
    EarnPointViewCell4 *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[EarnPointViewCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.right.equalTo(@(-15));
            make.top.equalTo(@0);
            make.bottom.equalTo(@(-16));
        }];
        
        _bgView.layer.shadowOffset = CGSizeMake(1, 1); // 偏移距离
        _bgView.layer.shadowOpacity = 0.5f; // 不透明度
        _bgView.layer.shadowColor = UIColorFromRGB(0xc9c9c9).CGColor;// 阴影颜色
        _bgView.layer.cornerRadius = 8.0;
        _bgView.layer.shadowRadius = 5.0;
        
        // 卡券名称
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"燕莎代金券";
        _nameLabel.font = [UIFont systemFontOfSize:18.0];
        _nameLabel.textColor = UIColorFromRGB(0x877d7d);
        [_bgView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@15);
            make.left.equalTo(@15);
        }];
        
        // 时间
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.text = @"2017.5.1 10:30";
        _timeLabel.font = [UIFont systemFontOfSize:15.0];
        _timeLabel.textColor = UIColorFromRGB(0x877d7d);
        [_bgView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-15));
            make.centerY.equalTo(_nameLabel);
        }];
        
        _pointLabel = [[UILabel alloc] init];
        _pointLabel.textAlignment = NSTextAlignmentRight;
        _pointLabel.text = @"+100 积分";
        _pointLabel.font = [UIFont systemFontOfSize:16.0];
        _pointLabel.textColor = UIColorFromRGB(0x5eb37a);
        [_bgView addSubview:_pointLabel];
        [_pointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_timeLabel.mas_right);
            make.top.equalTo(_timeLabel.mas_bottom).offset(15);
        }];
        
        _styleLabel = [[UILabel alloc] init];
        _styleLabel.textAlignment = NSTextAlignmentRight;
        _styleLabel.text = @"线下消费";
        _styleLabel.font = [UIFont systemFontOfSize:15.0];
        _styleLabel.textColor = UIColorFromRGB(0x877d7d);
        [_bgView addSubview:_styleLabel];
        [_styleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_timeLabel.mas_right);
            make.bottom.equalTo(@(-15));
        }];
    }
    
    return self;
}

@end
