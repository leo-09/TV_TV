//
//  UIButton+CustomBtn.h
//  CCDCBaseFrame
//
//  Created by 陈舟为 on 2017/8/18.
//  Copyright © 2017年 DaveChen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DCButtonEdgeInsetsStyle) {
    DCButtonEdgeInsetsStyleTop, // image在上，label在下
    DCButtonEdgeInsetsStyleLeft, // image在左，label在右
    DCButtonEdgeInsetsStyleBottom, // image在下，label在上
    DCButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (CustomBtn)

/**
 
 改变布局
 */
- (void)layoutButtonWithEdgeInsetsStyle:(DCButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

/**
 设置layer
 */
- (void)setUpLayerWithBorderWidth:(CGFloat)width
                  withBorderColor:(UIColor *)color
                 withcornerRadius:(CGFloat)radius
                 withMasksToBounds:(BOOL)bounds;

/**
 设置基本属性
 */
- (void)setUpBasePropertyWithBlod:(BOOL)blod
                         withFont:(CGFloat)font
                  withTittleColor:(UIColor *)color
                        withState:(UIControlState)state
                       withTittle:(NSString *)tittle;

/**
 设置属性
 */
- (void)setUpPropertyWithBlod:(BOOL)blod
                     withFont:(CGFloat)font
              withTittleColor:(UIColor *)color
                    withImage:(NSString *)imgName
                    withState:(UIControlState)state
                   withTittle:(NSString *)tittle;

/**
 
 设置图片
 
 */
- (void)setUpImageName:(NSString *)name
      withContentModel:(UIViewContentMode)model
             withState:(UIControlState)state;

/**
 
 font和颜色
 */
- (void)setUpBasePropertyWithBlod:(BOOL)blod
                         withFont:(CGFloat)font
                  withTittleColor:(UIColor *)color
                        withState:(UIControlState)state;


@end
