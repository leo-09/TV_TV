//
//  UIButton+CustomBtn.m
//  CCDCBaseFrame
//
//  Created by 陈舟为 on 2017/8/18.
//  Copyright © 2017年 DaveChen. All rights reserved.
//

#import "UIButton+CustomBtn.h"

@implementation UIButton (CustomBtn)


- (void)layoutButtonWithEdgeInsetsStyle:(DCButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space
{
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case DCButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case DCButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case DCButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case DCButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
    
}

- (void)setUpLayerWithBorderWidth:(CGFloat)width
                  withBorderColor:(UIColor *)color
                 withcornerRadius:(CGFloat)radius
                 withMasksToBounds:(BOOL)bounds{
    
    self.layer.borderColor = color.CGColor;
    
    self.layer.borderWidth = width;
    
    self.layer.cornerRadius = radius;
    
    self.layer.masksToBounds = bounds;
    
}

- (void)setUpBasePropertyWithBlod:(BOOL)blod
                         withFont:(CGFloat)font
                  withTittleColor:(UIColor *)color
                        withState:(UIControlState)state
                       withTittle:(NSString *)tittle{
    
    UIFont *cfont;
    
    if (blod) {
        
        cfont = [UIFont fontWithName:@"PingFangSC-Semibold" size:font];
        
    }else{
        
        cfont = [UIFont fontWithName:@"PingFangSC-Regular" size:font];
        
    }
    
    //iOS9之后自带PingFangSC-Regular字体
    if (cfont) {
        
        self.titleLabel.font = cfont;
        
    }else{
        
        if (blod) {
            
            self.titleLabel.font = [UIFont boldSystemFontOfSize:font];
            
        }else{
            
            self.titleLabel.font = [UIFont systemFontOfSize:font];
            
        }
    }
    
    [self setTitleColor:color forState:state];
    
    [self setTitle:tittle forState:state];
    
}

- (void)setUpPropertyWithBlod:(BOOL)blod
                     withFont:(CGFloat)font
              withTittleColor:(UIColor *)color
                    withImage:(NSString *)imgName
                    withState:(UIControlState)state
                   withTittle:(NSString *)tittle{
    
    UIFont *cfont;
    
    if (blod) {
        
        cfont = [UIFont fontWithName:@"PingFangSC-Semibold" size:font];
        
    }else{
        
        cfont = [UIFont fontWithName:@"PingFangSC-Regular" size:font];
        
    }
    
    //iOS9之后自带PingFangSC-Regular字体
    if (cfont) {
        
        self.titleLabel.font = cfont;
        
    }else{
        
        if (blod) {
            
            self.titleLabel.font = [UIFont boldSystemFontOfSize:font];
            
        }else{
            
            self.titleLabel.font = [UIFont systemFontOfSize:font];
            
        }
    }
    
    
    [self setTitleColor:color forState:state];
    
    [self setTitle:tittle forState:state];
    
    [self setImage:[UIImage imageNamed:imgName] forState:state];
    
    
}

- (void)setUpImageName:(NSString *)name
      withContentModel:(UIViewContentMode)model
             withState:(UIControlState)state{
    
    [self setImage:[UIImage imageNamed:name] forState:state];
    
    self.imageView.contentMode = model;
    
}

- (void)setUpBasePropertyWithBlod:(BOOL)blod
                         withFont:(CGFloat)font
                  withTittleColor:(UIColor *)color
                        withState:(UIControlState)state{
    
    UIFont *cfont;
    
    if (blod) {
        
        cfont = [UIFont fontWithName:@"PingFangSC-Semibold" size:font];
        
    }else{
        
        cfont = [UIFont fontWithName:@"PingFangSC-Regular" size:font];
        
    }
    
    //iOS9之后自带PingFangSC-Regular字体
    if (cfont) {
        
        self.titleLabel.font = cfont;
        
    }else{
        
        if (blod) {
            
            self.titleLabel.font = [UIFont boldSystemFontOfSize:font];
            
        }else{
            
            self.titleLabel.font = [UIFont systemFontOfSize:font];
            
        }
        
    }
    
    [self setTitleColor:color forState:UIControlStateNormal];
    
}


@end
