//
//  ShopViewController.m
//  BTG
//
//  Created by liyy on 2017/11/2.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import "BrandShopViewController.h"
#import "BrandShopCell.h"
#import "UILabel+CustomLab.h"
#import "UIColor+color.h"
#import <Masonry.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

static CGFloat sectionHeight = 38;

@interface BrandShopViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) BOOL fingerIsTouch;

@end

@implementation BrandShopViewController

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
        make.bottom.equalTo(@0);
    }];
}

#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        BrandShopCell *cell = [BrandShopCell cellWithTableView:tableView];
        return cell;
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 130;
    } else {
        return 20;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return sectionHeight;
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor blackColor];
        
        NSArray *colors = @[(__bridge id)UIColorFromRGB(0xFFBD00).CGColor,
                            (__bridge id)UIColorFromRGB(0x00AFB4).CGColor];
        
        CGRect rect = [tableView rectForSection:0];
        CGFloat ivHeight = 6;
        CGRect ivFrame = CGRectMake(0, 0, rect.size.width, ivHeight);
        UIView *bgView = [[UIView alloc] initWithFrame:ivFrame];
        [UIColor setObliqueGradualChangingColor:bgView colors:colors frame:ivFrame];
        [view addSubview:bgView];
        // 设置圆角
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:ivFrame byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = ivFrame;// 设置大小
        maskLayer.path = maskPath.CGPath;// 设置图形样子
        bgView.layer.mask = maskLayer;
        
        CGRect labelViewFrame = CGRectMake(0, ivHeight-1, rect.size.width, sectionHeight-ivHeight+1);
        UIView *labelView = [[UIView alloc] initWithFrame:labelViewFrame];
        labelView.backgroundColor = UIColorFromRGB(0xf1f1f1);
        [view addSubview:labelView];
        
        CGRect labelFrame = CGRectMake(16, 0, labelViewFrame.size.width-30, labelViewFrame.size.height);
        UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
        label.text = @"门店产品";
        label.textColor = UIColorFromRGB(0x000000);
        [label setCustomFontWithBold:YES withSize:16.0 withTextColor:UIColorFromRGB(0x000000)];
        [labelView addSubview:label];
        
        return view;
    } else {
        return [[UIView alloc] init];
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
        self.isCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        
        // 到顶通知父视图改变状态
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];
    }
    
    self.tableView.showsVerticalScrollIndicator = NO;
}

@end
