//
//  CustomCollectionGridViewCell.m
//  CollectionView
//
//  Created by YouXianMing on 16/7/14.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CustomCollectionGridViewCell.h"

@implementation CustomCollectionGridViewCell

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

- (void)selectedEvent {
    
}

+ (CollectionGridCellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data type:(NSInteger)type {
    
    NSString *identifierString = nil;
    reuseIdentifier.length <= 0 ? (identifierString = NSStringFromClass([self class])) : (identifierString = reuseIdentifier);
    
    return [CollectionGridCellDataAdapter collectionGridCellDataAdapterWithCellReuseIdentifier:identifierString data:data cellType:type];
}

@end
