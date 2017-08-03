//
//  CustomCollectionCell.m
//  TechCode
//
//  Created by YouXianMing on 16/5/18.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "BaseCustomCollectionCell.h"

@implementation BaseCustomCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupCell];
        
        [self buildSubview];
    }
    
    return self;
}

- (void)setupCell {
    
}

- (void)buildSubview {
    
}

- (void)loadContent {
    
}

- (void)contentOffset:(CGPoint)offset {
    
}

- (void)selectedEvent {
    
}

+ (CellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data type:(NSInteger)type {
    
    NSString *tmpReuseIdentifier = reuseIdentifier.length <= 0 ? NSStringFromClass([self class]) : reuseIdentifier;
    return [CellDataAdapter collectionCellDataAdapterWithCellReuseIdentifier:tmpReuseIdentifier data:data cellType:type];
}

+ (CellDataAdapter *)dataAdapterWithData:(id)data type:(NSInteger)type {

    return [CellDataAdapter collectionCellDataAdapterWithCellReuseIdentifier:NSStringFromClass([self class]) data:data cellType:type];
}

+ (CellDataAdapter *)dataAdapterWithData:(id)data {
    
    return [CellDataAdapter collectionCellDataAdapterWithCellReuseIdentifier:NSStringFromClass([self class]) data:data cellType:0];
}

+ (void)registerToCollectionView:(UICollectionView *)collectionView reuseIdentifier:(NSString *)reuseIdentifier {

    [collectionView registerClass:[self class] forCellWithReuseIdentifier:reuseIdentifier.length ? reuseIdentifier : NSStringFromClass([self class])];
}

+ (void)registerToCollectionView:(UICollectionView *)collectionView {

    [collectionView registerClass:[self class] forCellWithReuseIdentifier:NSStringFromClass([self class])];
}

@end
