//
//  NestContentTableViewCell.m
//  TV_TV
//
//  Created by liyy on 2017/10/31.
//  Copyright © 2017年 ccdc. All rights reserved.
//

#import "NestContentTableViewCell.h"
#import "NestItemViewController.h"

@implementation NestContentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

#pragma mark - Setter

- (void)setViewControllers:(NSMutableArray *)viewControllers {
    _viewControllers = viewControllers;
}

- (void)setCellCanScroll:(BOOL)cellCanScroll {
    _cellCanScroll = cellCanScroll;
    
    for (NestItemViewController *VC in _viewControllers) {
        VC.isCanScroll = cellCanScroll;
        
        // 如果cell不能滑动，代表到了顶部，修改所有子vc的状态回到顶部
        if (!cellCanScroll) {
            VC.tableView.contentOffset = CGPointZero;
        }
    }
}

- (void) refreshData {
    for (NestItemViewController *ctrl in self.viewControllers) {
        if ([ctrl.title isEqualToString:self.currentTagStr]) {
            [ctrl refreshData];
        }
    }
}

@end
