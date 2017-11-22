//
//  DynamicSwitchingLayoutController.m
//  Animations
//
//  Created by YouXianMing on 2017/10/31.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "DynamicSwitchingLayoutController.h"
#import "FileManager.h"
#import "NSData+JSONData.h"
#import "DuitangPicModel.h"
#import "DynamicSwitchingCell.h"
#import "Math.h"
#import "UIView+SetRect.h"
#import "UIButton+Inits.h"
#import "UIFont+Fonts.h"

static const CGFloat gap       = 5.f;
static CGFloat       itemCount = 3.f;

@interface DynamicSwitchingLayoutController () <UICollectionViewDataSource, UICollectionViewDelegate> {
    
    UIButton *_changeButton;
}

@property (nonatomic, strong) UICollectionView                   *collectionView;
@property (nonatomic, strong) NSMutableArray <DuitangPicModel *> *dataSource;
@property (nonatomic, strong) UICollectionViewFlowLayout         *flowLayout;

@end

@implementation DynamicSwitchingLayoutController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 数据源
    self.dataSource = [NSMutableArray array];
    NSArray *duitangPics = [[NSData dataWithContentsOfFile:[FileManager bundleFileWithName:@"duitang.json"]] toListProperty];
    [duitangPics enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.dataSource addObject:[[DuitangPicModel alloc] initWithDictionary:dict]];
    }];
    
    // 布局
    self.flowLayout                         = [UICollectionViewFlowLayout new];
    self.flowLayout.minimumLineSpacing      = gap;
    self.flowLayout.minimumInteritemSpacing = gap;
    self.flowLayout.itemSize                = [Math resetFromSize:CGSizeMake(100, 150.f) withFixedWidth:(Width - gap * (itemCount + 1)) / itemCount];
    
    // collectionView
    self.collectionView                 = [[UICollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:self.flowLayout];
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
    self.collectionView.contentInset    = UIEdgeInsetsMake(gap, gap, gap, gap);
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.collectionView];
    
    // cell
    [DynamicSwitchingCell registerToCollectionView:self.collectionView];
}

- (void)setupSubViews {
    
    [super setupSubViews];
    
    UIButton *button             = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200.f, StatusBarAndNavigationBarHeight)];
    button.bottom                = self.titleView.height;
    button.normalTitle           = @"切换";
    button.titleLabel.font       = [UIFont HeitiSCWithFontSize:16.f];
    button.normalTitleColor      = [UIColor colorWithRed:0.329  green:0.329  blue:0.329 alpha:1];
    button.highlightedTitleColor = [[UIColor colorWithRed:0.329  green:0.329  blue:0.329 alpha:1] colorWithAlphaComponent:0.5];
    button.disabledTitleColor    = [[UIColor colorWithRed:0.329  green:0.329  blue:0.329 alpha:1] colorWithAlphaComponent:0.5];
    button.right                 = Width;
    _changeButton                = button;
    [self.titleView addSubview:button];
    [button addTarget:self action:@selector(changeEvent)];
    [button titleLabelHorizontalAlignment:UIControlContentHorizontalAlignmentRight
                        verticalAlignment:UIControlContentVerticalAlignmentCenter
                        contentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15.f)];
}

- (void)changeEvent {
    
    // 布局失效
    [self.flowLayout invalidateLayout];
    
    // 初始化新的布局
    CGFloat randomValue = 0;
    while (1) {
        
        randomValue = arc4random() % 4 + 2.f;
        if (itemCount != randomValue) {
            
            itemCount = randomValue;
            break;
        }
    }
    
    self.flowLayout                         = [UICollectionViewFlowLayout new];
    self.flowLayout.minimumLineSpacing      = gap;
    self.flowLayout.minimumInteritemSpacing = gap;
    self.flowLayout.itemSize                = [Math resetFromSize:CGSizeMake(100, 150.f) withFixedWidth:(Width - gap * (itemCount + 1.f)) / itemCount];
    
    // 切换布局的动画
    __weak UIButton *weakButton = _changeButton;
    weakButton.enabled          = NO;
    [self.collectionView setCollectionViewLayout:self.flowLayout animated:YES completion:^(BOOL finished) {
        
        weakButton.enabled = YES;
    }];
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseCustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DynamicSwitchingCell" forIndexPath:indexPath];
    cell.data                      = self.dataSource[indexPath.row];
    cell.indexPath                 = indexPath;
    [cell loadContent];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%@", self.dataSource[indexPath.row]);
}

@end
