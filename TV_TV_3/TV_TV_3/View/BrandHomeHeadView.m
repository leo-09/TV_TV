//
//  BrandHomHeadCell.m
//  BTG
//
//  Created by liyy on 2017/11/2.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import "BrandHomeHeadView.h"
#import "UILabel+lineSpace.h"
#import "UILabel+ChangeLineSpaceAndWordSpace.h"
#import "UILabel+CustomLab.h"
#import <Masonry.h>

//状态栏高度
#define Statusbar_Height [[UIApplication sharedApplication] statusBarFrame].size.height
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define UIColorFromRGBA(rgbValue,trans) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:trans]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

static int contentLabelNumberOfLines = 2;

@interface BrandHomeHeadView()

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UIButton *loveBtn;

@end

@implementation BrandHomeHeadView

- (instancetype) init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
        }];
        
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brand_home_header"]];
        [_contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.height.equalTo(@200);
        }];
        
        // 喜欢
        _loveBtn = [[UIButton alloc] init];
        [_loveBtn setImage:[UIImage imageNamed:@"dislike"] forState:UIControlStateNormal];
        [_loveBtn setImage:[UIImage imageNamed:@"love"] forState:UIControlStateSelected];
        [_loveBtn addTarget:self action:@selector(love:) forControlEvents:UIControlEventTouchDown];
        [_contentView addSubview:_loveBtn];
        [_loveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@0);
            make.bottom.equalTo(iv.mas_bottom);
            make.width.equalTo(@50);
            make.height.equalTo(@50);
        }];
        
        _labelView = [[UIView alloc] init];
        _labelView.backgroundColor = [UIColor whiteColor];
        [_contentView addSubview:_labelView];
        [_labelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.top.equalTo(iv.mas_bottom);
            make.bottom.equalTo(@0);
        }];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openContentGesture)];
        [_labelView addGestureRecognizer:gesture];
        
//        CGFloat radius = 5;
//        // 添加左上的圆角
//        UIView *scrollLeftTopView = [[UIView alloc] init];
//        [_contentView addSubview:scrollLeftTopView];
//        [scrollLeftTopView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_labelView);
//            make.left.equalTo(_labelView);
//            make.width.equalTo(@(radius));
//            make.height.equalTo(@(radius));
//        }];
//        // 设置圆角
//        UIBezierPath *leftTopPath = [UIBezierPath bezierPath];
//        [leftTopPath moveToPoint:CGPointMake(0, 0)];
//        [leftTopPath addLineToPoint:CGPointMake(0, radius)];
//        [leftTopPath addArcWithCenter:CGPointMake(radius, radius) radius:radius startAngle:M_PI endAngle:M_PI * 1.5 clockwise:YES];
//        [leftTopPath addLineToPoint:CGPointMake(0, 0)];
//        CAShapeLayer *leftTopLayer = [[CAShapeLayer alloc] init];
//        leftTopLayer.path = leftTopPath.CGPath;
//        leftTopLayer.strokeColor = [UIColor clearColor].CGColor;
//        leftTopLayer.fillColor = [UIColor blackColor].CGColor;
//        [scrollLeftTopView.layer addSublayer:leftTopLayer];
//
//        // 添加右上的圆角
//        UIView *scrollRightTopView = [[UIView alloc] init];
//        [_contentView addSubview:scrollRightTopView];
//        [scrollRightTopView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_labelView);
//            make.right.equalTo(_labelView);
//            make.width.equalTo(@(radius));
//            make.height.equalTo(@(radius));
//        }];
//        // 设置圆角
//        UIBezierPath *rightTopPath = [UIBezierPath bezierPath];
//        [rightTopPath moveToPoint:CGPointMake(0, 0)];
//        [rightTopPath addArcWithCenter:CGPointMake(0, radius) radius:radius startAngle:M_PI * 1.5 endAngle:M_PI * 2 clockwise:YES];
//        [rightTopPath addLineToPoint:CGPointMake(radius, 0)];
//        [rightTopPath addLineToPoint:CGPointMake(0, 0)];
//        CAShapeLayer *rightTopLayer = [[CAShapeLayer alloc] init];
//        rightTopLayer.path = rightTopPath.CGPath;
//        rightTopLayer.strokeColor = [UIColor clearColor].CGColor;
//        rightTopLayer.fillColor = [UIColor blackColor].CGColor;
//        [scrollRightTopView.layer addSublayer:rightTopLayer];
        
        // 标题 高44
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"全聚德";
        [_nameLabel setCustomFontWithBold:YES withSize:18 withTextColor:UIColorFromRGB(0x000000)];
        [_labelView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.right.equalTo(@(-10));
            make.top.equalTo(iv.mas_bottom).offset(10);
            make.height.equalTo(@22);
        }];
        
        // 内容
        _contentLabel = [[UILabel alloc] init];
        [_contentLabel setCustomFontWithBold:NO withSize:12 withTextColor:UIColorFromRGB(0x000000)];
        _contentLabel.numberOfLines = contentLabelNumberOfLines;
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [_labelView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-10));
            make.left.equalTo(@10);
            make.top.equalTo(_nameLabel.mas_bottom).offset(10);
        }];
    }
    
    return self;
}

- (void) setModel:(Enterprise *)model {
    _model = model;
    
    _nameLabel.text = model.fullName;
    _contentLabel.text = model.culture;
    [UILabel changeLineSpaceForLabel:_contentLabel WithSpace:4];
}

- (CGFloat)heightForBrandHomeHeadView {
    CGFloat height = 200 + 44 + 5 + 0;// 分割高度5 + 0
    
    // 内容高度
    _contentLabel.text = _model.culture;
    CGFloat infoHeight = [_contentLabel labelHeightWithLineSpace:4 WithWidth:(SCREEN_WIDTH - 10 * 2) WithNumline:contentLabelNumberOfLines].height;
    height += infoHeight;       // 内容的高度
    
    return height;
}

- (void) openContentGesture {
    if (contentLabelNumberOfLines == 0) {
        contentLabelNumberOfLines = 2;
    } else {
        contentLabelNumberOfLines = 0;
    }
    
    if (self.openContentListener) {
        self.openContentListener(YES);
    }
}

#pragma mark - click event

- (void) love:(UIButton *)btn {
    btn.selected = !btn.selected;
    _isLove = btn.selected;
}

#pragma mark - setter

- (void) setIsLove:(BOOL)isLove {
    _isLove = isLove;
    
    if (_isLove) {
        _loveBtn.selected = YES;
    }
}

@end
