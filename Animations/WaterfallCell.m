//
//  WaterfallCell.m
//  Animations
//
//  Created by YouXianMing on 16/1/3.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "WaterfallCell.h"
#import "UIImageView+WebCache.h"
#import "DuitangPicModel.h"
#import "UIView+AnimationProperty.h"
#import "UIView+SetRect.h"

@interface WaterfallCell ()

@property (nonatomic, strong) UIImageView *placeHolderImageView;
@property (nonatomic, strong) UIImageView *showImageView;

@end

@implementation WaterfallCell

- (void)buildSubview {
    
    CGRect imageViewFrame = CGRectMake(0.f, 0.f, self.width, self.height);

    self.placeHolderImageView                  = [UIImageView new];
    self.placeHolderImageView.contentMode      = UIViewContentModeScaleAspectFill;
    self.placeHolderImageView.frame            = imageViewFrame;
    self.placeHolderImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.placeHolderImageView.clipsToBounds    = YES;
    self.placeHolderImageView.image            = [[UIImage imageNamed:@"placeHolder"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
    [self.contentView addSubview:self.placeHolderImageView];
    
    self.showImageView                  = [UIImageView new];
    self.showImageView.contentMode      = UIViewContentModeScaleAspectFill;
    self.showImageView.frame            = imageViewFrame;
    self.showImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.showImageView.clipsToBounds    = YES;

    [self addSubview:self.showImageView];
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f].CGColor;
}

- (void)loadContent {

    DuitangPicModel      *model = self.data;
    __weak WaterfallCell *wself = self;

    [self.showImageView sd_setImageWithURL:[NSURL URLWithString:model.img]
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                     
                                     wself.showImageView.image = image;
                                     wself.showImageView.alpha = 0;
                                     wself.showImageView.scale = 1.1f;
                                     
                                     [UIView animateWithDuration:0.5f animations:^{
                                         
                                         wself.showImageView.alpha = 1.f;
                                         wself.showImageView.scale = 1.f;
                                     }];
                                 }];
}

@end
