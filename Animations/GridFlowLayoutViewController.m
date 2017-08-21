//
//  GridFlowLayoutViewController.m
//  Animations
//
//  Created by YouXianMing on 16/5/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "GridFlowLayoutViewController.h"
#import "UIView+SetRect.h"
#import "GridLayout.h"
#import "FlowStyleCell.h"
#import "FileManager.h"
#import "NSString+MD5.h"
#import "NSData+JSONData.h"
#import "DuitangPicModel.h"
#import "Math.h"
#import "GCD.h"

@interface GridFlowLayoutViewController () <UICollectionViewDataSource, UICollectionViewDelegate, GridLayoutDelegate>

@property (nonatomic, strong) UICollectionView  *collectionView;
@property (nonatomic)         CGFloat            rowHeight;
@property (nonatomic, strong) NSMutableArray    *datas;
@property (nonatomic, strong) NSMutableArray    <DuitangPicModel *> *dataSource;

@end

@implementation GridFlowLayoutViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _dataSource = [NSMutableArray new];
    
    // 初始化布局文件
    CGFloat gap               = 1;
    NSInteger rowCount        = arc4random() % 3 + 2;
    _rowHeight                = (self.contentView.height - (rowCount + 1) * gap) / (CGFloat)rowCount;
    GridLayout *layout        = [GridLayout new];
    layout.manager.edgeInsets = UIEdgeInsetsMake(gap, gap, gap, gap);
    layout.manager.gap        = gap;
    layout.delegate           = self;
    
    NSMutableArray *rowHeights = [NSMutableArray array];
    for (int i = 0; i < rowCount; i++) {
        
        [rowHeights addObject:@(_rowHeight)];
    }
    layout.manager.rowHeights = rowHeights;
    
    self.collectionView                                = [[UICollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:layout];
    self.collectionView.delegate                       = self;
    self.collectionView.dataSource                     = self;
    self.collectionView.backgroundColor                = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[FlowStyleCell class] forCellWithReuseIdentifier:@"FlowStyleCell"];
    [self.contentView addSubview:self.collectionView];
    
    // 数据源
    self.dataSource = [NSMutableArray array];
    NSArray *duitangPics = [[NSData dataWithContentsOfFile:[FileManager bundleFileWithName:@"duitang.json"]] toListProperty];
    [duitangPics enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.dataSource addObject:[[DuitangPicModel alloc] initWithDictionary:obj]];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DuitangPicModel *pictureModel = _dataSource[indexPath.row];
    
    FlowStyleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlowStyleCell" forIndexPath:indexPath];
    cell.indexPath      = indexPath;
    cell.data           = pictureModel;
    cell.rowHeight      = _rowHeight;
    [cell loadContent];
    
    return cell;
}

- (CGFloat)itemWidthWithIndexPath:(NSIndexPath *)indexPath {
    
    DuitangPicModel *pictureModel = _dataSource[indexPath.row];
    return  [Math resetFromSize:CGSizeMake(pictureModel.width.floatValue, pictureModel.height.floatValue) withFixedHeight:_rowHeight].width;
}

@end
