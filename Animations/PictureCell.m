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

    PictureModel       *model = self.dataAdapter.data;
    __weak PictureCell *wself = self;
    [self.iconImageView sd_setImageWithPreviousCachedImageWithURL:model.pictureUrl
                                                 placeholderImage:nil
                                                          options:0
                                                         progress:nil
                                                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                            
                                                            if (cacheType == SDImageCacheTypeNone) {
                                                                
                                                                wself.iconImageView.image = image;
                                                                wself.iconImageView.alpha = 0;
                                                                wself.iconImageView.scale = 1.25f;
                                                                
                                                                [UIView animateWithDuration:0.35 animations:^{
                                                                    
                                                                    wself.iconImageView.alpha = 1.f;
                                                                    wself.iconImageView.scale = 1.f;
                                                                }];
                                                            }
                                                        }];
}

@end
