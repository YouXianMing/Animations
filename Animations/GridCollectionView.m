//
//  GridCollectionView.m
//  UICollectionView
//
//  Created by YouXianMing on 16/5/24.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "GridCollectionView.h"
#import "GridCollectionViewCell.h"

@interface GridCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView            *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout  *flowLayout;
@property (nonatomic) Class   patternClass;

@end

@implementation GridCollectionView

#pragma mark - Init

- (void)layoutSubviews {
    
    [super layoutSubviews];
    _collectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        // Datas.
        self.datas = [NSMutableArray array];
        
        // Init UICollectionViewFlowLayout.
        self.flowLayout                         = [[UICollectionViewFlowLayout alloc] init];
        self.flowLayout.minimumLineSpacing      = 0;
        self.flowLayout.minimumInteritemSpacing = 0;
        
        // Init UICollectionView.
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds
                                                 collectionViewLayout:self.flowLayout];
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.showsVerticalScrollIndicator   = NO;
        self.collectionView.backgroundColor                = [UIColor clearColor];
        self.collectionView.delegate                       = self;
        self.collectionView.dataSource                     = self;
        [self addSubview:self.collectionView];
    }
    
    return self;
}

#pragma mark - UICollectionView's delegate & data source.

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GridCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(_patternClass)
                                                                             forIndexPath:indexPath];
    cell.data                    = _datas[indexPath.row];
    [cell loadContent];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_delegate && [_delegate respondsToSelector:@selector(gridCollectionView:didSelected:indexPath:)]) {
        
        [_delegate gridCollectionView:self
                          didSelected:(GridCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath]
                            indexPath:indexPath];
    }
}

#pragma mark - GridCollectionViewCellDelegate

- (void)gridCollectionViewCellTapEvent:(GridCollectionViewCell *)cell {
    
}

#pragma mark -

- (void)configCellPattern:(GridCollectionViewCell *)cell {
    
    NSParameterAssert(cell);
    
    _patternClass = cell.class;
    [_collectionView registerClass:_patternClass forCellWithReuseIdentifier:NSStringFromClass(_patternClass)];
}

- (CGSize)contentSize {
    
    return [_flowLayout collectionViewContentSize];
}

#pragma mark - Setter & Getter.

- (void)setItemSize:(CGSize)itemSize {
    
    _itemSize            = itemSize;
    _flowLayout.itemSize = itemSize;
}

- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    
    _flowLayout.scrollDirection = scrollDirection;
}

- (UICollectionViewScrollDirection)scrollDirection {
    
    return _flowLayout.scrollDirection;
}

@end
