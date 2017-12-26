//
//  UIColor+color.m
//  BTG
//
//  Created by Dave on 2017/11/15.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import "UIColor+color.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation UIColor (color)

+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr{
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)UIColorFromRGB(0xffbd00).CGColor,
                             (__bridge id)UIColorFromRGB(0xff5b09).CGColor];
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    
    return gradientLayer;
}

+ (CAGradientLayer *) setGradualChangingColor:(UIView *)view frame:(CGRect)frame {
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = frame;
    [view.layer addSublayer:layer];
    
    // 设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);
    // 设置颜色变化点，取值范围 0.0~1.0
    layer.locations = @[@0, @1];
    // 创建渐变色数组，需要转换为CGColor颜色
    layer.colors = @[(__bridge id)UIColorFromRGB(0xffbd00).CGColor,
                     (__bridge id)UIColorFromRGB(0xff5b09).CGColor];
    
    return layer;
}

// 设置左下->右上的渐变色
+ (CAGradientLayer *) setObliqueGradualChangingColor:(UIView *)view colors:(NSArray *)colors frame:(CGRect)frame {
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = frame;
    [view.layer addSublayer:layer];
    
    // 设置渐变颜色方向
    layer.startPoint = CGPointMake(0, 1);
    layer.endPoint = CGPointMake(1, 0);
    // 设置颜色变化点，取值范围 0.0~1.0
    layer.locations = @[@0, @1];
    // 创建渐变色数组，需要转换为CGColor颜色
    layer.colors = colors;
    
    return layer;
}

@end
