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

- (void)updateWithNewCellHeight:(CGFloat)height animated:(BOOL)animated {
    
    if (self.tableView && self.dataAdapter) {
        
        if (animated) {
            
            self.dataAdapter.cellHeight = height;
            [self.tableView beginUpdates];
            [self.tableView endUpdates];
            
        } else {
            
            self.dataAdapter.cellHeight = height;
            [self.tableView reloadData];
        }
    }
}

@end
