//
//  NestContentTableViewCell.h
//  TV_TV
//
//  Created by liyy on 2017/10/31.
//  Copyright © 2017年 ccdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NestPageContentView.h"

/**
 底部的、包含所有滚动ViewContrller的cell
 */
@interface NestContentTableViewCell : UITableViewCell

@property (nonatomic, strong) NestPageContentView *pageContentView; // 内容View

@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, assign) BOOL cellCanScroll;

@property (nonatomic, assign) int currentIndex;

- (void) refreshData;

@end
