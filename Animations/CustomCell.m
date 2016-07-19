//
//  CustomCell.m
//  Animations
//
//  Created by YouXianMing on 16/1/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
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

+ (CGFloat)cellHeightWithData:(id)data {
    
    return 0.f;
}

- (void)setWeakReferenceWithCellDataAdapter:(CellDataAdapter *)dataAdapter data:(id)data
                                  indexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    
    _dataAdapter = dataAdapter;
    _data        = data;
    _indexPath   = indexPath;
    _tableView   = tableView;
}

+ (CellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data cellHeight:(CGFloat)height type:(NSInteger)type {
    
    NSString *tmpReuseIdentifier = reuseIdentifier.length <= 0 ? NSStringFromClass([self class]) : reuseIdentifier;
    return [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:tmpReuseIdentifier data:data cellHeight:height cellType:type];
}

+ (CellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data
                                             cellHeight:(CGFloat)height cellWidth:(CGFloat)cellWidth
                                                   type:(NSInteger)type {
    
    NSString *tmpReuseIdentifier = reuseIdentifier.length <= 0 ? NSStringFromClass([self class]) : reuseIdentifier;
    return [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:tmpReuseIdentifier data:data cellHeight:height cellWidth:cellWidth cellType:type];
}

+ (CellDataAdapter *)dataAdapterWithData:(id)data cellHeight:(CGFloat)height type:(NSInteger)type {
    
    return [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:nil data:data cellHeight:height cellType:type];
}

+ (CellDataAdapter *)dataAdapterWithData:(id)data cellHeight:(CGFloat)height {
    
    return [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:nil data:data cellHeight:height cellType:0];
}

+ (CellDataAdapter *)dataAdapterWithData:(id)data {
    
    return [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:nil data:data cellHeight:0 cellType:0];
}

- (void)updateWithNewCellHeight:(CGFloat)height animated:(BOOL)animated {
    
    if (_tableView && _dataAdapter) {
        
        if (animated) {
            
            _dataAdapter.cellHeight = height;
            [_tableView beginUpdates];
            [_tableView endUpdates];
            
        } else {
            
            _dataAdapter.cellHeight = height;
            [_tableView reloadData];
        }
    }
}

@end
