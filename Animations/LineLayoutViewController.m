//
//  LineLayoutViewController.m
//  Animations
//
//  Created by YouXianMing on 2017/10/16.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "LineLayoutViewController.h"
#import "LineLayout.h"
#import "ComplexLineLayout.h"
#import "LineLayoutCollectionViewDebugCell.h"
#import "LineLayoutCollectionViewCell.h"
#import "Masonry.h"
#import "WanDouJiaModel.h"
#import "NSData+JSONData.h"
#import "FileManager.h"

@interface LineLayoutViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) UICollectionView                   *collectionView;
@property (nonatomic, strong) UICollectionViewLayout             *layout;

@end

@implementation LineLayoutViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    static NSInteger layoutType = 0;
    layoutType                 += 1;
    BOOL isDebug                = arc4random() % 2;
    
    // 数据源
    self.adapters         = [NSMutableArray array];
    NSDictionary   *data  = [[NSData dataWithContentsOfFile:[FileManager bundleFileWithName:@"LineLayoutData.json"]] toListProperty];
    WanDouJiaModel *model = [[WanDouJiaModel alloc] initWithDictionary:data];
    if (isDebug) {
        
        [model.dailyList enumerateObjectsUsingBlock:^(DailyListModel *dailyListModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [dailyListModel.videoList enumerateObjectsUsingBlock:^(VideoListModel *videoListModel, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [self.adapters addObject:[LineLayoutCollectionViewDebugCell dataAdapterWithData:videoListModel]];
            }];
        }];
        
    } else {
        
        [model.dailyList enumerateObjectsUsingBlock:^(DailyListModel *dailyListModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [dailyListModel.videoList enumerateObjectsUsingBlock:^(VideoListModel *videoListModel, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [self.adapters addObject:[LineLayoutCollectionViewCell dataAdapterWithData:videoListModel]];
            }];
        }];
    }
    
    // 布局文件
    self.layout                         = layoutType % 2 ? [ComplexLineLayout new] : [LineLayout new];
    self.collectionView                 = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
    self.collectionView.contentInset    = UIEdgeInsetsMake(10, 50, 10, 50);
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.collectionView];
    
    [LineLayoutCollectionViewDebugCell registerToCollectionView:self.collectionView];
    [LineLayoutCollectionViewCell      registerToCollectionView:self.collectionView];
    
    // collectionView的一些配置
    self.collectionView.layer.borderWidth = 0.5f;
    self.collectionView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5f].CGColor;
    self.collectionView.showsVerticalScrollIndicator   = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.contentView);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.equalTo(self.contentView).multipliedBy(0.3f);
    }];
    
    // debug用,显示UICollectionView的contentInset区域
    if (isDebug) {
        
        UIView *debugView                = [UIView new];
        debugView.backgroundColor        = [[UIColor yellowColor] colorWithAlphaComponent:0.05f];
        debugView.userInteractionEnabled = NO;
        debugView.layer.borderWidth      = 0.5f;
        debugView.layer.borderColor      = [[UIColor grayColor] colorWithAlphaComponent:0.15f].CGColor;
        [self.contentView addSubview:debugView];
        [debugView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            UIEdgeInsets contentInsets = self.collectionView.contentInset;
            
            make.center.equalTo(self.contentView);
            make.left.equalTo(self.collectionView.mas_left).offset(contentInsets.left);
            make.right.equalTo(self.collectionView.mas_right).offset(-contentInsets.right);
            make.top.equalTo(self.collectionView.mas_top).offset(contentInsets.top);
            make.bottom.equalTo(self.collectionView.mas_bottom).offset(-contentInsets.bottom);
        }];
    }
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 10;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.adapters.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseCustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.adapters[indexPath.row].cellReuseIdentifier forIndexPath:indexPath];
    cell.data                      = self.adapters[indexPath.row].data;
    cell.indexPath                 = indexPath;
    [cell loadContent];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

@end
