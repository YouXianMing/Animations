//
//  PictureCell.m
//  SDWebImageLoadImageAnimation
//
//  Created by YouXianMing on 15/4/30.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "PictureCell.h"
#import "UIImageView+WebCache.h"
#import "PictureModel.h"
#import "UIView+AnimationProperty.h"
#import "UIImageView+SDWebImageAnimation.h"

@interface PictureCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation PictureCell

- (void)setupCell {

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {

    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self addSubview:self.iconImageView];
}

- (void)loadContent {

    PictureModel *model = self.dataAdapter.data;
    [self.iconImageView sd_setImageWithURL:model.pictureUrl
                          placeholderImage:[UIImage imageNamed:@"plane"]
                                   options:0
                                  progress:nil
                                 completed:nil
                             fadeAnimation:YES];
}

@end
