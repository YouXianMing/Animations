//
//  CustomHeaderFooterView.m
//  Animations
//
//  Created by YouXianMing on 15/11/30.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "CustomHeaderFooterView.h"

@implementation CustomHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self setupHeaderFooterView];
        [self buildSubview];
    }
    
    return self;
}

- (void)setHeaderFooterViewBackgroundColor:(UIColor *)color {
    
    self.contentView.backgroundColor = color;
}

- (void)setupHeaderFooterView {
    
}

- (void)buildSubview {
    
}

- (void)loadContent {
    
}

+ (CGFloat)heightWithData:(id)data {
    
    return 0;
}

+ (void)registerToTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier {
    
    NSString *identifier = reuseIdentifier.length <= 0 ? NSStringFromClass([self class]) : reuseIdentifier;
    [tableView registerClass:[self class] forHeaderFooterViewReuseIdentifier:identifier];
}

+ (void)registerToTableView:(UITableView *)tableView {
    
    [tableView registerClass:[self class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([self class])];
}

+ (CellHeaderFooterDataAdapter *)dataAdapterWithReuseIdentifier:(NSString *)reuseIdentifier
                                                           data:(id)data
                                                         height:(CGFloat)height
                                                           type:(NSInteger)type {
    
    return [CellHeaderFooterDataAdapter cellHeaderFooterDataAdapterWithReuseIdentifier:reuseIdentifier data:data height:height type:type];
}

+ (CellHeaderFooterDataAdapter *)dataAdapterWithData:(id)data height:(CGFloat)height type:(NSInteger)type {
    
    return [CellHeaderFooterDataAdapter cellHeaderFooterDataAdapterWithReuseIdentifier:NSStringFromClass([self class]) data:data height:height type:type];
}

+ (CellHeaderFooterDataAdapter *)dataAdapterWithHeight:(CGFloat)height type:(NSInteger)type {
    
    return [CellHeaderFooterDataAdapter cellHeaderFooterDataAdapterWithReuseIdentifier:NSStringFromClass([self class]) data:nil height:height type:type];
}

+ (CellHeaderFooterDataAdapter *)dataAdapterWithData:(id)data height:(CGFloat)height {
    
    return [CellHeaderFooterDataAdapter cellHeaderFooterDataAdapterWithReuseIdentifier:NSStringFromClass([self class]) data:data height:height type:0];
}

+ (CellHeaderFooterDataAdapter *)dataAdapterWithHeight:(CGFloat)height {
    
    return [CellHeaderFooterDataAdapter cellHeaderFooterDataAdapterWithReuseIdentifier:NSStringFromClass([self class]) data:nil height:height type:0];
}

+ (CellHeaderFooterDataAdapter *)fixedHeightTypeDataAdapterWithReuseIdentifier:(NSString *)reuseIdentifier data:(id)data type:(NSInteger)type {
    
    return [CellHeaderFooterDataAdapter cellHeaderFooterDataAdapterWithReuseIdentifier:reuseIdentifier data:data height:[[self class] heightWithData:data] type:type];
}

+ (CellHeaderFooterDataAdapter *)fixedHeightTypeDataAdapterWithData:(id)data type:(NSInteger)type {
    
    return [CellHeaderFooterDataAdapter cellHeaderFooterDataAdapterWithReuseIdentifier:NSStringFromClass([self class]) data:data height:[[self class] heightWithData:data] type:type];
}

+ (CellHeaderFooterDataAdapter *)fixedHeightTypeDataAdapterWithData:(id)data {
    
    return [CellHeaderFooterDataAdapter cellHeaderFooterDataAdapterWithReuseIdentifier:NSStringFromClass([self class]) data:data height:[[self class] heightWithData:data] type:0];
}

+ (CellHeaderFooterDataAdapter *)fixedHeightTypeDataAdapter {
    
    return [CellHeaderFooterDataAdapter cellHeaderFooterDataAdapterWithReuseIdentifier:NSStringFromClass([self class]) data:nil height:[[self class] heightWithData:nil] type:0];
}

@end
