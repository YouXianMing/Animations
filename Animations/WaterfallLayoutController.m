//
//  WaterfallLayoutController.m
//  Animations
//
//  Created by YouXianMing on 16/1/3.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "WaterfallLayoutController.h"
#import "NSData+JSONData.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "WaterfallCell.h"
#import "WaterfallHeaderView.h"
#import "WaterfallFooterView.h"
#import "NSString+MD5.h"
#import "FileManager.h"
#import "DuitangPicModel.h"
#import "UIView+SetRect.h"

static NSString *cellIdentifier   = @"WaterfallCell";
static NSString *headerIdentifier = @"WaterfallHeader";
static NSString *footerIdentifier = @"WaterfallFooter";

@interface WaterfallLayoutController () <UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray   <DuitangPicModel *> *dataSource;

@end

@implementation WaterfallLayoutController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
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
    
    // Adjust iOS 11.0
    if (@available(iOS 11.0, *)) {
        
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        if (iPhoneX) {
            
            _collectionView.contentInset = UIEdgeInsetsMake(UIView.additionaliPhoneXTopSafeHeight, 0, UIView.additionaliPhoneXBottomSafeHeight, 0);
        }
    }
    
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
    
    // 数据源
    self.dataSource = [NSMutableArray array];
    NSArray *duitangPics = [[NSData dataWithContentsOfFile:[FileManager bundleFileWithName:@"duitang.json"]] toListProperty];
    [duitangPics enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.dataSource addObject:[[DuitangPicModel alloc] initWithDictionary:obj]];
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
        
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        
    } else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
        
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerIdentifier forIndexPath:indexPath];
    }
    
    return reusableView;
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DuitangPicModel *pictureModel = _dataSource[indexPath.row];
    
    return CGSizeMake(pictureModel.width.floatValue, pictureModel.height.floatValue);
}

@end
