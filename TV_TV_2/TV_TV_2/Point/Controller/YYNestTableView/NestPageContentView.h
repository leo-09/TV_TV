//
//  NestPageContentView.h
//  TV_TV
//
//  Created by liyy on 2017/10/31.
//  Copyright © 2017年 ccdc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 滚动View(NestPageContentView)的协议
 */
@class NestPageContentView;

@protocol NestPageContentViewDelegate <NSObject>

@optional

/**
 NestPageContentView开始滑动
 
 @param contentView NestPageContentView
 */
- (void)NestContentViewWillBeginDragging:(NestPageContentView *)contentView;

/**
 NestPageContentView滑动调用
 
 @param contentView NestPageContentView
 @param startIndex 开始滑动页面索引
 @param endIndex 结束滑动页面索引
 @param progress 滑动进度
 */
- (void)NestContentViewDidScroll:(NestPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress;

/**
 NestPageContentView结束滑动
 
 @param contentView NestPageContentView
 @param startIndex 开始滑动索引
 @param endIndex 结束滑动索引
 */
- (void)NestContenViewDidEndDecelerating:(NestPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex;

@end


/**
 在底部cell中的、可以设置tableView的左右滑动的UIView
 */
@interface NestPageContentView : UIView

/**
 对象方法创建FSPageContentView
 
 @param frame frame
 @param childVCs 子VC数组
 @param parentVC 父视图VC
 @param delegate delegate
 @return FSPageContentView
 */
- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC delegate:(id<NestPageContentViewDelegate>)delegate;

@property (nonatomic, weak) id<NestPageContentViewDelegate>delegate;

/**
 设置contentView当前展示的页面索引，默认为0
 */
@property (nonatomic, assign) NSInteger contentViewCurrentIndex;

/**
 设置contentView能否左右滑动，默认YES
 */
@property (nonatomic, assign) BOOL contentViewCanScroll;

- (void) setCGAffineTransformMakeScale:(CGFloat)offset;

@end
