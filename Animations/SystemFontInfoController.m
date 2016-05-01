//
//  SystemFontInfoController.m
//  Animations
//
//  Created by YouXianMing on 16/5/1.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "SystemFontInfoController.h"
#import "FontInfomation.h"
#import "UIView+SetRect.h"
#import "FontListCell.h"
#import "FontListHeaderView.h"
#import "FontInfoModel.h"

@interface SystemFontInfoController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) NSArray      *fontsList;

@end

@implementation SystemFontInfoController

- (void)setup {

    [super setup];
    
    NSDictionary   *fontListDictionary = [FontInfomation systomFontNameList];
    NSMutableArray *fontList           = [NSMutableArray array];
    
    [fontListDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        FontInfoModel *tmpModel = [FontInfoModel new];
        tmpModel.fontFamilyName = key;
        tmpModel.fontNames      = obj;
        
        [fontList addObject:tmpModel];
    }];
    
    self.fontsList = fontList;
    
    self.tableView                     = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    self.tableView.delegate            = self;
    self.tableView.dataSource          = self;
    self.tableView.separatorStyle      = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight           = 40;
    self.tableView.sectionHeaderHeight = 40;
    [self.contentView addSubview:self.tableView];
    
    [self.tableView registerClass:[FontListCell class]       forCellReuseIdentifier:@"FontListCell"];
    [self.tableView registerClass:[FontListHeaderView class] forHeaderFooterViewReuseIdentifier:@"FontListHeaderView"];
}

#pragma mark - UITableView's delegate & dataSource.

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.fontsList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    FontInfoModel *model = self.fontsList[section];
    
    return model.fontNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    FontInfoModel *model = self.fontsList[indexPath.section];
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FontListCell"];
    cell.data        = model.fontNames[indexPath.row];
    [cell loadContent];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    FontInfoModel *model = self.fontsList[section];
    
    FontListHeaderView *titleView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FontListHeaderView"];
    titleView.data                = model;
    titleView.section             = section;
    [titleView loadContent];
    
    return titleView;
}

@end
