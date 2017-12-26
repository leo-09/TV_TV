//
//  NestSegmentTitleView.m
//  BTG
//
//  Created by liyy on 2017/12/6.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import "NestSegmentTitleView.h"
#import <Masonry.h>

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

static const CGFloat DOT_SIZE = 10;

@interface NestSegmentTitleView()

@property (strong, nonatomic) NSArray *colors;
@property (nonatomic, assign) CGFloat speed;

@property (strong, nonatomic) NSMutableArray *dotViews;

@end

@implementation NestSegmentTitleView

- (instancetype)initWithFrame:(CGRect)frame withPageColors:(NSArray *)colors {
    if (self = [super initWithFrame:frame]) {
        self.colors = colors;
        
        _dotViews = [[NSMutableArray alloc] init];

        [self initViews];
    }
    
    return self;
}

- (void)initViews {
//    UIView *lastView;
    
    // 循环创建、添加View
    for (NSUInteger i = 0; i < self.colors.count; i++) {
        UIView *dotView = [[UIView alloc] init];
        dotView.backgroundColor = self.colors[i];
        dotView.layer.cornerRadius = DOT_SIZE / 2;
        [self addSubview:dotView];
        [dotView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            CGFloat w = DOT_SIZE * 3 * self.colors.count + DOT_SIZE * 1 * (self.colors.count - 1);
            CGFloat marginLeft = (SCREEN_WIDTH - w) / 2;
            make.centerX.equalTo(self.mas_left).offset(marginLeft + DOT_SIZE * (3 + 1) * i + DOT_SIZE * 1.5);
            
//            if (lastView) {
//                make.left.equalTo(lastView.mas_right).offset(DOT_SIZE * 2);
//            } else {
//                CGFloat w = DOT_SIZE * 3 * self.colors.count;
//                CGFloat marginLeft = (SCREEN_WIDTH - w) / 2;
//                make.left.equalTo(@(marginLeft));
//            }
            
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(@(DOT_SIZE));
            if (i == 0) {
                make.width.equalTo(@(DOT_SIZE * 3));
            } else {
                make.width.equalTo(@(DOT_SIZE));
            }
        }];
        
//        lastView = dotView;
        [_dotViews addObject:dotView];
    }
}

- (void)setCurrentPage:(NSInteger)currentPage {
    if (_currentPage == currentPage) {
        return;
    }
    _previousPage = _currentPage;
    _currentPage = currentPage;
    
    _previousPage = _previousPage < 0 ? 0 : _previousPage;
    _previousPage = _previousPage > (self.colors.count - 1) ? (self.colors.count - 1) : _previousPage;
    
    _currentPage = _currentPage < 0 ? 0 : _currentPage;
    _currentPage = _currentPage > (self.colors.count - 1) ? (self.colors.count - 1) : _currentPage;
    
    _speed = DOT_SIZE;
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark - getter/setter

- (void) setProgress:(CGFloat)progress endIndex:(NSInteger)endIndex {
    _progress = progress;
    
    endIndex = endIndex < 0 ? 0 : endIndex;
    endIndex = endIndex > (self.colors.count - 1) ? (self.colors.count - 1) : endIndex;
    UIView *endPageView = _dotViews[endIndex];
    UIView *currentPageView = _dotViews[_currentPage];
    
    CGFloat currentWidth = DOT_SIZE * 3 - fabs(_progress) * (DOT_SIZE * 2);
    CGFloat endWidth = DOT_SIZE + fabs(_progress) * (DOT_SIZE * 2);
    
    currentWidth = currentWidth < DOT_SIZE ? DOT_SIZE : currentWidth;
    currentWidth = currentWidth > DOT_SIZE * 3 ? DOT_SIZE * 3 : currentWidth;
    
    endWidth = endWidth < DOT_SIZE ? DOT_SIZE : endWidth;
    endWidth = endWidth > DOT_SIZE * 3 ? DOT_SIZE * 3 : endWidth;
    
    [currentPageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset(currentWidth);
    }];
    [endPageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset(endWidth);
    }];
}

- (CADisplayLink *) displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateWidth)];
    }
    
    return _displayLink;
}

- (void) updateWidth {
    UIView *previousPageView = _dotViews[_previousPage];
    UIView *currentPageView = _dotViews[_currentPage];
    
    CGFloat distance = (1 - fabs(_progress)) * (DOT_SIZE * 2);
    _speed += 0.6;
    if (_speed > distance) {
        self.displayLink.paused = YES;
        [self.displayLink invalidate];
        self.displayLink = nil;

        return;
    }
    
    CGFloat previousWidth = DOT_SIZE * 3 - fabs(_progress) * (DOT_SIZE * 2) - _speed;
    CGFloat currentWidth = DOT_SIZE + fabs(_progress) * (DOT_SIZE * 2) + _speed;
    
    [previousPageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset(previousWidth);
    }];
    [currentPageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset(currentWidth);
    }];
}

@end
