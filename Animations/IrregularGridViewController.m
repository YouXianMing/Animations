//
//  IrregularGridViewController.m
//  Animations
//
//  Created by YouXianMing on 2016/11/11.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "IrregularGridViewController.h"
#import "UIView+SetRect.h"
#import "IrregularGridCollectionView.h"
#import "IrregularPictureGridCell.h"
#import "BlueIrregularGridViewCell.h"
#import "RedIrregularGridViewCell.h"
#import "NSString+LabelWidthAndHeight.h"
#import "UIFont+Fonts.h"
#import "Math.h"

typedef enum : NSUInteger {
    
    DirectionHorizontalType = 1000,
    DirectionVerticalType,
    
} IrregularGridCollectionViewTag;

@interface IrregularGridViewController () <IrregularGridCollectionViewDelegate>

@end

@implementation IrregularGridViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self createDirectionHorizontalType];
    
    [self createDirectionVerticalType];
}

- (void)createDirectionHorizontalType {
    
    CGFloat edgeInsetTop    = 10.f;
    CGFloat gridHeight      = self.contentView.height / 2.f  - 20.f;
    CGFloat edgeInsetBottom = 10.f;
    
    // Create dataSource.
    NSArray *images = @[[UIImage imageNamed:@"an_1.jpg"],
                        [UIImage imageNamed:@"1.jpg"],
                        [UIImage imageNamed:@"an_2.jpg"],
                        [UIImage imageNamed:@"2.jpg"],
                        [UIImage imageNamed:@"an_3.jpg"],
                        [UIImage imageNamed:@"3.jpg"],
                        [UIImage imageNamed:@"an_4.jpg"],
                        [UIImage imageNamed:@"4.jpg"]];
    
    NSMutableArray *arrays = [NSMutableArray array];
    [images enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [arrays addObject:[IrregularPictureGridCell dataAdapterWithData:image itemWidth:[Math resetFromSize:image.size withFixedHeight:gridHeight].width]];
    }];
    
    // Create IrregularGridCollectionView.
    IrregularGridCollectionView *irregularGridView;
    CGFloat height    = edgeInsetTop + gridHeight + edgeInsetBottom; // EdgeInsetTop + GridHeight + EdgeInsetBottom
    irregularGridView = [IrregularGridCollectionView irregularGridCollectionViewWithFrame:CGRectMake(0, 0, Width, height)
                                                                                 delegate:self
                                                                            registerCells:@[gridViewCellClassType([IrregularPictureGridCell class], nil)]
                                                                          scrollDirection:UICollectionViewScrollDirectionHorizontal
                                                                        contentEdgeInsets:UIEdgeInsetsMake(edgeInsetTop, 10, edgeInsetBottom, 10)
                                                                              lineSpacing:0.f
                                                                         interitemSpacing:10.f
                                                                               gridHeight:gridHeight];
    irregularGridView.tag      = DirectionHorizontalType;
    irregularGridView.adapters = arrays;
    [self.contentView addSubview:irregularGridView];
    
    // Debug frame.
    if (/* DISABLES CODE */ (0)) {
        
        irregularGridView.layer.borderWidth = 0.5f;
        irregularGridView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.35f].CGColor;
    }
}

- (void)createDirectionVerticalType {
    
    // Create dataSource.
    NSMutableArray *array  = [NSMutableArray array];
    NSArray        *titles = @[@"YouXianMing",
                               @"Debug",
                               @"Create",
                               @"Xcode8.1",
                               @"NSMutableArray",
                               @"UIColor",
                               @"UIFont",
                               @"WaterFall",
                               @"IrregularGridCollectionView",
                               @"AvenirLight",
                               @"PS4"];
    
    for (int i = 0; i < titles.count; i++) {
        
        NSString *string = titles[i];
        CGFloat   value  = [string widthWithStringFont:[UIFont AvenirLightWithFontSize:12.f]] + 40.f;
        arc4random() % 2 ?
        [array addObject:[RedIrregularGridViewCell  dataAdapterWithData:string type:0 itemWidth:value]]:
        [array addObject:[BlueIrregularGridViewCell dataAdapterWithData:string type:0 itemWidth:value]];
    }
    
    // Create IrregularGridCollectionView.
    IrregularGridCollectionView *irregularGridView;
    irregularGridView = [IrregularGridCollectionView irregularGridCollectionViewWithFrame:CGRectMake(0, self.contentView.height / 2.f, Width, 0)
                                                                                 delegate:self
                                                                            registerCells:@[gridViewCellClassType([RedIrregularGridViewCell class],  nil),
                                                                                            gridViewCellClassType([BlueIrregularGridViewCell class], nil)]
                                                                          scrollDirection:UICollectionViewScrollDirectionVertical
                                                                        contentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)
                                                                              lineSpacing:10
                                                                         interitemSpacing:10.f
                                                                               gridHeight:30.f];
    irregularGridView.tag      = DirectionVerticalType;
    irregularGridView.adapters = array;
    [irregularGridView resetSize];
    [self.contentView addSubview:irregularGridView];
    
    // Debug frame.
    if (/* DISABLES CODE */ (1)) {
        
        irregularGridView.layer.borderWidth = 0.5f;
        irregularGridView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.35f].CGColor;
    }
}

#pragma mark - IrregularGridCollectionViewDelegate

- (void)irregularGridCollectionView:(IrregularGridCollectionView *)irregularGridCollectionView
                    didSelectedCell:(CustomIrregularGridViewCell *)cell
                              event:(id)event {
    
    NSLog(@"event -> %@", event);
    
    if (irregularGridCollectionView.tag == DirectionVerticalType) {
        
        // 更新数据的动画
        [irregularGridCollectionView.collectionView performBatchUpdates:^{
            
            [irregularGridCollectionView.adapters removeObjectAtIndex:cell.indexPath.row];
            [irregularGridCollectionView.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:cell.indexPath.row inSection:0]]];
            
        } completion:^(BOOL finished) {
            
            // 重置数据
            [irregularGridCollectionView.collectionView reloadData];
            [UIView animateWithDuration:0.35f animations:^{
                
                [irregularGridCollectionView resetSize];
                
                if (irregularGridCollectionView.adapters.count <= 0) {
                    
                    irregularGridCollectionView.alpha = 0.f;
                }
            }];
        }];
    }
}

@end
