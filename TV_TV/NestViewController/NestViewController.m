//
//  NestViewController.m
//  TV_TV
//
//  Created by liyy on 2017/10/31.
//  Copyright © 2017年 ccdc. All rights reserved.
//

#import "NestViewController.h"
#import "BottomItemViewController.h"
#import "BottomItemViewController2.h"
#import "BottomItemViewController3.h"

#import "NestBaseTableView.h"
#import "NestPageContentView.h"
#import "NestSegmentTitleView.h"
#import "NestContentTableViewCell.h"

#import "HeadTableViewCell.h"
#import <SVPullToRefresh.h>

#define KSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define KSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface NestViewController ()<UITableViewDelegate, UITableViewDataSource, NestPageContentViewDelegate, NestSegmentTitleViewDelegate>

@property (nonatomic, strong) NestBaseTableView *tableView;             // 主TableView
@property (nonatomic, strong) NestContentTableViewCell *contentCell;    // 底部的唯一的cell
@property (nonatomic, strong) NestSegmentTitleView *titleView;          // 标题栏View

@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, assign) CGFloat nestSegmentTitleViewHeight;

@property (nonatomic, retain) NSArray *titles;

@end

@implementation NestViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"TV嵌套TV";
    self.titles = @[ @"经典产品产品", @"会员权益", @"最新评价" ];
    
    self.nestSegmentTitleViewHeight = 50;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self setupSubViews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(completeRefreshData) name:@"completeRefreshData" object:nil];
}

- (void)setupSubViews {
    self.canScroll = YES;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
//    // 刷新控件
//    __weak typeof(self) weakSelf = self;
//    [self.tableView addPullToRefreshWithActionHandler:^{
//        [weakSelf insertRowAtTop];
//    }];
}

- (void)insertRowAtTop {
    self.contentCell.currentTagStr = self.titles[self.titleView.selectIndex];
    [self.contentCell refreshData];
}

#pragma mark - notify

- (void) completeRefreshData {
    [self.tableView.pullToRefreshView stopAnimating];
}

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
        return 200; // 头View的高度
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
    
    self.titleView = [[NestSegmentTitleView alloc] initWithFrame:frame
                                                        titles:self.titles
                                                      delegate:self
                                                 indicatorType:FSIndicatorTypeEqualTitle];
    self.titleView.contentView.backgroundColor = [UIColor lightGrayColor];
    
    // TODO 动态修改section的高度，效果差
    self.titleView.contentView.hidden = YES;
    
    return self.titleView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *FSBaseTopTableViewCellIdentifier = @"FSBaseTopTableViewCellIdentifier";
    
    if (indexPath.section == 1) {
        _contentCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!_contentCell) {
            _contentCell = [[NestContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
            NSMutableArray *contentVCs = [NSMutableArray array];
            
            BottomItemViewController *vc = [[BottomItemViewController alloc] init];
            vc.title = self.titles[0];
            [contentVCs addObject:vc];
            
            BottomItemViewController2 *vc1 = [[BottomItemViewController2 alloc] init];
            vc1.title = self.titles[1];
            [contentVCs addObject:vc1];
            
            BottomItemViewController3 *vc2 = [[BottomItemViewController3 alloc] init];
            vc2.title = self.titles[2];
            [contentVCs addObject:vc2];
            
            _contentCell.viewControllers = contentVCs;
            _contentCell.pageContentView = [[NestPageContentView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - 64) childVCs:contentVCs parentVC:self delegate:self];
            [_contentCell.contentView addSubview:_contentCell.pageContentView];
        }
        
        return _contentCell;
    }
    
    HeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FSBaseTopTableViewCellIdentifier];
    if (!cell) {
        cell = [[HeadTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FSBaseTopTableViewCellIdentifier];
    }
    
    return cell;
    
    return nil;
}

#pragma mark - NestSegmentTitleViewDelegate

- (void)NestSegmentTitleView:(NestSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
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
    CGFloat bottomCellOffset = [_tableView rectForSection:1].origin.y - 64;
    
    if (scrollView.contentOffset.y >= bottomCellOffset) {
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (self.canScroll) {
            // 主tableView滚动超出第一个section，则设置不可滚动,子tableView设置可滚动
            self.canScroll = NO;
            self.contentCell.cellCanScroll = YES;
        }
        
        // TODO 动态修改section的高度，效果差
        if (self.titleView.contentView.isHidden) {
            self.titleView.contentView.hidden = NO;
        }
        
    } else {
        // 子视图没到顶部
        if (!self.canScroll) {
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
        
        // TODO 动态修改section的高度，效果差
        if (!self.titleView.contentView.isHidden) {
            self.titleView.contentView.hidden = YES;
        }
        
    }
    
    self.tableView.showsVerticalScrollIndicator = _canScroll ? YES : NO;
}

#pragma mark LazyLoad

- (NestBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[NestBaseTableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

@end
