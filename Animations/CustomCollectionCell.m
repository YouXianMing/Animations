//
//  CustomCollectionCell.m
//  TechCode
//
//  Created by YouXianMing on 16/5/18.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CustomCollectionCell.h"

@implementation CustomCollectionCell

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

+ (CellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data type:(NSInteger)type {
    
    NSString *tmpReuseIdentifier = reuseIdentifier.length <= 0 ? NSStringFromClass([self class]) : reuseIdentifier;
    return [CellDataAdapter collectionCellDataAdapterWithCellReuseIdentifier:tmpReuseIdentifier data:data cellType:type];
}

+ (CellDataAdapter *)dataAdapterWithData:(id)data type:(NSInteger)type {

    return [CellDataAdapter collectionCellDataAdapterWithCellReuseIdentifier:nil data:data cellType:type];
}

@end
