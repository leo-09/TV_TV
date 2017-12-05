//
//  NestItemViewController.h
//  TV_TV
//
//  Created by liyy on 2017/10/31.
//  Copyright © 2017年 ccdc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 各个内容ViewController的基类
 */
@interface NestItemViewController : UIViewController

// 每个ViewController由UITableView构成
@property (nonatomic, strong) UITableView *tableView;

// 是否可以滑动
@property (nonatomic, assign) BOOL isCanScroll;

/**
 下拉刷新
 */
- (void) refreshData;

@end
