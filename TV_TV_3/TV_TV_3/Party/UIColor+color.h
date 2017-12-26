//
//  UIColor+color.h
//  BTG
//
//  Created by Dave on 2017/11/15.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (color)

/**
 渐变色
 */
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;

+ (CAGradientLayer *) setGradualChangingColor:(UIView *)view frame:(CGRect)frame;

/**
 设置左下->右上的渐变色
 
 @param view view
 @param colors 色值
 @param frame frame
 */
+ (CAGradientLayer *) setObliqueGradualChangingColor:(UIView *)view colors:(NSArray *)colors frame:(CGRect)frame;

@end
