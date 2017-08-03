//
//  InfiniteLoopCollectionView.m
//  InfiniteLoopCollectionView
//
//  Created by YouXianMing on 2017/8/3.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "InfiniteLoopCollectionView.h"

@interface InfiniteLoopCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate, CustomCollectionCellDelegate>

@property (nonatomic, strong) UICollectionView            *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout  *flowLayout;
@property (nonatomic, strong) NSTimer                     *currentTimer;
@property (nonatomic)         NSInteger                    currentPage;
@property (nonatomic)         BOOL                         isAnimating;

@end

@implementation InfiniteLoopCollectionView

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.flowLayout.itemSize  = self.bounds.size;
    self.collectionView.frame = self.bounds;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
    
        self.scrollTimeInterval = 8.f;
        self.scrollDirection    = UICollectionViewScrollDirectionHorizontal;
        
        // Init flowLayout.
        self.flowLayout                    = [[UICollectionViewFlowLayout alloc] init];
        self.flowLayout.minimumLineSpacing = 0;
        self.flowLayout.itemSize           = self.bounds.size;
        
        // Init UICollectionView.
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.showsVerticalScrollIndicator   = NO;
        self.collectionView.pagingEnabled                  = YES;
        self.collectionView.backgroundColor                = [UIColor clearColor];
        [self addSubview:self.collectionView];
    }
    
    return self;
}

- (void)registerCellsWithCollectionView:(void (^)(UICollectionView *collectionView))configBlock {
    
    if (configBlock) {
        
        configBlock(self.collectionView);
    }
}

- (void)reset {
    
    [self stopLoopAnimation];
    self.adapters = nil;
}

- (void)loadData {
    
    NSParameterAssert(self.adapters);
    
    self.flowLayout.scrollDirection = self.scrollDirection;
    self.collectionView.delegate    = self;
    self.collectionView.dataSource  = self;
    [self.collectionView reloadData];
    
    // Scroll to specified position.
    if (self.adapters.count) {
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:100]
                                    atScrollPosition:(self.flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal ? UICollectionViewScrollPositionLeft : UICollectionViewScrollPositionTop)
                                            animated:NO];
    }
}

- (void)startLoopAnimation {
    
    _isAnimating = YES;
    [self setupTimer];
}

- (void)stopLoopAnimation {
    
    _isAnimating = NO;
    [self invalidateTimer];
}

#pragma mark - Timer's event.

- (void)setupTimer {
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.scrollTimeInterval target:self selector:@selector(action)
                                                    userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    _currentTimer = timer;
}

- (void)invalidateTimer {
    
    [_currentTimer invalidate];
    _currentTimer = nil;
}

- (void)action {
    
    if (self.adapters.count == 0) {
        
        return;
    }
    
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    NSInteger newRow     = (currentIndexPath.row + 1) % self.adapters.count;
    NSInteger newSection = currentIndexPath.section + (newRow == 0 ? 1 : 0);
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:newRow inSection:newSection];
    
    [self.collectionView scrollToItemAtIndexPath:newIndexPath
                                atScrollPosition:(self.flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal ? UICollectionViewScrollPositionLeft : UICollectionViewScrollPositionTop)
                                        animated:YES];
}

#pragma mark - UICollectionView's delegate & dataSource.

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 5000;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.adapters.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter          *adapter = self.adapters[indexPath.row];
    BaseCustomCollectionCell *cell    = [collectionView dequeueReusableCellWithReuseIdentifier:adapter.cellReuseIdentifier forIndexPath:indexPath];
    
    cell.indexPath      = indexPath;
    cell.dataAdapter    = adapter;
    cell.data           = adapter.data;
    cell.delegate       = self;
    cell.collectionView = collectionView;
    
    [cell loadContent];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseCustomCollectionCell *cell = (BaseCustomCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell selectedEvent];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(infiniteLoopCollectionView:selectedIndex:cell:)]) {
        
        [self.delegate infiniteLoopCollectionView:self selectedIndex:indexPath.row cell:cell];
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(BaseCustomCollectionCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {

    [self.collectionView.visibleCells enumerateObjectsUsingBlock:^(__kindof BaseCustomCollectionCell *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGPoint point = [obj convertPoint:obj.bounds.origin fromView:self];
        [obj contentOffset:point];
    }];
    
    cell.display = YES;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(BaseCustomCollectionCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.display = NO;
}

#pragma mark - CustomCollectionCellDelegate

- (void)customCollectionCell:(BaseCustomCollectionCell *)cell event:(id)event {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(infiniteLoopCollectionView:cell:event:)]) {
        
        [self.delegate infiniteLoopCollectionView:self cell:cell event:event];
    }
}

#pragma mark - UIScrollView's delegate.

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (_isAnimating) {
        
        [self invalidateTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (_isAnimating) {
        
        [self setupTimer];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.collectionView.visibleCells enumerateObjectsUsingBlock:^(__kindof BaseCustomCollectionCell *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGPoint point = [obj convertPoint:obj.bounds.origin fromView:self];
        [obj contentOffset:point];
    }];
    
    if (self.adapters.count == 0) {
        
        return;
    }
    
    NSInteger newValue = [self currentIndex] % self.adapters.count;
    
    if (_currentPage != newValue) {
        
        _currentPage = newValue;
        if (self.delegate && [self.delegate respondsToSelector:@selector(infiniteLoopCollectionView:didScrollCurrentPage:)]) {
            
            [self.delegate infiniteLoopCollectionView:self didScrollCurrentPage:_currentPage];
        }
    }
}

#pragma mark - Other.

- (NSInteger)currentIndex {
    
    NSInteger index = 0;
    
    if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        
        index = (_collectionView.contentOffset.x + _flowLayout.itemSize.width * 0.5) / _flowLayout.itemSize.width;
        
    } else {
        
        index = (_collectionView.contentOffset.y + _flowLayout.itemSize.height * 0.5) / _flowLayout.itemSize.height;
    }
    
    return index;
}

- (void)adjustWhenFreeze {
    
    long targetIndex = [self currentIndex];
    
    // Scroll to specified position.
    if (targetIndex < self.adapters.count) {
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:100]
                                    atScrollPosition:(self.flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal ? UICollectionViewScrollPositionLeft : UICollectionViewScrollPositionTop)
                                            animated:NO];
    }
}

#pragma mark - Constructor

+ (instancetype)infiniteLoopCollectionViewWithFrame:(CGRect)frame
                                 scrollTimeInterval:(NSTimeInterval)scrollTimeInterval
                                    scrollDirection:(UICollectionViewScrollDirection)scrollDirection
                                           delegate:(id <InfiniteLoopCollectionViewDelegate>)delegate
                                      registerCells:(void (^)(UICollectionView *collectionView))configBlock {
    
    InfiniteLoopCollectionView *view = [[InfiniteLoopCollectionView alloc] initWithFrame:frame];
    
    view.scrollTimeInterval          = scrollTimeInterval;
    view.scrollDirection             = scrollDirection;
    view.delegate                    = delegate;
    [view registerCellsWithCollectionView:configBlock];
    
    return view;
}

- (void)startLoopWithAdapters:(NSArray <CellDataAdapter *> *)adapters runTimerLoopEvent:(BOOL)timerEvent {
    
    [self reset];
    self.adapters = adapters;
    [self loadData];
    timerEvent ? [self startLoopAnimation] : 0;
}

@end
