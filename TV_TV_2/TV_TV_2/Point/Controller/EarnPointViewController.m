//
//  EarnPointViewController.m
//  BTG
//
//  Created by liyy on 2017/11/17.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import "EarnPointViewController.h"
#import "EarnPointViewCell1.h"
#import "EarnPointViewCell2.h"
#import "EarnPointViewCell3.h"
#import "EarnPointViewCell4.h"
#import <Masonry.h>

@interface EarnPointViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) BOOL fingerIsTouch;

@property (nonatomic, retain) NSArray *signs;
@property (nonatomic, retain) NSArray *cards;

@end

@implementation EarnPointViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"赚积分";
    self.view.backgroundColor = [UIColor grayColor];
    
    self.signs = @[ @"每日签到", @"身份认证", @"新手礼赠", @"新手礼赠" ];
    self.cards = @[ @"", @"", @"", @"", @"", @"", @"", @"", @"" ];
    
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
    return 1 + self.signs.count + 1 + self.cards.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {// 礼品
        EarnPointViewCell1 *cell = [EarnPointViewCell1 cellWithTableView:tableView];
        return cell;
    } else if (indexPath.row < (1 + self.signs.count)) {
        EarnPointViewCell2 *cell = [EarnPointViewCell2 cellWithTableView:tableView];
        cell.nameLabel.text = self.signs[indexPath.row - 1];
        
        if (indexPath.row == self.signs.count) {
            cell.lineView.hidden = YES;
        } else {
            cell.lineView.hidden = NO;
        }
        
        return cell;
    } else if (indexPath.row == (1 + self.signs.count)) {
        EarnPointViewCell3 *cell = [EarnPointViewCell3 cellWithTableView:tableView];
        
        // 明细、流出、流入
        [cell setClickBtnIndex:^(int index) {
            if (index == 0) {
                self.cards = @[ @"", @"" ];
            } else if (index == 1) {
                self.cards = @[ @"", @"", @"", @"" ];
            } else {
                self.cards = @[ @"", @"", @"", @"", @"", @"" ];
            }
            [self.tableView reloadData];
        }];
        
        return cell;
    } else {
        EarnPointViewCell4 *cell = [EarnPointViewCell4 cellWithTableView:tableView];
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {// 礼品
        return 150;
    } else if (indexPath.row < (1 + self.signs.count)) {
        return 60;
    } else if (indexPath.row == (1 + self.signs.count)) {
        return 96;
    } else {
        return 134;
    }
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
