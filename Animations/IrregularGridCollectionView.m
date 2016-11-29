//
//  IrregularGridCollectionView.m
//  IrregularGridCollectionView
//
//  Created by YouXianMing on 16/8/30.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "IrregularGridCollectionView.h"

#pragma mark - IrregularGridCollectionView Class

@interface IrregularGridCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource, CustomIrregularGridViewCellDelegate>

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
        
        self.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        self.lineSpacing       = 5.f;
        self.interitemSpacing  = 5.f;
        self.gridHeight        = 20.f;
        self.scrollDirection   = UICollectionViewScrollDirectionVertical;
        
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
    self.flowLayout.minimumLineSpacing      = self.lineSpacing;
    self.flowLayout.minimumInteritemSpacing = self.interitemSpacing;
    self.flowLayout.scrollDirection         = self.scrollDirection;
}

#pragma mark - UICollectionView's delegate & data source.

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _adapters.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    IrregularGridCellDataAdapter *adapter = _adapters[indexPath.row];
    adapter.indexPath                     = indexPath;
    
    CustomIrregularGridViewCell  *cell    = [collectionView dequeueReusableCellWithReuseIdentifier:adapter.cellReuseIdentifier forIndexPath:indexPath];
    cell.delegate                         = self;
    cell.dataAdapter                      = adapter;
    cell.data                             = adapter.data;
    cell.indexPath                        = indexPath;
    cell.collectionView                   = collectionView;
    cell.collectionGridView = self;
    [cell loadContent];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    IrregularGridCellDataAdapter *adapter = _adapters[indexPath.row];
    return CGSizeMake(adapter.itemWidth, self.gridHeight);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) {

    [(CustomIrregularGridViewCell *)cell willDisplay];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {

    [(CustomIrregularGridViewCell *)cell didEndDisplay];
}

+ (instancetype)irregularGridCollectionViewWithFrame:(CGRect)frame
                                            delegate:(id <IrregularGridCollectionViewDelegate>)delegate
                                       registerCells:(NSArray <IrregularGridViewCellClassType *> *)registerCells
                                     scrollDirection:(UICollectionViewScrollDirection)scrollDirection
                                   contentEdgeInsets:(UIEdgeInsets)edgeInsets
                                         lineSpacing:(CGFloat)lineSpacing
                                    interitemSpacing:(CGFloat)interitemSpacing
                                          gridHeight:(CGFloat)gridHeight {
    
    IrregularGridCollectionView *irregularGridView = [[[self class] alloc] initWithFrame:frame];
    irregularGridView.delegate                     = delegate;
    irregularGridView.contentEdgeInsets            = edgeInsets;
    irregularGridView.scrollDirection              = scrollDirection;
    irregularGridView.lineSpacing                  = lineSpacing;
    irregularGridView.interitemSpacing             = interitemSpacing;
    irregularGridView.gridHeight                   = gridHeight;
    irregularGridView.registerCells                = registerCells;
    [irregularGridView makeTheConfigEffective];
    
    return irregularGridView;
}

#pragma mark - CustomIrregularGridViewCellDelegate

- (void)customIrregularGridViewCell:(CustomIrregularGridViewCell *)cell event:(id)event {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(irregularGridCollectionView:didSelectedCell:event:)]) {
        
        [self.delegate irregularGridCollectionView:self didSelectedCell:cell event:event];
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


