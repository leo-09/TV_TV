//
//  UILabel+CustomLab.m
//  BTG
//
//  Created by Dave on 2017/10/30.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import "UILabel+CustomLab.h"

@implementation UILabel (CustomLab)


- (void)setCustomFontWithBold:(BOOL)blod
                     withSize:(CGFloat)size
                withTextColor:(UIColor *)color{
    
    self.textColor = color;
    
    UIFont *font;
    
    if (blod) {
        
        font = [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
        
    }else{
        
        font = [UIFont fontWithName:@"PingFangSC-Regular" size:size];
        
    }
    
    //iOS9之后自带PingFangSC-Regular字体
    if (font) {
        
        self.font = font;
        
    }else{
        
        if (blod) {
            
            self.font = [UIFont boldSystemFontOfSize:size];
            
        }else{
            
            self.font = [UIFont systemFontOfSize:size];
            
        }
        
    }
    
}

- (void)setCustomFontWithBlod:(BOOL)blod
                     withSize:(CGFloat)size
                withTextColor:(UIColor *)color
            withTextAlignment:(NSTextAlignment)aligiment{
    
    self.textColor = color;
    
    UIFont *font;
    
    if (blod) {
        
        font = [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
        
    }else{
        
        font = [UIFont fontWithName:@"PingFangSC-Regular" size:size];
        
    }
    
    //iOS9之后自带PingFangSC-Regular字体
    if (font) {
        
        self.font = font;
        
    }else{
        
        if (blod) {
            
            self.font = [UIFont boldSystemFontOfSize:size];
            
        }else{
            
            self.font = [UIFont systemFontOfSize:size];
            
        }
        
    }
    
    self.textAlignment = aligiment;
    
}

- (void)setCustomFontWithBlod:(BOOL)blod
                     withSize:(CGFloat)size
                withTextColor:(UIColor *)color
            withTextAlignment:(NSTextAlignment)aligiment
                     withText:(NSString *)text;{
    
    self.textColor = color;
    
    UIFont *font;
    
    if (blod) {
        
        font = [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
        
    }else{
        
        font = [UIFont fontWithName:@"PingFangSC-Regular" size:size];
        
    }
    
    //iOS9之后自带PingFangSC-Regular字体
    if (font) {
        
        self.font = font;
        
    }else{
        
        if (blod) {
            
            self.font = [UIFont boldSystemFontOfSize:size];
            
        }else{
            
            self.font = [UIFont systemFontOfSize:size];
            
        }
        
    }
    
    self.textAlignment = aligiment;
    
    self.text = text;
    
}

@end
