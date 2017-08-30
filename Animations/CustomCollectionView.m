//
//  CustomCollectionView.m
//  UICollectionView
//
//  Created by YouXianMing on 2017/7/11.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "CustomCollectionView.h"

@implementation CustomCollectionView

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self buildCollectionView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self buildCollectionView];
    }
    
    return self;
}

- (void)buildCollectionView {
    
    if (!self.collectionView) {
        
        // Do some setup work.
        [self setup];
        
        // Create the layout.
        [self createLayout];
        
        // Create the dataSource.
        self.adapters = [NSMutableArray array];
        NSParameterAssert(self.layout);
        
        // Create the collectionView.
        self.collectionView                                = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        self.collectionView.backgroundColor                = [UIColor clearColor];
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.showsVerticalScrollIndicator   = NO;
        self.collectionView.delegate                       = self;
        self.collectionView.dataSource                     = self;
        [self addSubview:self.collectionView];
    }
}

- (void)createLayout {
    
    // Overwrite by subClass.
}

- (void)setup {
    
    // Overwrite by subClass.
}

- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)registerClass:(Class)cellClass {
    
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}


- (void)reloadData {
    
    [self.collectionView reloadData];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // Reset the collectionView's frame.
    self.collectionView.frame = self.bounds;
}

- (void)editCustomCollectionViewAdapters:(void (^)(NSMutableArray <CellDataAdapter *> *adapters))editAdaptersBlock
                   editItemsAtIndexPaths:(void (^)(UICollectionView  *collectionView))editItemsBlock
                              completion:(void (^)(BOOL finished))completionBlock {
    
    [self.collectionView performBatchUpdates:^{
        
        editAdaptersBlock ? editAdaptersBlock(self.adapters)    : 0;
        editItemsBlock    ? editItemsBlock(self.collectionView) : 0;
        
    } completion:^(BOOL finished) {
        
        [self.collectionView reloadData];
        completionBlock ? completionBlock(finished) : 0;
    }];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.adapters.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseCustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.adapters[indexPath.row].cellReuseIdentifier forIndexPath:indexPath];
    cell.dataAdapter               = self.adapters[indexPath.row];
    cell.data                      = self.adapters[indexPath.row].data;
    cell.collectionView            = collectionView;
    cell.indexPath                 = indexPath;
    cell.delegate                  = self;
    
    [cell loadContent];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseCustomCollectionCell *cell = (BaseCustomCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell selectedEvent];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCollectionView:didSelectCell:indexPath:)]) {
        
        [self.delegate customCollectionView:self didSelectCell:cell indexPath:indexPath];
    }
}

#pragma mark - CustomCollectionCellDelegate

- (void)customCollectionCell:(BaseCustomCollectionCell *)cell event:(id)event {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCollectionView:cell:event:)]) {
        
        [self.delegate customCollectionView:self cell:cell event:event];
    }
}

@end
