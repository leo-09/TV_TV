//
//  NestPageContentView.m
//  TV_TV
//
//  Created by liyy on 2017/10/31.
//  Copyright © 2017年 ccdc. All rights reserved.
//

#import "NestPageContentView.h"

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define margin 20

static NSString *collectionCellIdentifier = @"collectionCellIdentifier";

@interface NestPageContentView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, retain) UIViewController *parentVC;       // 父视图
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *cells;

@property (nonatomic, retain) NSArray *childsVCs;               // 子视图数组

@property (nonatomic, assign) BOOL isSelectBtn;                 // 是否是滑动
@property (nonatomic, assign) CGFloat startOffsetX;

@end

@implementation NestPageContentView

- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC delegate:(id<NestPageContentViewDelegate>)delegate {
    if (self = [super initWithFrame:frame]) {
        self.parentVC = parentVC;
        self.childsVCs = childVCs;
        self.delegate = delegate;
        
        self.backgroundColor = [UIColor blackColor];
        [self setupSubViews];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - setup

- (void)setupSubViews {
    _startOffsetX = 0;
    _isSelectBtn = NO;
    _contentViewCanScroll = YES;
    _cells = [[NSMutableArray alloc] init];
    
    for (UIViewController *childVC in self.childsVCs) {
        [self.parentVC addChildViewController:childVC];
    }
    
    [self.collectionView reloadData];
    
    // 等0.1秒后 更新view的transform
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [self setCGAffineTransformMakeScale:0];
    });
}

#pragma mark - LazyLoad

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(self.bounds.size.width - margin * 2, self.bounds.size.height);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
        flowLayout.minimumLineSpacing = margin / 2;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionCellIdentifier];
        
        [self addSubview:_collectionView];
    }
    
    return _collectionView;
}

#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childsVCs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellIdentifier forIndexPath:indexPath];
    
    if (IOS_VERSION < 8.0) {
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        UIViewController *childVC = self.childsVCs[indexPath.item];
        childVC.view.frame = cell.contentView.bounds;
        [cell.contentView addSubview:childVC.view];
    }
    
    [_cells addObject:cell];
    if (_cells.count > _childsVCs.count) {
        [_cells removeLastObject];
    }
    
    return cell;
}

#ifdef __IPHONE_8_0

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIViewController *childVc = self.childsVCs[indexPath.row];
    childVc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:childVc.view];
}

#endif

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _isSelectBtn = NO;
    _startOffsetX = scrollView.contentOffset.x;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(NestContentViewWillBeginDragging:)]) {
        [self.delegate NestContentViewWillBeginDragging:self];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_isSelectBtn) {
        return;
    }
    
    CGFloat scrollView_W = scrollView.bounds.size.width - margin * 2;
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    NSInteger startIndex = floor(_startOffsetX / scrollView_W);
    NSInteger endIndex;
    
    if (currentOffsetX > _startOffsetX) {
        // 左滑left
        endIndex = startIndex + 1;
        if (endIndex > self.childsVCs.count - 1) {
            endIndex = self.childsVCs.count - 1;
        }
    } else if (currentOffsetX < _startOffsetX) {
        // 右滑right
        endIndex = startIndex - 1;
        endIndex = endIndex < 0 ? 0 : endIndex;
    } else {
        // 没滑过去
        endIndex = startIndex;
    }
    
    [self setCGAffineTransformMakeScale:currentOffsetX];
    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(NestContentViewDidScroll:startIndex:endIndex:progress:)]) {
//        CGFloat progress = (currentOffsetX - _startOffsetX) / scrollView_W;
//        [self.delegate NestContentViewDidScroll:self startIndex:startIndex endIndex:endIndex progress:progress];
//    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat scrollView_W = scrollView.bounds.size.width - margin * 2;
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    NSInteger startIndex = floor(_startOffsetX / scrollView_W);
    NSInteger endIndex;
    
    if (currentOffsetX > _startOffsetX) {
        // 左滑left
        endIndex = startIndex + 1;
        if (endIndex > self.childsVCs.count - 1) {
            endIndex = self.childsVCs.count - 1;
        }
    } else if (currentOffsetX < _startOffsetX) {
        // 右滑right
        endIndex = startIndex - 1;
        endIndex = endIndex < 0 ? 0 : endIndex;
    } else {
        // 没滑过去
        endIndex = startIndex;
    }
    
    /*  1.不设置UICollectionView的pagingEnabled，可避免与子ViewController的ScrollView滚动冲突
        2.此处禁止惯性滚动，并同时设置到中间位置
     */
    if (decelerate) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 移动到中间位置
            [scrollView setContentOffset:CGPointMake(endIndex * (scrollView_W + margin / 2), 0) animated:YES];
        });
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(NestContenViewDidEndDecelerating:startIndex:endIndex:)]) {
        [self.delegate NestContenViewDidEndDecelerating:self startIndex:startIndex endIndex:endIndex];
    }
}

// 滑动scrollView，并且手指离开时执行。一次有效滑动，只执行一次。
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    CGFloat scrollView_W = scrollView.bounds.size.width - margin * 2;
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    NSInteger startIndex = floor(_startOffsetX / scrollView_W);
    NSInteger endIndex;
    
    if (currentOffsetX > _startOffsetX) {
        // 左滑left
        endIndex = startIndex + 1;
        if (endIndex > self.childsVCs.count - 1) {
            endIndex = self.childsVCs.count - 1;
        }
    } else if (currentOffsetX < _startOffsetX) {
        // 右滑right
        endIndex = startIndex - 1;
        endIndex = endIndex < 0 ? 0 : endIndex;
    } else {
        // 没滑过去
        endIndex = startIndex;
    }
    
    // 移动到中间位置
    [scrollView setContentOffset:CGPointMake(endIndex * (scrollView_W + margin / 2), 0) animated:YES];
}

#pragma mark - setter

- (void)setContentViewCurrentIndex:(NSInteger)contentViewCurrentIndex {
    if (_contentViewCurrentIndex < 0 || _contentViewCurrentIndex > self.childsVCs.count - 1) {
        return;
    }
    _isSelectBtn = YES;
    _contentViewCurrentIndex = contentViewCurrentIndex;
    
    CGFloat scrollView_W = self.collectionView.bounds.size.width - margin * 2;
    [self.collectionView setContentOffset:CGPointMake(contentViewCurrentIndex * (scrollView_W + margin / 2), 0) animated:YES];
    
    [self setCGAffineTransformMakeScale:contentViewCurrentIndex * (scrollView_W + margin / 2)];
}

- (void)setContentViewCanScroll:(BOOL)contentViewCanScroll {
    _contentViewCanScroll = contentViewCanScroll;
    _collectionView.scrollEnabled = _contentViewCanScroll;
}

#pragma mark - 修改transform

- (void) setCGAffineTransformMakeScale:(CGFloat)offset {
    float space = 0;
    float viewWidth = 0;
    
    for (int i = 0; i < _cells.count; i++) {
        UICollectionViewCell *cell = _cells[i];
        
        if (i == 0) {
            viewWidth = cell.frame.size.width;
        }
        space = self.collectionView.frame.size.width - viewWidth;
        CGFloat width = viewWidth + space / 4;
        CGFloat x = i * width;
        CGFloat value = fabs((offset - x) / width);
        value = value > 1.0 ? 1.0 : value;
        
        CGFloat scale = fabs(cos(value * M_PI / (_cells.count)));
        scale = scale < 0.5 ? 0.5 : scale;
        
        cell.transform = CGAffineTransformMakeScale(1.0, scale);
    }
}

@end
