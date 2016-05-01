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

    [self.iconImageView sd_setImageWithURL:model.pictureUrl
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                     
                                     if (cacheType == SDImageCacheTypeNone) {
                                         
                                         NSLog(@"[%ld][%ld] SDImageCacheTypeNone", (long)wself.indexPath.section, (long)wself.indexPath.row);
                                         
                                     } else if (cacheType == SDImageCacheTypeDisk) {
                                         
                                         NSLog(@"[%ld][%ld] SDImageCacheTypeDisk", (long)wself.indexPath.section, (long)wself.indexPath.row);
                                         
                                     } else if (cacheType == SDImageCacheTypeMemory) {
                                         
                                         NSLog(@"[%ld][%ld] SDImageCacheTypeMemory", (long)wself.indexPath.section, (long)wself.indexPath.row);
                                         
                                     } else {
                                         
                                         NSLog(@"[%ld][%ld] Unknow", (long)wself.indexPath.section, (long)wself.indexPath.row);
                                     }
                                     
                                     if (cacheType == SDImageCacheTypeNone || cacheType == SDImageCacheTypeDisk) {
                                         
                                         wself.iconImageView.image = image;
                                         wself.iconImageView.alpha = 0;
                                         wself.iconImageView.scale = 1.25f;
                                         
                                         [UIView animateWithDuration:0.35 animations:^{
                                             
                                             wself.iconImageView.alpha = 1.f;
                                             wself.iconImageView.scale = 1.f;
                                         }];
                                         
                                     } else {
                                         
                                         wself.iconImageView.image = image;
                                         wself.iconImageView.alpha = 1.f;
                                         wself.iconImageView.scale = 1.f;
                                     }
                                 }];
}

@end
