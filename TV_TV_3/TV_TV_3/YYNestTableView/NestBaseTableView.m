//
//  NestBaseTableView.m
//  TV_TV
//
//  Created by liyy on 2017/10/31.
//  Copyright © 2017年 ccdc. All rights reserved.
//

#import "NestBaseTableView.h"

@implementation NestBaseTableView

/**
 同时识别多个手势
 
 @param gestureRecognizer gestureRecognizer description
 @param otherGestureRecognizer otherGestureRecognizer description
 @return return value description
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

// 作用:判断下传入过来的点在不在方法调用者的坐标系上
// point:是方法调用者坐标系上的点
- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event {
    if (_isSetUIEdgeInsetsMake) {
        if (point.y < 0) {
            return NO;
        } else {
            return YES;
        }
    } else {
        return [super pointInside:point withEvent:event];
    }
}

@end
