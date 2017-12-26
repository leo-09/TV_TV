//
//  BrandHomeViewController.m
//  BTG
//
//  Created by liyy on 2017/11/2.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import "BrandHomeViewController.h"
#import "BrandProductViewController.h"
#import "BrandShopViewController.h"
#import "NestBaseTableView.h"
#import "NestPageContentView.h"
#import "NestContentTableViewCell.h"
#import "BrandHomeHeadView.h"
#import "UIColor+color.h"
#import <Masonry.h>

//屏幕尺寸
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

//状态栏高度
#define Statusbar_Height [[UIApplication sharedApplication] statusBarFrame].size.height

// 状态栏+导航栏的高度
#define HeaderBar_Height (Statusbar_Height + 44)

#define UIColorFromRGBA(rgbValue,trans) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:trans]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface BrandHomeViewController ()<UITableViewDelegate, UITableViewDataSource, NestPageContentViewDelegate>

@property (nonatomic, retain) UIView *navigationView;
@property (nonatomic, retain) CAGradientLayer *navigationLayer;

@property (nonatomic, retain) NestBaseTableView *tableView;             // 主TableView
@property (nonatomic, retain) NestContentTableViewCell *contentCell;    // 底部的唯一的cell

@property (nonatomic, retain) BrandHomeHeadView *titleView;
@property (nonatomic, assign) CGFloat titleViewHeight;
@property (nonatomic, assign) CGFloat tempTitleViewHeight;

@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, retain) NSArray *titles;

@property (nonatomic, retain) CADisplayLink *displayLink;
@property (nonatomic, assign) BOOL isOpenContent;// 点击品牌文化时的展开标志

@end

@implementation BrandHomeViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.model = [[Enterprise alloc] init];
    self.model.entName = @"品牌";
    self.model.fullName = @"胖胖胖";
    
    self.navigationItem.title = self.model.entName;
    [self.navigationController setNavigationBarHidden:YES];
    
    self.titles = @[ @"产品", @"门店" ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];
    
    [self setupSubViews];
    [self addNavigationBar];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark - private method

- (void) addNavigationBar {
    self.navigationView = [[UIView alloc] init];
    // 渐变的背景
    NSArray *colors = @[(__bridge id)UIColorFromRGBA(0x2E3844, 0).CGColor,
                        (__bridge id)UIColorFromRGBA(0x111820, 0).CGColor];
    self.navigationLayer = [UIColor setObliqueGradualChangingColor:self.navigationView
                                                  colors:colors
                                                   frame:CGRectMake(0, 0, SCREEN_WIDTH, HeaderBar_Height)];
    [self.view addSubview:self.navigationView];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@(HeaderBar_Height));
    }];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
    [self.navigationView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@44);
        make.height.equalTo(@44);
    }];
}

- (void)setupSubViews {
    self.canScroll = YES;
    
    [self.view addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(-Statusbar_Height));
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    // 给tableView顶部插入额外的滚动区域,用来显示头部视图
    self.tableView.contentInset = UIEdgeInsetsMake(self.titleViewHeight, 0, 0, 0);
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(-Statusbar_Height));
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
    }];
}

#pragma mark - notify

// 改变主视图的状态
- (void)changeScrollStatus {
    self.canScroll = YES;
    self.contentCell.cellCanScroll = NO;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;   // 只有一个底部的、包含所有滚动ViewContrller的cell
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CGRectGetHeight(self.view.bounds);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _contentCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!_contentCell) {
        _contentCell = [[NestContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        NSMutableArray *contentVCs = [NSMutableArray array];
        
        BrandProductViewController *vc = [[BrandProductViewController alloc] init];
        vc.title = self.titles[0];
        vc.enterpriseID = self.model.enterpriseID;
        [contentVCs addObject:vc];
        
        BrandShopViewController *vc1 = [[BrandShopViewController alloc] init];
        vc1.title = self.titles[1];
        vc1.enterpriseID = self.model.enterpriseID;
        [contentVCs addObject:vc1];
        
        _contentCell.viewControllers = contentVCs;
        _contentCell.pageContentView = [[NestPageContentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) childVCs:contentVCs parentVC:self delegate:self];
        
        _contentCell.contentView.backgroundColor = [UIColor blackColor];
        [_contentCell.contentView addSubview:_contentCell.pageContentView];
    }
    
    return _contentCell;
}

#pragma mark - NestPageContentViewDelegate

// NestPageContentView开始滑动
- (void)NestContentViewWillBeginDragging:(NestPageContentView *)contentView {
    _tableView.scrollEnabled = NO;// pageView开始滚动, 主tableview禁止滑动
}

// NestPageContentView滑动调用
- (void)NestContentViewDidScroll:(NestPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress {
}

// NestPageContentView结束滑动
- (void)NestContenViewDidEndDecelerating:(NestPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    // 此处其实是监测scrollview滚动，pageView滚动结束,主tableview可以滑动(或通过手势监听或者KVO)
    _tableView.scrollEnabled = YES;
}

#pragma mark - UIScrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 第一个section就是headView
    CGFloat bottomCellOffset = -HeaderBar_Height - Statusbar_Height;
    CGFloat y = scrollView.contentOffset.y;
    
    if (y >= -self.titleViewHeight && y <= bottomCellOffset) {
        CGFloat distance = self.titleViewHeight + bottomCellOffset;
        CGFloat trans = (self.titleViewHeight - fabs(y)) / distance;
        trans = trans < 0.2 ? 0 : trans;
        
        self.navigationLayer.colors = @[(__bridge id)UIColorFromRGBA(0x2E3844, trans).CGColor,
                              (__bridge id)UIColorFromRGBA(0x111820, trans).CGColor];
    }
    
    // 点击品牌文化时导致的展开tableView，不需要更新titleView位置
    if (!self.isOpenContent) {
        [self updateWithScrollView];
    }
    
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
}

#pragma mark - 调整titleView的位置

- (void) updateWithScrollView {
    CGFloat endOffset = -HeaderBar_Height-Statusbar_Height;
    
    // 滑动时范围在 startOffset和endOffset之间,调整titleView的位置
    CGFloat startOffset = -self.titleViewHeight;
    CGFloat y = _tableView.contentOffset.y;
    
    if (y >= startOffset && y <= endOffset) {
        CGFloat distance = y - startOffset;
        [self.titleView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(-Statusbar_Height - (distance / 3)));
        }];
    }
}

#pragma mark LazyLoad

- (BrandHomeHeadView *) titleView {
    if (!_titleView) {
        _titleView = [[BrandHomeHeadView alloc] init];
        _titleView.model = self.model;
        self.titleViewHeight = [self.titleView heightForBrandHomeHeadView];
        self.tempTitleViewHeight = _titleViewHeight;
        
        __weak BrandHomeViewController *weakSelf = self;
        [_titleView setOpenContentListener:^(BOOL isLove) {
            weakSelf.titleViewHeight = [weakSelf.titleView heightForBrandHomeHeadView];
            
            weakSelf.isOpenContent = YES;
            [weakSelf.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        }];
    }
    
    return _titleView;
}

- (NestBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[NestBaseTableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.isSetUIEdgeInsetsMake = YES;
    }
    
    return _tableView;
}
- (CADisplayLink *) displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateWidth)];
    }
    
    return _displayLink;
}

- (void) updateWidth {
    if (self.titleViewHeight > self.tempTitleViewHeight) {
        // 展开
        self.tempTitleViewHeight += (self.titleViewHeight - self.tempTitleViewHeight) / 3;
    } else {
        // 收起
        self.tempTitleViewHeight -= (self.tempTitleViewHeight - self.titleViewHeight) / 3;
    }
    
    [self.tableView setContentOffset:CGPointMake(0, -self.tempTitleViewHeight)];
    
    if (fabs(fabs(self.titleViewHeight) - fabs(self.tempTitleViewHeight)) < 0.1) {
        // 给tableView顶部插入额外的滚动区域,用来显示头部视图
        self.tableView.contentInset = UIEdgeInsetsMake(self.tempTitleViewHeight, 0, 0, 0);
        
        self.isOpenContent = NO;
        
        self.displayLink.paused = YES;
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

- (void) back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
