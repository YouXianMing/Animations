//
//  WaterfallCell.m
//  Animations
//
//  Created by YouXianMing on 16/1/3.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "WaterfallCell.h"
#import "UIImageView+WebCache.h"
#import "WaterfallPictureModel.h"
#import "UIView+AnimationProperty.h"
#import "UIView+SetRect.h"

@interface WaterfallCell ()

@property (nonatomic, strong) UIImageView *showImageView;

@end

@implementation WaterfallCell

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        CGRect imageViewFrame = CGRectMake(0.f, 0.f,
                                           CGRectGetMaxX(self.contentView.bounds),
                                           CGRectGetMaxY(self.contentView.bounds));
        
        _showImageView                  = [UIImageView new];
        _showImageView.contentMode      = UIViewContentModeScaleAspectFill;
        _showImageView.frame            = imageViewFrame;
        _showImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _showImageView.clipsToBounds    = YES;
        
        [self addSubview:_showImageView];
        self.layer.borderWidth = 2.f;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    
    return self;
}

- (void)loadContent {

    WaterfallPictureModel *model = self.data;
    __weak WaterfallCell  *wself = self;
    [self.showImageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:model.isrc]
                                                 placeholderImage:nil
                                                          options:0
                                                         progress:nil
                                                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                            
                                                            if (cacheType == SDImageCacheTypeNone) {
                                                                
                                                                wself.showImageView.image = image;
                                                                wself.showImageView.alpha = 0;
                                                                wself.showImageView.scale = 1.1f;
                                                                
                                                                [UIView animateWithDuration:0.5f animations:^{
                                                                    
                                                                    wself.showImageView.alpha = 1.f;
                                                                    wself.showImageView.scale = 1.f;
                                                                }];
                                                                
                                                            } else if (cacheType == SDImageCacheTypeMemory) {
                                                                
                                                                wself.showImageView.image = image;
                                                                wself.showImageView.alpha = 0;
                                                                wself.showImageView.scale = 1.1f;
                                                                
                                                                [UIView animateWithDuration:0.5f animations:^{
                                                                    
                                                                    wself.showImageView.alpha = 1.f;
                                                                    wself.showImageView.scale = 1.f;
                                                                }];
                                                            }
                                                        }];
}

@end
