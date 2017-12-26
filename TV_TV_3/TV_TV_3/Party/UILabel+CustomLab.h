//
//  UILabel+CustomLab.h
//  BTG
//
//  Created by Dave on 2017/10/30.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CustomLab)


/**
 
 设置字体大小和颜色
 */
- (void)setCustomFontWithBold:(BOOL)blod
                     withSize:(CGFloat)size
                withTextColor:(UIColor *)color;

/**
 
 设置字体大小和颜色和对齐方式
 */
- (void)setCustomFontWithBlod:(BOOL)blod
                     withSize:(CGFloat)size
                withTextColor:(UIColor *)color
            withTextAlignment:(NSTextAlignment)aligiment;

/**
 
 设置字体大小和颜色和对齐方式和文字
 */
- (void)setCustomFontWithBlod:(BOOL)blod
                     withSize:(CGFloat)size
                withTextColor:(UIColor *)color
            withTextAlignment:(NSTextAlignment)aligiment
                     withText:(NSString *)text;

@end
