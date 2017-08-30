//
//  TwoLevelLinkageView.m
//  SecondList
//
//  Created by YouXianMing on 2017/8/25.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "TwoLevelLinkageView.h"

@interface TwoLevelLinkageView () <UITableViewDelegate, UITableViewDataSource> {
    
    UITableView *_leftSideTableView;
    UITableView *_rightSideTableView;
}

@property (nonatomic) NSInteger currentLeftSideSectionValue; // 当前左边tableView选中的row值
@property (nonatomic) BOOL isInSelectedAnimationDuration;    // 是否正处于选中过程的动画当中

@end

@implementation TwoLevelLinkageView

- (instancetype)initWithFrame:(CGRect)frame leftSideWidth:(CGFloat)leftSideWidth {
    
    if (self = [super initWithFrame:frame]) {
        
        CGFloat width  = frame.size.width;
        CGFloat height = frame.size.height;
        
        _leftSideTableView            = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, leftSideWidth, height)];
        _leftSideTableView.delegate   = self;
        _leftSideTableView.dataSource = self;
        [self addSubview:_leftSideTableView];
        
        _rightSideTableView            = [[UITableView alloc] initWithFrame:CGRectMake(leftSideWidth, 0, width - leftSideWidth, height)];
        _rightSideTableView.delegate   = self;
        _rightSideTableView.dataSource = self;
        [self addSubview:_rightSideTableView];
        
        _leftSideTableView.showsVerticalScrollIndicator  = NO;
        _leftSideTableView.separatorStyle                = UITableViewCellSeparatorStyleNone;
        
        _rightSideTableView.showsVerticalScrollIndicator = NO;
        _rightSideTableView.separatorStyle               = UITableViewCellSeparatorStyleNone;
        
        [_rightSideTableView addObserver:self
                              forKeyPath:@"contentOffset"
                                 options:NSKeyValueObservingOptionNew
                                 context:nil];
    }
    
    return self;
}

- (void)registerCellsWithLeftSideTableView:(void (^)(UITableView *tableView))leftSideTableViewBlock registerCellsAndHeadersWithRightSideTableView:(void (^)(UITableView *tableView))rightSideTableViewBlock {
    
    if (leftSideTableViewBlock) {
        
        leftSideTableViewBlock(_leftSideTableView);
    }
    
    if (rightSideTableViewBlock) {
        
        rightSideTableViewBlock(_rightSideTableView);
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if ([tableView isEqual:_leftSideTableView]) {
        
        return 1;
        
    } else {
        
        return self.models.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([tableView isEqual:_leftSideTableView]) {
        
        return self.models.count;
        
    } else {
        
        return self.models[section].subModels.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *adapter = [self adapterWithTableView:tableView indexPath:indexPath];
    
    CustomLevelLinkageCell *cell = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.dataAdapter             = adapter;
    cell.tableView               = tableView;
    cell.data                    = adapter.data;
    cell.levelModel              = [self levelModelWithTableView:tableView indexPath:indexPath];
    cell.indexPath               = indexPath;
    [cell loadContent];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self adapterWithTableView:tableView indexPath:indexPath].cellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if ([tableView isEqual:_rightSideTableView]) {
        
        CellHeaderFooterDataAdapter *adapter = self.models[section].headerAdapter;
        
        CustomHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:adapter.reuseIdentifier];
        headerView.dataAdapter             = adapter;
        headerView.data                    = adapter.data;
        headerView.section                 = section;
        [headerView loadContent];
        
        return headerView;
        
    } else {
        
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if ([tableView isEqual:_rightSideTableView]) {
        
        return self.models[section].headerAdapter.height;
        
    } else {
        
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 右边tableView正在滑动而此时正在点击左边tableView的cell
    if ([tableView isEqual:_leftSideTableView] && _rightSideTableView.isDecelerating && _rightSideTableView.isDragging) {

        [_rightSideTableView setContentOffset:_rightSideTableView.contentOffset animated:NO];
        [_leftSideTableView setContentOffset:_leftSideTableView.contentOffset animated:NO];
        return;
    }
    
    if ([tableView isEqual:_leftSideTableView]) {
        
        NSInteger oldSelectedIndex = [self leftTableViewCurrentSelectedCellIndex];
        NSInteger newSelectedIndex = indexPath.row;
        
        // 点击cell事件
        if (self.delegate && [self.delegate respondsToSelector:@selector(twoLevelLinkageView:selectedLeftSideTableViewItemRow:item:)]) {
            
            [self.delegate twoLevelLinkageView:self selectedLeftSideTableViewItemRow:newSelectedIndex item:self.models[newSelectedIndex].adapter.data];
        }
        
        // 重复点击同一个cell无效
        if (oldSelectedIndex == newSelectedIndex) {
            
            return;
        }
        
        [self updateSelectedIndexValueWithOldIndex:oldSelectedIndex newIndex:newSelectedIndex];
        [self updateLeftSideTableViewCellStateWithRow:oldSelectedIndex selectedState:NO];
        [self updateLeftSideTableViewCellStateWithRow:newSelectedIndex selectedState:YES];
        
        self.isInSelectedAnimationDuration = YES;
        [_rightSideTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:newSelectedIndex]
                                   atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        // 解决最后两个cell点击不移动时出现的bug
        [self performSelector:@selector(makeIsInSelectedAnimationDurationEquilNO) withObject:nil afterDelay:0.05f];
        
    } else {
        
        // 点击cell事件
        if (self.delegate && [self.delegate respondsToSelector:@selector(twoLevelLinkageView:selectedRightSideTableViewItemIndexPath:item:)]) {
            
            [self.delegate twoLevelLinkageView:self selectedRightSideTableViewItemIndexPath:indexPath
                                          item:self.models[indexPath.section].subModels[indexPath.row].adapter.data];
        }
    }
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([scrollView isEqual:_rightSideTableView] && self.isInSelectedAnimationDuration == NO) {
        
        NSInteger section = [_rightSideTableView indexPathForCell:_rightSideTableView.visibleCells.firstObject].section;
        if (self.currentLeftSideSectionValue != section) {
            
            self.currentLeftSideSectionValue = section;
            
            NSInteger oldSelectedIndex = [self leftTableViewCurrentSelectedCellIndex];
            NSInteger newSelectedIndex = section;
            [self updateSelectedIndexValueWithOldIndex:oldSelectedIndex newIndex:newSelectedIndex];
            [self updateLeftSideTableViewCellStateWithRow:oldSelectedIndex selectedState:NO];
            [self updateLeftSideTableViewCellStateWithRow:newSelectedIndex selectedState:YES];
            
            [_leftSideTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:newSelectedIndex inSection:0]
                                      atScrollPosition:UITableViewScrollPositionMiddle
                                              animated:YES];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    if ([scrollView isEqual:_rightSideTableView]) {
        
        self.isInSelectedAnimationDuration = NO;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    if ([scrollView isEqual:_rightSideTableView]) {
        
        self.isInSelectedAnimationDuration = NO;
    }
}

#pragma mark - Other

- (void)makeIsInSelectedAnimationDurationEquilNO {
    
    NSLog(@"makeIsInSelectedAnimationDurationEquilNO");
    self.currentLeftSideSectionValue   = [self leftTableViewCurrentSelectedCellIndex];
    self.isInSelectedAnimationDuration = NO;
}

- (NSInteger)leftTableViewCurrentSelectedCellIndex {
    
    __block NSInteger oldIndex;
    [self.models enumerateObjectsUsingBlock:^(LinkageOneLevelModel *model, NSUInteger idx, BOOL *stop) {
        
        if (model.selected) {
            
            oldIndex = idx;
            *stop    = YES;
        }
    }];
    
    return oldIndex;
}

- (void)updateLeftSideTableViewCellStateWithRow:(NSInteger)row selectedState:(BOOL)selectedState {
    
    CustomLevelLinkageCell *cell = [_leftSideTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    selectedState ? [cell updateToSelectedStateAnimated:YES] : [cell updateToNormalStateAnimated:YES];
}

- (void)updateSelectedIndexValueWithOldIndex:(NSInteger)oldIndex newIndex:(NSInteger)newIndex {
    
    self.models[oldIndex].selected = NO;
    self.models[newIndex].selected = YES;
}

- (id)levelModelWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    
    id data = nil;
    
    if ([tableView isEqual:_leftSideTableView]) {
        
        data = self.models[indexPath.row];
        
    } else {
        
        data = self.models[indexPath.section].subModels[indexPath.row];
    }
    
    return data;
}

- (CellDataAdapter *)adapterWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *adapter = nil;
    NSInteger        section = indexPath.section;
    NSInteger        row     = indexPath.row;
    
    if ([tableView isEqual:_leftSideTableView]) {
        
        adapter = self.models[row].adapter;
        
    } else {
        
        adapter = self.models[section].subModels[row].adapter;
    }
    
    return adapter;
}

- (void)reloadData {
    
    [_leftSideTableView reloadData];
    [_rightSideTableView reloadData];
}

- (void)leftTableViewCellMakeSelectedAtRow:(NSInteger)row {
    
    CustomLevelLinkageCell *cell = [_leftSideTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    [cell updateToSelectedStateAnimated:NO];
}

#pragma mark - System

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    // 点击左侧tableView中的cell触发移动
    if (self.isInSelectedAnimationDuration == YES) {
    
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(makeIsInSelectedAnimationDurationEquilNO) object:nil];
    }
}

- (void)dealloc {
    
    [_rightSideTableView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
