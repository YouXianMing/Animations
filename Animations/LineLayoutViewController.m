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
#import "LineLayoutCollectionViewCell.h"
#import "Masonry.h"

static NSString *reuseIdentifier = @"reuseIdentifier";

@interface LineLayoutViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView       *collectionView;
@property (nonatomic, strong) UICollectionViewLayout *layout;
@property (nonatomic, strong) NSMutableArray         *datasArray;

@end

@implementation LineLayoutViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 布局文件
    self.layout = arc4random() % 2 ? [ComplexLineLayout new] : [LineLayout new];
    
    self.collectionView                 = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
    self.collectionView.contentInset    = UIEdgeInsetsMake(10, 50, 10, 50);
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.collectionView];
    
    [LineLayoutCollectionViewCell registerToCollectionView:self.collectionView];
    
    // collectionView的一些配置
    self.collectionView.layer.borderWidth = 0.5f;
    self.collectionView.layer.borderColor = [UIColor grayColor].CGColor;
    self.collectionView.showsVerticalScrollIndicator   = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.contentView);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.equalTo(self.contentView).multipliedBy(0.3f);
    }];
    
    // debug用,显示UICollectionView的contentInset区域
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

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 10;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LineLayoutCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LineLayoutCollectionViewCell" forIndexPath:indexPath];
    cell.indexPath                     = indexPath;
    [cell loadContent];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

@end
