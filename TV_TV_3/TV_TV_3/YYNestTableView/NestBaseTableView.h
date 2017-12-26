//
//  NestBaseTableView.h
//  TV_TV
//
//  Created by liyy on 2017/10/31.
//  Copyright © 2017年 ccdc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 主TableView，该UITableView可以同时识别多个手势
 */
@interface NestBaseTableView : UITableView<UIGestureRecognizerDelegate>

// 设置了UIEdgeInsetsMake，则需要保证其后的View可响应事件
@property (nonatomic, assign) BOOL isSetUIEdgeInsetsMake;

@end
