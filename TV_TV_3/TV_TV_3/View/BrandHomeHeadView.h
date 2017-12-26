//
//  BrandHomHeadCell.h
//  BTG
//
//  Created by liyy on 2017/11/2.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Enterprise.h"

typedef void(^LoveListener)(BOOL isLove);

@interface BrandHomeHeadView : UIView

@property (nonatomic, retain) Enterprise *model;
@property (nonatomic, assign) BOOL isLove;  // 是否标注喜欢

@property (nonatomic, retain) UIView *contentView;
@property (nonatomic, retain) UIView *labelView;
@property (nonatomic, retain) UILabel *contentLabel;

@property (nonatomic, copy) LoveListener openContentListener;

- (CGFloat)heightForBrandHomeHeadView;

@end
