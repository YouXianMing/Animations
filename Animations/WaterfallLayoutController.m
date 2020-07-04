//
//  WaterfallLayoutController.m
//  Animations
//
//  Created by YouXianMing on 16/1/3.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "WaterfallLayoutController.h"
#import "CollectionSectionData.h"
#import "BaseCustomCollectionCell.h"
#import "CustomCollectionReusableView.h"
#import "NSData+JSONData.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "WaterfallCell.h"
#import "WaterfallHeaderView.h"
#import "FileManager.h"
#import "DuitangPicModel.h"
#import "UIView+SetRect.h"
#import "DeviceInfo.h"
#import "NSArray+Split.h"

@interface WaterfallLayoutController () <UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout, CustomCollectionCellDelegate, CustomCollectionReusableViewDelegate>

@property (nonatomic, strong) CHTCollectionViewWaterfallLayout         *layout;
@property (nonatomic, strong) UICollectionView                         *collectionView;
@property (nonatomic, strong) NSMutableArray <CollectionSectionData *> *sectionDatas;

@end

@implementation WaterfallLayoutController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 数据
    self.sectionDatas = [NSMutableArray array];

    // 初始化布局
    self.layout = CHTCollectionViewWaterfallLayout.new;
    
    // 初始化collectionView
    self.collectionView                  = [[UICollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:self.layout];
    self.collectionView.dataSource       = self;
    self.collectionView.delegate         = self;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.collectionView.backgroundColor  = UIColor.clearColor;
    [self.contentView addSubview:self.collectionView];
    
    // Adjust iOS 11.0
    if (@available(iOS 11.0, *)) {
        
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    // 注册cell,header
    [WaterfallCell       registerToCollectionView:self.collectionView];
    [WaterfallHeaderView waterfallHeaderRegisterToCollectionView:self.collectionView];
        
    // 数据源
    NSMutableArray <DuitangPicModel *> *models      = [NSMutableArray array];
    NSArray                            *duitangPics = [[NSData dataWithContentsOfFile:[FileManager bundleFileWithName:@"duitang.json"]] toListProperty];
    [duitangPics enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [models addObject:[[DuitangPicModel alloc] initWithDictionary:obj]];
    }];
    
    NSArray <NSArray <DuitangPicModel *> *> *sections = [models splitWithCount:(NSInteger)models.count / 3.f - 1];
    
    // Section 0
    {
        CollectionSectionData *sectionData  = [CollectionSectionData new];
        sectionData.minimumLineSpacing      = 0.f;
        sectionData.minimumInteritemSpacing = 0.f;
        sectionData.columnCountForSection   = 3;
        sectionData.sectionInsets           = UIEdgeInsetsMake(0, 0, 0, 0);
        sectionData.waterfallHeaderData     = [WaterfallHeaderView waterfallHeaderDataWithData:@"Section 1" sectionHeight:WaterfallHeaderView.referenceSize.height];
        [self.sectionDatas addObject:sectionData];
        
        [sections[0] enumerateObjectsUsingBlock:^(DuitangPicModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [sectionData.adapters addObject:[WaterfallCell dataAdapterWithData:model itemSize:CGSizeMake(model.width.floatValue, model.height.floatValue)]];
        }];
    }
    
    // Section 1
    {
        CollectionSectionData *sectionData  = [CollectionSectionData new];
        sectionData.minimumLineSpacing      = 5.f;
        sectionData.minimumInteritemSpacing = 5.f;
        sectionData.columnCountForSection   = 4;
        sectionData.sectionInsets           = UIEdgeInsetsMake(5, 5, 5, 5);
        sectionData.waterfallHeaderData     = [WaterfallHeaderView waterfallHeaderDataWithData:@"Section 2" sectionHeight:WaterfallHeaderView.referenceSize.height];
        [self.sectionDatas addObject:sectionData];
        
        [sections[1] enumerateObjectsUsingBlock:^(DuitangPicModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [sectionData.adapters addObject:[WaterfallCell dataAdapterWithData:model itemSize:CGSizeMake(model.width.floatValue, model.height.floatValue)]];
        }];
    }
    
    // Section 2
    {
        CollectionSectionData *sectionData  = [CollectionSectionData new];
        sectionData.minimumLineSpacing      = 10.f;
        sectionData.minimumInteritemSpacing = 10.f;
        sectionData.columnCountForSection   = 5;
        sectionData.sectionInsets           = UIEdgeInsetsMake(10, 10, 10, 10);
        sectionData.waterfallHeaderData     = [WaterfallHeaderView waterfallHeaderDataWithData:@"Section 3" sectionHeight:WaterfallHeaderView.referenceSize.height];
        [self.sectionDatas addObject:sectionData];
        
        [sections[2] enumerateObjectsUsingBlock:^(DuitangPicModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [sectionData.adapters addObject:[WaterfallCell dataAdapterWithData:model itemSize:CGSizeMake(model.width.floatValue, model.height.floatValue)]];
        }];
    }
    
    [self.collectionView reloadData];
}

#pragma mark - BaseCustomCollectionCellDelegate

- (void)customCollectionCell:(BaseCustomCollectionCell *)cell event:(id)event {
    
}

#pragma mark - CustomCollectionReusableViewDelegate

- (void)customCollectionReusableView:(CustomCollectionReusableView *)reusableView event:(id)event {
    
}
    
#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.sectionDatas.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.sectionDatas[section].adapters.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter          *adapter = self.sectionDatas[indexPath.section].adapters[indexPath.row];
    BaseCustomCollectionCell *cell    = [collectionView dequeueReusableCellWithReuseIdentifier:adapter.cellReuseIdentifier forIndexPath:indexPath];
    cell.dataAdapter                  = adapter;
    cell.data                         = adapter.data;
    cell.indexPath                    = indexPath;
    cell.delegate                     = self;
    [cell loadContent];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    CollectionSectionData *data = self.sectionDatas[indexPath.section];
    
    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
        
        CustomCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:data.waterfallHeaderData.elementKind
                                                                                withReuseIdentifier:data.waterfallHeaderData.reuseIdentifier
                                                                                       forIndexPath:indexPath];
        view.sectionData = data;
        view.delegate    = self;
        view.indexPath   = indexPath;
        [view loadContent];
        
        return view;
        
    } else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
        
        CustomCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:data.waterfallFooterData.elementKind
                                                                                withReuseIdentifier:data.waterfallFooterData.reuseIdentifier
                                                                                       forIndexPath:indexPath];
        view.sectionData = data;
        view.delegate    = self;
        view.indexPath   = indexPath;
        [view loadContent];
        
        return view;
        
    } else {
        
        return nil;
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseCustomCollectionCell *tmp = (BaseCustomCollectionCell *)cell;
    tmp.display                   = YES;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseCustomCollectionCell *tmp = (BaseCustomCollectionCell *)cell;
    tmp.display                   = NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseCustomCollectionCell *cell = (BaseCustomCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ([cell isKindOfClass:BaseCustomCollectionCell.class]) {
        
        [cell selectedEvent];
    }
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.sectionDatas[indexPath.section].adapters[indexPath.row].itemSize;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout columnCountForSection:(NSInteger)section {
    
    return self.sectionDatas[section].columnCountForSection;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section {
    
    WaterfallCollectionSectionHeaderData *headerData = self.sectionDatas[section].waterfallHeaderData;
    return headerData ? headerData.sectionHeight : 0.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section {
    
    WaterfallCollectionSectionFooterData *footerData = self.sectionDatas[section].waterfallFooterData;
    return footerData ? footerData.sectionHeight : 0.f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return self.sectionDatas[section].sectionInsets;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForHeaderInSection:(NSInteger)section {
    
    WaterfallCollectionSectionHeaderData *headerData = self.sectionDatas[section].waterfallHeaderData;
    return headerData ? headerData.sectionInsets : UIEdgeInsetsZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForFooterInSection:(NSInteger)section {
    
    WaterfallCollectionSectionFooterData *footerData = self.sectionDatas[section].waterfallFooterData;
    return footerData ? footerData.sectionInsets : UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return self.sectionDatas[section].minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumColumnSpacingForSectionAtIndex:(NSInteger)section {
    
    return self.sectionDatas[section].minimumInteritemSpacing;
}

@end
