//
//  TableGridView.m
//  GridTableView
//
//  Created by YouXianMing on 16/7/19.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "TableGridView.h"

@interface TableGridView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TableGridView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.tableView                              = [[UITableView alloc] initWithFrame:self.bounds];
        self.tableView.delegate                     = self;
        self.tableView.dataSource                   = self;
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.scrollEnabled                = NO;
        self.tableView.backgroundColor              = [UIColor clearColor];
        self.tableView.separatorStyle               = UITableViewCellSeparatorStyleNone;
        [self addSubview:self.tableView];
    }
    
    return self;
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _adapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:_adapters[indexPath.row].cellReuseIdentifier];
    cell.dataAdapter = _adapters[indexPath.row];
    cell.data        = _adapters[indexPath.row].data;
    cell.indexPath   = indexPath;
    cell.tableView   = tableView;
    
    [cell loadContent];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return _adapters[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    CustomCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell selectedEvent];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableGridView:didSelectedCell:)]) {
        
        [self.delegate tableGridView:self didSelectedCell:cell];
    }
}

#pragma mark - Setter & Getter

- (void)setRegisterCells:(NSArray <TableGridViewCellClassType *> *)registerCells {
    
    _registerCells = registerCells;
    
    for (TableGridViewCellClassType *type in registerCells) {
        
        [self.tableView registerClass:type.className forCellReuseIdentifier:type.reuseIdentifier];
    }
}

- (void)setScrollEnabled:(BOOL)scrollEnabled {

    _scrollEnabled               = scrollEnabled;
    self.tableView.scrollEnabled = scrollEnabled;
}

#pragma mark - Load data.

- (void)reloadData {
    
    [self.tableView reloadData];
}

#pragma mark - Size related.

- (CGSize)contentSize {

    return [self.tableView contentSize];
}

- (void)resetToSize:(CGSize)size {

    CGRect newFrame      = self.frame;
    newFrame.size        = size;
    self.frame           = newFrame;
    self.tableView.frame = newFrame;
}

@end

@implementation TableGridViewCellClassType

@end
