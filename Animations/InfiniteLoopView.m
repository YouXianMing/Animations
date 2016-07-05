//
//  InfiniteLoopView.m
//  InfiniteLoopView
//
//  Created by YouXianMing on 16/5/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "InfiniteLoopView.h"

@interface InfiniteLoopView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView            *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout  *flowLayout;
@property (nonatomic, strong) NSTimer                     *currentTimer;
@property (nonatomic)         NSInteger                    currentPage;
@property (nonatomic)         BOOL                         isAnimating;

@end

@implementation InfiniteLoopView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.scrollTimeInterval = 4.f;
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

- (void)reset {
    
    [self stopLoopAnimation];
    self.models = nil;
}

- (void)prepare {
    
    NSParameterAssert(self.models);
    
    // Check cell's class.
    for (id <InfiniteLoopCellClassProtocol> cellInfo  in self.models) {
        
        if ([[cellInfo cellClass] isSubclassOfClass:[CustomInfiniteLoopCell class]] == NO) {
            
            [NSException raise:@"InfiniteLoopView prepare error"
                        format:@"The cellClass must be the Subclass of CustomInfiniteLoopCell"];
        }
    }
    
    // Register cell's class.
    for (id <InfiniteLoopCellClassProtocol> cellInfo  in self.models) {
        
        [self.collectionView registerClass:[cellInfo cellClass] forCellWithReuseIdentifier:[cellInfo cellReuseIdentifier]];
    }
    
    self.flowLayout.scrollDirection = self.scrollDirection;
    self.collectionView.delegate    = self;
    self.collectionView.dataSource  = self;
    [self.collectionView reloadData];
    
    // Scroll to specified position.
    if (self.models.count) {
        
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
    
    if (self.models.count == 0) {
        
        return;
    }
    
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    NSInteger newRow     = (currentIndexPath.row + 1) % self.models.count;
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
    
    return self.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomInfiniteLoopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[_models[indexPath.row] cellReuseIdentifier]
                                                                             forIndexPath:indexPath];
    
    cell.indexPath = indexPath;
    cell.dataModel = self.models[indexPath.row];
    [cell loadContent];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(infiniteLoopView:data:selectedIndex:cell:)]) {
        
        [self.delegate infiniteLoopView:self data:self.models[indexPath.row]
                          selectedIndex:indexPath.row
                                   cell:(CustomInfiniteLoopCell *)[collectionView cellForItemAtIndexPath:indexPath]];
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(CustomInfiniteLoopCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [cell willDisplay];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(CustomInfiniteLoopCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [cell didEndDisplay];
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
    
    if (self.models.count == 0) {
        
        return;
    }
    
    NSInteger newValue = [self currentIndex] % self.models.count;
    
    if (_currentPage != newValue) {
        
        _currentPage = newValue;
        if (self.delegate && [self.delegate respondsToSelector:@selector(infiniteLoopView:didScrollCurrentPage:)]) {
            
            [self.delegate infiniteLoopView:self didScrollCurrentPage:_currentPage];
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

@end
