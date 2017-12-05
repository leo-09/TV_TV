//
//  UsePointViewController.m
//  BTG
//
//  Created by liyy on 2017/11/17.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import "UsePointViewController.h"
#import "UsePointViewCell.h"
#import <Masonry.h>

@interface UsePointViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) BOOL fingerIsTouch;

@end

@implementation UsePointViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableView
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@(self.marginBottom));
    }];
}

#pragma mark UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UsePointViewCell *cell = [UsePointViewCell cellWithTableView:tableView];
    
    if (indexPath.row == 0) {
        cell.model = nil;
    } else {
        cell.model = [[NSObject alloc] init];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 150;
    }
    return 282;
}

#pragma mark - UIScrollViewDelegate(以下部分是固定写法)

// 判断屏幕触碰状态
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 接触屏幕
    self.fingerIsTouch = YES;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    // 离开屏幕
    self.fingerIsTouch = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.isShowAlone) {
        self.isCanScroll = YES;
        
        return;
    }
    
    if (!self.isCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    
    if (scrollView.contentOffset.y <= 0) {
        
//        // 这里的作用是在手指离开屏幕后也不让显示主视图
//        if (!self.fingerIsTouch) {
//            return;
//        }
        
        self.isCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        
        // 到顶通知父视图改变状态
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];
    }

    self.tableView.showsVerticalScrollIndicator = NO;
//    self.tableView.showsVerticalScrollIndicator = self.isCanScroll ? YES : NO;
}

@end
