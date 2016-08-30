//
//  IrregularGridCollectionView.m
//  IrregularGridCollectionView
//
//  Created by YouXianMing on 16/8/30.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "IrregularGridCollectionView.h"

#pragma mark - IrregularGridCollectionView Class

@interface IrregularGridCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView            *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout  *flowLayout;

@end

@implementation IrregularGridCollectionView

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
        
        // Init UICollectionViewFlowLayout.
        self.flowLayout = [[MaximumSpacingFlowLayout alloc] init];
        
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
    
    self.collectionView.contentInset        = self.contentEdgeInsets;
    self.flowLayout.minimumLineSpacing      = self.verticalGap;
    self.flowLayout.minimumInteritemSpacing = self.horizontalGap;
}

#pragma mark - UICollectionView's delegate & data source.

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _adapters.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    IrregularGridCellDataAdapter *adapter = _adapters[indexPath.row];
    CustomIrregularGridViewCell  *cell    = [collectionView dequeueReusableCellWithReuseIdentifier:adapter.cellReuseIdentifier
                                                                                       forIndexPath:indexPath];
    cell.dataAdapter        = adapter;
    cell.data               = adapter.data;
    cell.indexPath          = indexPath;
    cell.collectionView     = collectionView;
    cell.collectionGridView = self;
    [cell loadContent];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    IrregularGridCellDataAdapter *adapter = _adapters[indexPath.row];
    return CGSizeMake(adapter.itemWidth, self.gridHeight);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomIrregularGridViewCell *cell = (CustomIrregularGridViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell selectedEvent];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(irregularGridCollectionView:didSelectedCell:)]) {
        
        [self.delegate irregularGridCollectionView:self didSelectedCell:cell];
    }
}

#pragma mark - Setter & Getter

- (void)setRegisterCells:(NSArray <IrregularGridViewCellClassType *> *)registerCells {
    
    _registerCells = registerCells;
    
    for (IrregularGridViewCellClassType *type in registerCells) {
        
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

#pragma mark - IrregularGridViewCellClassType Class

@implementation IrregularGridViewCellClassType

@end


