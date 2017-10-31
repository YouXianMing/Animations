//
//  DynamicSwitchingCell.m
//  Animations
//
//  Created by YouXianMing on 2017/10/31.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "DynamicSwitchingCell.h"
#import "DuitangPicModel.h"
#import "AutolayoutPlaceholderImageView.h"
#import "Masonry.h"

@interface DynamicSwitchingCell ()

@property (nonatomic, strong) AutolayoutPlaceholderImageView *iconImageView;

@end

@implementation DynamicSwitchingCell

- (void)buildSubview {
    
    self.iconImageView                  = [AutolayoutPlaceholderImageView new];
    self.iconImageView.placeholderImage = [UIImage imageNamed:@"详情默认图-小"];
    [self.contentView addSubview:self.iconImageView];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.contentView);
    }];
}

- (void)loadContent {
    
    DuitangPicModel *model       = self.data;
    self.iconImageView.urlString = model.img;
}

- (void)willTransitionFromLayout:(UICollectionViewLayout *)oldLayout toLayout:(UICollectionViewLayout *)newLayout {
    
    NSLog(@"willTransitionFromLayout - %ld", self.indexPath.row);
}

- (void)didTransitionFromLayout:(UICollectionViewLayout *)oldLayout toLayout:(UICollectionViewLayout *)newLayout {
    
    NSLog(@"didTransitionFromLayout - %ld", self.indexPath.row);
}

@end
