//
//  NestPageContentView.m
//  TV_TV
//
//  Created by liyy on 2017/10/31.
//  Copyright © 2017年 ccdc. All rights reserved.
//

#import "NestPageContentView.h"

#define IOS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])

static NSString *collectionCellIdentifier = @"collectionCellIdentifier";

@interface NestPageContentView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, retain) UIViewController *parentVC;       // 父视图
@property (nonatomic, retain) UICollectionView *collectionView;

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
    
    for (UIViewController *childVC in self.childsVCs) {
        [self.parentVC addChildViewController:childVC];
    }
    
    [self.collectionView reloadData];
}

#pragma mark - LazyLoad

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = self.bounds.size;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
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
    
    return cell;
}

#ifdef __IPHONE_8_0

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIViewController *childVc = self.childsVCs[indexPath.row];
    childVc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:childVc.view];
}

#endif

#pragma mark UIScrollView

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
    
    CGFloat scrollView_W = scrollView.bounds.size.width;
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    NSInteger startIndex = floor(_startOffsetX/scrollView_W);
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
        endIndex = endIndex < 0?0:endIndex;
    } else {
        // 没滑过去
        endIndex = startIndex;
    }
    
    CGFloat progress = (currentOffsetX - _startOffsetX) / scrollView_W;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(NestContentViewDidScroll:startIndex:endIndex:progress:)]) {
        [self.delegate NestContentViewDidScroll:self startIndex:startIndex endIndex:endIndex progress:progress];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat scrollView_W = scrollView.bounds.size.width;
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    NSInteger startIndex = floor(_startOffsetX/scrollView_W);
    NSInteger endIndex = floor(currentOffsetX/scrollView_W);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(NestContenViewDidEndDecelerating:startIndex:endIndex:)]) {
        [self.delegate NestContenViewDidEndDecelerating:self startIndex:startIndex endIndex:endIndex];
    }
}

#pragma mark setter

- (void)setContentViewCurrentIndex:(NSInteger)contentViewCurrentIndex {
    if (_contentViewCurrentIndex < 0||_contentViewCurrentIndex > self.childsVCs.count-1) {
        return;
    }
    _isSelectBtn = YES;
    _contentViewCurrentIndex = contentViewCurrentIndex;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:contentViewCurrentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (void)setContentViewCanScroll:(BOOL)contentViewCanScroll {
    _contentViewCanScroll = contentViewCanScroll;
    _collectionView.scrollEnabled = _contentViewCanScroll;
}

@end
