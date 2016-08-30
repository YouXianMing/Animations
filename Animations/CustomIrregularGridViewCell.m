//
//  CustomIrregularGridViewCell.m
//  IrregularGridCollectionView
//
//  Created by YouXianMing on 16/8/30.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CustomIrregularGridViewCell.h"

@implementation CustomIrregularGridViewCell

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

+ (IrregularGridCellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier
                                                                data:(id)data
                                                                type:(NSInteger)type
                                                           itemWidth:(CGFloat)itemWidth {

    NSString *identifierString = nil;
    reuseIdentifier.length <= 0 ? (identifierString = NSStringFromClass([self class])) : (identifierString = reuseIdentifier);
    
    return [IrregularGridCellDataAdapter collectionGridCellDataAdapterWithCellReuseIdentifier:identifierString data:data cellType:type itemWidth:itemWidth];
}

+ (IrregularGridCellDataAdapter *)dataAdapterWithData:(id)data type:(NSInteger)type itemWidth:(CGFloat)itemWidth {
    
    return [IrregularGridCellDataAdapter collectionGridCellDataAdapterWithCellReuseIdentifier:NSStringFromClass([self class]) data:data cellType:type itemWidth:itemWidth];
}

@end
