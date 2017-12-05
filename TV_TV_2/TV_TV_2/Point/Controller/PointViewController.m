//
//  PointViewController.m
//  BTG
//
//  Created by Dave on 2017/11/15.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import "PointViewController.h"
#import "EarnPointViewController.h"
#import "UsePointViewController.h"
#import "GivePointViewController.h"
#import "NestBaseTableView.h"
#import "NestPageContentView.h"
#import "NestContentTableViewCell.h"
#import "PointViewHeadCell.h"
#import "PointSegmentTitleView.h"
#import <Masonry.h>

@interface PointViewController ()<UITableViewDelegate, UITableViewDataSource, NestPageContentViewDelegate, NestSegmentTitleViewDelegate>

@property (nonatomic, strong) NestBaseTableView *tableView;             // 主TableView
@property (nonatomic, strong) NestContentTableViewCell *contentCell;    // 底部的唯一的cell
@property (nonatomic, strong) PointSegmentTitleView *titleView;         // 标题栏View
@property (nonatomic, strong) PointViewHeadCell *headCell;

@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, assign) CGFloat nestSegmentTitleViewHeight;

@property (nonatomic, retain) NSArray *titles;

@end

@implementation PointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"积分";

    self.titles = @[ @"赚积分", @"花积分", @"赠积分" ];
    self.nestSegmentTitleViewHeight = 50;
    
    self.canScroll = YES;
    
    self.tableView = [[NestBaseTableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];
}

- (void)insertRowAtTop {
    self.contentCell.currentTagStr = self.titles[self.titleView.selectIndex];
    [self.contentCell refreshData];
}

#pragma mark - notify

// 改变主视图的状态
- (void)changeScrollStatus {
    self.canScroll = YES;
    self.contentCell.cellCanScroll = NO;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;   // 头部View，可以分割成多个cell
    } else {
        return 1;   // 只有一个底部的、包含所有滚动ViewContrller的cell
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 144; // 头View的高度
    } else {
        return CGRectGetHeight(self.view.bounds);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return self.nestSegmentTitleViewHeight;// NestSegmentTitleView 的高度
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), self.nestSegmentTitleViewHeight);
    
    self.titleView = [[PointSegmentTitleView alloc] initWithFrame:frame titles:self.titles delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    
    return self.titleView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *FSBaseTopTableViewCellIdentifier = @"FSBaseTopTableViewCellIdentifier";
    
    if (indexPath.section == 1) {
        _contentCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!_contentCell) {
            _contentCell = [[NestContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
            NSMutableArray *contentVCs = [NSMutableArray array];
            
            EarnPointViewController *vc = [[EarnPointViewController alloc] init];
            vc.marginBottom = -49;
            vc.title = self.titles[0];
            [contentVCs addObject:vc];
            
            UsePointViewController *vc1 = [[UsePointViewController alloc] init];
            vc1.marginBottom = -49;
            vc1.title = self.titles[1];
            [contentVCs addObject:vc1];
            
            GivePointViewController *vc2 = [[GivePointViewController alloc] init];
            vc2.marginBottom = -49;
            vc2.title = self.titles[2];
            [contentVCs addObject:vc2];
            
            _contentCell.viewControllers = contentVCs;
            _contentCell.pageContentView = [[NestPageContentView alloc] initWithFrame:self.view.bounds childVCs:contentVCs parentVC:self delegate:self];
            [_contentCell.contentView addSubview:_contentCell.pageContentView];
        }
        
        return _contentCell;
    }
    
    PointViewHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:FSBaseTopTableViewCellIdentifier];
    if (!cell) {
        cell = [[PointViewHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FSBaseTopTableViewCellIdentifier];
    }
    
    return cell;
}

#pragma mark - NestSegmentTitleViewDelegate

- (void)NestSegmentTitleView:(PointSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    self.contentCell.pageContentView.contentViewCurrentIndex = endIndex;
}

#pragma mark - NestPageContentViewDelegate

// NestPageContentView开始滑动
- (void)NestContentViewWillBeginDragging:(NestPageContentView *)contentView {
    _tableView.scrollEnabled = NO;// pageView开始滚动, 主tableview禁止滑动
}

// NestPageContentView滑动调用
- (void)NestContentViewDidScroll:(NestPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress {
    [self.titleView moveIndicatorViewProgress:progress];
}

// NestPageContentView结束滑动
- (void)NestContenViewDidEndDecelerating:(NestPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    self.titleView.selectIndex = endIndex;
    
    // 此处其实是监测scrollview滚动，pageView滚动结束,主tableview可以滑动(或通过手势监听或者KVO)
    _tableView.scrollEnabled = YES;
}

#pragma mark - UIScrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 第一个section就是headView
    CGFloat bottomCellOffset = [_tableView rectForSection:1].origin.y;
    
    if (scrollView.contentOffset.y >= bottomCellOffset) {
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (self.canScroll) {
            // 主tableView滚动超出第一个section，则设置不可滚动,子tableView设置可滚动
            self.canScroll = NO;
            self.contentCell.cellCanScroll = YES;
        }
    } else {
        // 子视图没到顶部
        if (!self.canScroll) {
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
    }
    
    self.tableView.showsVerticalScrollIndicator = NO;
//    self.tableView.showsVerticalScrollIndicator = _canScroll ? YES : NO;
}

#pragma mark LazyLoad

- (NestBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[NestBaseTableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}

@end
