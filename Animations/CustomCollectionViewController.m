//
//  CustomCollectionViewController.m
//  Animations
//
//  Created by YouXianMing on 2017/7/11.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "CustomCollectionViewController.h"
#import "UIView+SetRect.h"
#import "GridCollectionItemView.h"
#import "GridItemCollectionViewCell.h"
#import "GridItemModel.h"
#import "HorizontalCollectionItemView.h"
#import "HorizontalPicItemCell.h"
#import "HorizontalPicItemModel.h"

@interface CustomCollectionViewController () <CustomCollectionViewDelegate>

@end

@implementation CustomCollectionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSArray *models = @[[GridItemModel gridItemModelWithTitle:@"bank"    icon:@"business-color_bank"],
                        [GridItemModel gridItemModelWithTitle:@"bug"     icon:@"design-color_bug"],
                        [GridItemModel gridItemModelWithTitle:@"design"  icon:@"design-color_design"],
                        [GridItemModel gridItemModelWithTitle:@"marker"  icon:@"design-color_marker"],
                        [GridItemModel gridItemModelWithTitle:@"mobile"  icon:@"design-color_mobile-design"],
                        [GridItemModel gridItemModelWithTitle:@"like"    icon:@"emoticons-color_like"],
                        [GridItemModel gridItemModelWithTitle:@"desktop" icon:@"tech-color_desktop"],
                        [GridItemModel gridItemModelWithTitle:@"edit"    icon:@"ui-color-1_edit-78"],
                        [GridItemModel gridItemModelWithTitle:@"setting" icon:@"ui-color-1_settings-gear-63"]];
    
    GridCollectionItemView *gridItemView = [GridCollectionItemView gridCollectionItemViewWithCollectionItemViewWidth:Width
                                                                                                            delegate:self
                                                                                                   verticalItemSpace:0
                                                                                                 horizontalItemSpace:0
                                                                                                          itemHeight:Width / 3.f
                                                                                                         contentEdge:UIEdgeInsetsZero
                                                                                                 horizontalCellCount:3
                                                                                                       registerCells:^(CustomCollectionView *customCollectionView) {
                                                                                                           
                                                                                                           [customCollectionView registerClass:[GridItemCollectionViewCell class]];
                                                                                                       }
                                                                                                         addAdapters:^(NSMutableArray<CellDataAdapter *> *adapters) {
                                                                                                             
                                                                                                             [models enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                                                                                                
                                                                                                                 [adapters addObject:[GridItemCollectionViewCell dataAdapterWithData:obj]];
                                                                                                             }];
                                                                                                         }];
    [self.contentView addSubview:gridItemView];
    gridItemView.left = 0.f;
    gridItemView.top  = 0.f;
    
    NSArray *imageModels = @[[HorizontalPicItemModel horizontalPicItemModelWithIconImage:[UIImage imageNamed:@"an_1"]],
                             [HorizontalPicItemModel horizontalPicItemModelWithIconImage:[UIImage imageNamed:@"an_2"]],
                             [HorizontalPicItemModel horizontalPicItemModelWithIconImage:[UIImage imageNamed:@"an_3"]],
                             [HorizontalPicItemModel horizontalPicItemModelWithIconImage:[UIImage imageNamed:@"an_4"]]];
    
    HorizontalCollectionItemView *horizontalItemView = [HorizontalCollectionItemView horizontalCollectionItemViewWithFrame:CGRectMake(0, gridItemView.bottom, Width, self.contentView.height - gridItemView.height)
                                                                                                                 ItemSpace:3
                                                                                                               contentEdge:UIEdgeInsetsMake(3, 3, 3, 3)
                                                                                                                  delegate:self
                                                                                                             registerCells:^(HorizontalCollectionItemView *collectionView) {
                                                                                                                 
                                                                                                                 [HorizontalPicItemCell registerToHorizontalCollectionItemView:collectionView];
                                                                                                             }
                                                                                                               addAdapters:^(NSMutableArray<CellDataAdapter *> *adapters) {
                                                                                                                   
                                                                                                                   [imageModels enumerateObjectsUsingBlock:^(HorizontalPicItemModel *obj, NSUInteger idx, BOOL *stop) {
                                                                                                                   
                                                                                                                       [adapters addObject:[HorizontalPicItemCell dataAdapterWithData:obj
                                                                                                                                                                            cellWidth:obj.iconImage.size.width / 2.f]];
                                                                                                                   }];
                                                                                                               }];
    [self.contentView addSubview:horizontalItemView];
}

#pragma mark - CustomCollectionViewDelegate

- (void)customCollectionView:(CustomCollectionView *)customCollectionView didSelectCell:(BaseCustomCollectionCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%@ %@", customCollectionView, indexPath);
}

@end
