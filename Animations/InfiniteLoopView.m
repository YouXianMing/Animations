//
//  InfiniteLoopView.m
//  InfiniteLoopView
//
//  Created by YouXianMing on 16/5/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "InfiniteLoopView.h"
#import "POP.h"
@interface InfiniteLoopView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView            *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout  *flowLayout;
@property (nonatomic, strong) NSTimer                     *currentTimer;
@property (nonatomic)         NSInteger                    currentPage;


@end

@implementation InfiniteLoopView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.scrollTimeInterval = 3.f;
        self.autoScrollDuringTimeInterval = 1.5;
        self.scrollDirection    = UICollectionViewScrollDirectionHorizontal;
        
        // Init flowLayout.
        self.flowLayout                    = [[UICollectionViewFlowLayout alloc] init];
        //self.flowLayout.minimumLineSpacing = 0;
        //self.flowLayout.itemSize           = self.bounds.size;
        
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
#pragma mark - ******** 适配Frame变化
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    [self.collectionView reloadData];
}
- (void)reset {
    
    [self stopLoopAnimation];
    self.models = nil;
}

- (void)prepare {
    
    if (self.models.count == 0) {
        return;
    }
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
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.scrollTimeInterval+self.autoScrollDuringTimeInterval target:self selector:@selector(action)
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
    
    CGFloat oldOffsetValue = self.scrollDirection == UICollectionViewScrollDirectionHorizontal ? self.collectionView.contentOffset.x : self.collectionView.contentOffset.y;
    CGFloat newOffsetValue = self.scrollDirection == UICollectionViewScrollDirectionHorizontal ? self.bounds.size.width*(newSection*self.models.count+newRow) : self.bounds.size.height*(newSection*self.models.count+newRow) ;
    
    
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"prop" initializer:^(POPMutableAnimatableProperty *prop) {
        // read value
        prop.readBlock = ^(id obj, CGFloat values[]) {
        };
        // write value
        
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            //NSLog(@"old:%f current:%f,to:%f",offsetX,values[0],offsetX);
            
            self.collectionView.contentOffset = self.scrollDirection == UICollectionViewScrollDirectionHorizontal ? CGPointMake(values[0], 0) : CGPointMake(0,values[0]);
        };
        // dynamics threshold
        prop.threshold = 0.01;
    }];
    POPBasicAnimation *anBasic = [POPBasicAnimation easeInEaseOutAnimation];   //秒表当然必须是线性的时间函数
    anBasic.property = prop;    //自定义属性
    anBasic.fromValue = @(oldOffsetValue);   //从0开始
    anBasic.toValue = @(newOffsetValue);  //180秒
    anBasic.duration = self.autoScrollDuringTimeInterval;   //持续1.5秒
    anBasic.beginTime = CACurrentMediaTime() + 0.0f;    //延迟1秒开始
    [self.collectionView pop_addAnimation:anBasic forKey:@"countdown"];

}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.bounds.size;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //return UIEdgeInsetsMake(kTopBottomMargin, kLineSpacing, kTopBottomMargin, kLineSpacing);
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

// 第一行与第二行之间的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
// 第一列与第二列之间的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
#pragma mark - UICollectionView's delegate & dataSource.

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 10000;
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

    // 用于竖向
    CGPoint point = [cell convertPoint:cell.bounds.origin fromView:self];
    [cell contentOffset:point];
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
    
    [self.collectionView.visibleCells enumerateObjectsUsingBlock:^(__kindof CustomInfiniteLoopCell *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 用于竖向
        CGPoint point = [obj convertPoint:obj.bounds.origin fromView:self];
        
        [obj contentOffset:point];
    }];
    
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
    
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        
        index = (_collectionView.contentOffset.x + self.bounds.size.width * 0.5) / self.bounds.size.width;
        
    } else {
        
        index = (_collectionView.contentOffset.y + self.bounds.size.height * 0.5) / self.bounds.size.height;
    }
    
    return index;
}

- (void)adjustWhenFreeze {
    
    long targetIndex = [self currentIndex];
    
    // Scroll to specified position.
    if (targetIndex < _models.count) {
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:100]
                                    atScrollPosition:(self.flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal ? UICollectionViewScrollPositionLeft : UICollectionViewScrollPositionTop)
                                            animated:NO];
    }
}

@end
