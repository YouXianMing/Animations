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
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
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
    
    [self delegateEvent];
}

- (void)delegateEvent {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        
        [self.delegate customCell:self event:self.data];
    }
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return 0.f;
}

- (void)loadContentWithAdapter:(CellDataAdapter *)dataAdapter {
    
    _dataAdapter = dataAdapter;
    _data        = dataAdapter.data;
    [self loadContent];
}

- (void)loadContentWithAdapter:(CellDataAdapter *)dataAdapter
                     indexPath:(NSIndexPath *)indexPath {
    
    _dataAdapter = dataAdapter;
    _data        = dataAdapter.data;
    _indexPath   = indexPath;
    [self loadContent];
}

- (void)loadContentWithAdapter:(CellDataAdapter *)dataAdapter
                      delegate:(id <CustomCellDelegate>)delegate
                     indexPath:(NSIndexPath *)indexPath {
    
    _dataAdapter = dataAdapter;
    _data        = dataAdapter.data;
    _indexPath   = indexPath;
    _delegate    = delegate;
    [self loadContent];
}

- (void)loadContentWithAdapter:(CellDataAdapter *)dataAdapter
                      delegate:(id <CustomCellDelegate>)delegate
                     tableView:(UITableView *)tableView
                     indexPath:(NSIndexPath *)indexPath {
    
    _dataAdapter = dataAdapter;
    _data        = dataAdapter.data;
    _indexPath   = indexPath;
    _delegate    = delegate;
    _tableView   = tableView;
    [self loadContent];
}

#pragma mark - Normal type adapter.

+ (CellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier
                                                   data:(id)data
                                             cellHeight:(CGFloat)height
                                                   type:(NSInteger)type {
    
    NSString *tmpReuseIdentifier = reuseIdentifier.length <= 0 ? NSStringFromClass([self class]) : reuseIdentifier;
    return [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:tmpReuseIdentifier data:data cellHeight:height cellType:type];
}

+ (CellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier
                                                   data:(id)data
                                             cellHeight:(CGFloat)height
                                              cellWidth:(CGFloat)cellWidth
                                                   type:(NSInteger)type {
    
    NSString *tmpReuseIdentifier = reuseIdentifier.length <= 0 ? NSStringFromClass([self class]) : reuseIdentifier;
    return [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:tmpReuseIdentifier data:data cellHeight:height cellWidth:cellWidth cellType:type];
}

+ (CellDataAdapter *)dataAdapterWithData:(id)data cellHeight:(CGFloat)height type:(NSInteger)type {
    
    return [[self class] dataAdapterWithCellReuseIdentifier:nil data:data cellHeight:height type:type];
}

+ (CellDataAdapter *)dataAdapterWithData:(id)data cellHeight:(CGFloat)height {
    
    return [[self class] dataAdapterWithCellReuseIdentifier:nil data:data cellHeight:height type:0];
}

+ (CellDataAdapter *)dataAdapterWithData:(id)data {
    
    return [[self class] dataAdapterWithCellReuseIdentifier:nil data:data cellHeight:0 type:0];
}

+ (CellDataAdapter *)dataAdapterWithCellHeight:(CGFloat)height {
    
    return [[self class] dataAdapterWithCellReuseIdentifier:nil data:nil cellHeight:height type:0];
}

+ (CellDataAdapter *)fixedHeightTypeDataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier
                                                                  data:(id)data
                                                                  type:(NSInteger)type {
    
    NSString *tmpReuseIdentifier = reuseIdentifier.length <= 0 ? NSStringFromClass([self class]) : reuseIdentifier;
    return [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:tmpReuseIdentifier data:data cellHeight:[[self class] cellHeightWithData:data]
                                                          cellType:type];
}

+ (CellDataAdapter *)fixedHeightTypeDataAdapterWithData:(id)data type:(NSInteger)type {
    
    return [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:NSStringFromClass([self class])
                                                              data:data cellHeight:[[self class] cellHeightWithData:data]
                                                          cellType:type];
}

+ (CellDataAdapter *)fixedHeightTypeDataAdapterWithData:(id)data {
    
    return [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:NSStringFromClass([self class])
                                                              data:data cellHeight:[[self class] cellHeightWithData:data]
                                                          cellType:0];
}

+ (CellDataAdapter *)fixedHeightTypeDataAdapter {
    
    return [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:NSStringFromClass([self class]) data:nil cellHeight:[[self class] cellHeightWithData:nil] cellType:0];
}

#pragma mark - Layout type adapter.

+ (CellDataAdapter *)layoutTypeAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data type:(NSInteger)type {
    
    return [[self class] dataAdapterWithCellReuseIdentifier:reuseIdentifier data:data cellHeight:UITableViewAutomaticDimension type:type];
}

+ (CellDataAdapter *)layoutTypeAdapterWithData:(id)data type:(NSInteger)type {
    
    return [[self class] dataAdapterWithCellReuseIdentifier:nil data:data cellHeight:UITableViewAutomaticDimension type:type];
}

+ (CellDataAdapter *)layoutTypeAdapterWithData:(id)data {
    
    return [[self class] dataAdapterWithCellReuseIdentifier:nil data:data cellHeight:UITableViewAutomaticDimension type:0];
}

+ (CellDataAdapter *)layoutTypeAdapter {
    
    return [[self class] dataAdapterWithCellReuseIdentifier:nil data:nil cellHeight:UITableViewAutomaticDimension type:0];
}

#pragma mark -

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

+ (void)registerToTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier {
    
    [tableView registerClass:[self class] forCellReuseIdentifier:reuseIdentifier];
}

+ (void)registerToTableView:(UITableView *)tableView {
    
    [tableView registerClass:[self class] forCellReuseIdentifier:NSStringFromClass([self class])];
}

@end

@implementation UITableView (CustomCell)

- (CustomCell *)dequeueReusableCellAndLoadDataWithAdapter:(CellDataAdapter *)adapter indexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell = [self dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier forIndexPath:indexPath];
    [cell loadContentWithAdapter:adapter delegate:nil tableView:self indexPath:indexPath];
    
    return cell;
}

- (CustomCell *)dequeueReusableCellAndLoadDataWithAdapter:(CellDataAdapter *)adapter
                                                 delegate:(id <CustomCellDelegate>)delegate
                                                indexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell = [self dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier forIndexPath:indexPath];
    [cell loadContentWithAdapter:adapter delegate:delegate tableView:self indexPath:indexPath];
    
    return cell;
}

- (CGFloat)cellHeightWithAdapter:(CellDataAdapter *)adapter {
    
    return adapter.cellHeight;
}

- (void)selectedEventAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell = [self cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[CustomCell class]]) {
        
        [cell selectedEvent];
    }
}

@end
