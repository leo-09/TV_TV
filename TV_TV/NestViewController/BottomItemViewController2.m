//
//  BottomItemViewController2.m
//  TV_TV
//
//  Created by liyy on 2017/10/31.
//  Copyright © 2017年 ccdc. All rights reserved.
//

#import "BottomItemViewController2.h"
#import <SVPullToRefresh.h>

#define RandomData [NSString stringWithFormat:@"cell---%d", arc4random_uniform(1000000)]

@interface BottomItemViewController2 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) BOOL fingerIsTouch;

@property (strong, nonatomic) NSMutableArray *data;// 用来显示的假数据

@end

@implementation BottomItemViewController2

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    // 设置tableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    // 上拉加载
    __weak typeof(self) weakSelf = self;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertRowAtBottom];
    }];
}

#pragma mark LazyLoad

- (NSMutableArray *)data {
    if (!_data) {
        self.data = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
            [self.data addObject:RandomData];
        }
    }
    
    return _data;
}

#pragma mark Setter

- (void) refreshData {
    [self insertRowAtTop];
}

- (void)insertRowAtTop {
    for (int i = 0; i < 5; i++) {
        [self.data insertObject:RandomData atIndex:0];
    }
    
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView reloadData];
        
        // 完成刷新数据，则通知关闭动画
        [[NSNotificationCenter defaultCenter] postNotificationName:@"completeRefreshData" object:nil];
    });
}

- (void)insertRowAtBottom {
    for (int i = 0; i<5; i++) {
        [self.data addObject:RandomData];
    }
    
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView reloadData];
        [tableView.infiniteScrollingView stopAnimating];
    });
}

#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"2--%@", self.data[indexPath.row]];
    
    // 根据具体需求，画不同的UI
    
    return cell;
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
    if (!self.isCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    
    if (scrollView.contentOffset.y <= 0) {
        
        // 这里的作用是在手指离开屏幕后也不让显示主视图
        if (!self.fingerIsTouch) {
            return;
        }
        
        self.isCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        
        // 到顶通知父视图改变状态
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];
    }
    
    self.tableView.showsVerticalScrollIndicator = self.isCanScroll ? YES : NO;
}

@end
