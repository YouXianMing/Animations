//
//  WaterfallLayoutController.m
//  Animations
//
//  Created by YouXianMing on 16/1/3.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "WaterfallLayoutController.h"
#import "NSData+JSONData.h"
#import "GCD.h"
#import "ResponseData.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "WaterfallCell.h"
#import "WaterfallHeaderView.h"
#import "WaterfallFooterView.h"
#import "NSString+MD5.h"
#import "FileManager.h"

static NSString *picturesSource   = @"http://www.duitang.com/album/1733789/masn/p/0/50/";
static NSString *cellIdentifier   = @"WaterfallCell";
static NSString *headerIdentifier = @"WaterfallHeader";
static NSString *footerIdentifier = @"WaterfallFooter";

@interface WaterfallLayoutController () <UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray   <WaterfallPictureModel *> *dataSource;

@property (nonatomic, strong) ResponseData *picturesData;

@end

@implementation WaterfallLayoutController

- (void)setup {
    
    [super setup];
    
    self.backgroundView.backgroundColor = [UIColor blackColor];
    
    // 数据源
    _dataSource = [NSMutableArray new];

    // 初始化布局
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    
    // 设置布局
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.headerHeight = 64;            // headerView高度
    layout.footerHeight = 0;             // footerView高度
    layout.columnCount  = 3;             // 几列显示
    layout.minimumColumnSpacing    = 0;  // cell之间的水平间距
    layout.minimumInteritemSpacing = 0;  // cell之间的垂直间距
    
    // 初始化collectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:self.contentView.bounds
                                         collectionViewLayout:layout];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _collectionView.dataSource       = self;
    _collectionView.delegate         = self;
    _collectionView.backgroundColor  = [UIColor clearColor];
    
    // 注册cell以及HeaderView，FooterView
    [_collectionView registerClass:[WaterfallCell class] forCellWithReuseIdentifier:cellIdentifier ];
    [_collectionView registerClass:[WaterfallHeaderView class]
        forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
               withReuseIdentifier:headerIdentifier];
    [_collectionView registerClass:[WaterfallFooterView class]
        forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
               withReuseIdentifier:footerIdentifier];
    
    // 添加到视图当中
    [self.contentView addSubview:_collectionView];
    
    // 获取数据
    [GCDQueue executeInGlobalQueue:^{
        
        NSString *string       = [picturesSource lowerMD532BitString];
        NSString *realFilePath = [FileManager theRealFilePath:[NSString stringWithFormat:@"~/Documents/%@", string]];
        NSData   *data         = nil;

        if ([FileManager fileExistWithRealFilePath:realFilePath] == NO) {
            
            data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:picturesSource]];
            [data writeToFile:realFilePath atomically:YES];
            
        } else {
        
            data = [NSData dataWithContentsOfFile:realFilePath];
        }
        
        NSDictionary *dataDic = [data toListProperty];
        
        [GCDQueue executeInMainQueue:^{
            
            self.picturesData = [[ResponseData alloc] initWithDictionary:dataDic];
            if (self.picturesData.success.integerValue == 1) {

                NSMutableArray *indexPaths = [NSMutableArray array];
                
                for (int i = 0; i < self.picturesData.data.blogs.count; i++) {
                    
                    [_dataSource addObject:self.picturesData.data.blogs[i]];
                    [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:0]];
                }
                
                [_collectionView insertItemsAtIndexPaths:indexPaths];
            }
        }];
    }];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"点击了 %@", _dataSource[indexPath.row]);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_dataSource count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WaterfallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.data           = _dataSource[indexPath.row];
    [cell loadContent];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = nil;
    
    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
        
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:headerIdentifier
                                                                 forIndexPath:indexPath];
        
    } else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
        
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:footerIdentifier
                                                                 forIndexPath:indexPath];
    }
    
    return reusableView;
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WaterfallPictureModel *pictureModel = _dataSource[indexPath.row];
    
    return CGSizeMake(pictureModel.iwd.floatValue, pictureModel.iht.floatValue);
}

@end
