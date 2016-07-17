//
//  CollectionGridView.m
//  CollectionView
//
//  Created by YouXianMing on 16/7/14.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CollectionGridView.h"

@implementation CollectionGridViewCellClassType

@end

@interface CollectionGridView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView            *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout  *flowLayout;

@property (nonatomic) CGSize cellSize;
@property (nonatomic) CGSize contentSize;

@end

@implementation CollectionGridView

#pragma mark - Init

- (void)layoutSubviews {
    
    [super layoutSubviews];
    _collectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.contentEdgeInsets   = UIEdgeInsetsMake(5, 5, 5, 5);
        self.horizontalGap       = 5.f;
        self.verticalGap         = 5.f;
        self.gridHeight          = 20.f;
        self.horizontalCellCount = 3;
        
        // Init UICollectionViewFlowLayout.
        self.flowLayout                         = [[UICollectionViewFlowLayout alloc] init];
        self.flowLayout.minimumInteritemSpacing = 0;
        
        // Init UICollectionView.
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.showsVerticalScrollIndicator   = NO;
        self.collectionView.backgroundColor                = [UIColor clearColor];
        self.collectionView.delegate                       = self;
        self.collectionView.dataSource                     = self;
        [self addSubview:self.collectionView];
    }
    
    return self;
}

- (void)makeTheConfigEffective {
    
    CGFloat width     = self.frame.size.width;
    CGFloat cellWidth = (width - self.contentEdgeInsets.left -
                         self.contentEdgeInsets.right -
                         _horizontalGap * (_horizontalCellCount - 1)) / (CGFloat)_horizontalCellCount;
    
    self.collectionView.contentInset        = self.contentEdgeInsets;
    self.flowLayout.minimumLineSpacing      = self.verticalGap;
    self.flowLayout.minimumInteritemSpacing = self.horizontalGap;
    self.flowLayout.itemSize                = CGSizeMake(cellWidth, self.gridHeight);
    
    self.cellSize = self.flowLayout.itemSize;
}

#pragma mark - Reload data.

- (void)reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    
    [self.collectionView reloadItemsAtIndexPaths:indexPaths];
}

- (void)reloadData {
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView's delegate & data source.

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _adapters.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionGridCellDataAdapter *adapter = _adapters[indexPath.row];
    CustomCollectionGridViewCell  *cell    = [collectionView dequeueReusableCellWithReuseIdentifier:adapter.cellReuseIdentifier
                                                                                       forIndexPath:indexPath];
    cell.dataAdapter        = adapter;
    cell.data               = adapter.data;
    cell.indexPath          = indexPath;
    cell.collectionView     = collectionView;
    cell.collectionGridView = self;
    [cell loadContent];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCollectionGridViewCell *cell = (CustomCollectionGridViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell selectedEvent];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionGridView:didSelectedCell:)]) {
        
        [self.delegate collectionGridView:self didSelectedCell:cell];
    }
}

#pragma mark - Setter & Getter

- (void)setRegisterCells:(NSArray <CollectionGridViewCellClassType *> *)registerCells {
    
    _registerCells = registerCells;
    
    for (CollectionGridViewCellClassType *type in registerCells) {
        
        [self.collectionView registerClass:type.className forCellWithReuseIdentifier:type.reuseIdentifier];
    }
}

- (CGSize)contentSize {
    
    CGSize size = [_flowLayout collectionViewContentSize];
    
    size.width  += self.contentEdgeInsets.left + self.contentEdgeInsets.right;
    size.height += self.contentEdgeInsets.top  + self.contentEdgeInsets.bottom;
    
    return size;
}

- (void)resetSize {
    
    CGRect newFrame = self.frame;
    newFrame.size   = [self contentSize];
    self.frame      = newFrame;
}

@end
