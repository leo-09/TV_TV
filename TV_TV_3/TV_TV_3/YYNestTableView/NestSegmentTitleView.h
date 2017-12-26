//
//  NestSegmentTitleView.h
//  BTG
//
//  Created by liyy on 2017/12/6.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NestSegmentTitleView : UIView

@property (nonatomic, assign) NSInteger previousPage;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, retain) CADisplayLink *displayLink;

- (instancetype)initWithFrame:(CGRect)frame withPageColors:(NSArray *)colors;
- (void) setProgress:(CGFloat)progress endIndex:(NSInteger)endIndex;

@end
