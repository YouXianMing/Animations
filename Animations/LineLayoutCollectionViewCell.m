//
//  LineLayoutCollectionViewCell.m
//  Animations
//
//  Created by YouXianMing on 2017/10/30.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "LineLayoutCollectionViewCell.h"
#import "VideoListModel.h"
#import "AutolayoutPlaceholderImageView.h"
#import "Masonry.h"

@interface LineLayoutCollectionViewCell ()

@property (nonatomic, strong) UIView                         *areaView;
@property (nonatomic, strong) AutolayoutPlaceholderImageView *iconImageView;

@end

@implementation LineLayoutCollectionViewCell

- (void)buildSubview {
    
    self.iconImageView                  = [AutolayoutPlaceholderImageView new];
    self.iconImageView.placeholderImage = [UIImage imageNamed:@"详情默认图"];
    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(3);
        make.right.mas_equalTo(-3);
        make.top.mas_equalTo(3);
        make.bottom.mas_equalTo(-3);
    }];
}

- (void)loadContent {
    
    VideoListModel *model        = self.data;
    self.iconImageView.urlString = model.coverForDetail.length ? model.coverForDetail : @"";
}

@end
