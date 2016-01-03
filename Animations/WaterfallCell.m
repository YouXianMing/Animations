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

@interface WaterfallCell ()

@property (nonatomic, strong) UIImageView *showImageView;

@end

@implementation WaterfallCell

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        // Scale the imageview to fit inside the contentView with the image centered:
        CGRect imageViewFrame = CGRectMake(0.f, 0.f,
                                           CGRectGetMaxX(self.contentView.bounds),
                                           CGRectGetMaxY(self.contentView.bounds));
        
        _showImageView                  = [UIImageView new];
        _showImageView.contentMode      = UIViewContentModeScaleAspectFill;
        _showImageView.frame            = imageViewFrame;
        _showImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _showImageView.clipsToBounds    = YES;
        
        [self addSubview:_showImageView];
//        self.layer.borderWidth = 3.f;
//        self.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    
    return self;
}

- (void)loadContent {

    WaterfallPictureModel *model = self.data;    
    
    // 进行图片下载
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    // 加载图片(动画逻辑)
    [manager downloadImageWithURL:[NSURL URLWithString:model.isrc] options:0 progress:nil
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            
                            if (image) {
                                                                
                                self.showImageView.alpha = 0.f;
                                self.showImageView.image = image;
                                self.showImageView.scale = 1.1f;
                                
                                // 执行动画
                                [UIView animateWithDuration:0.5f animations:^{
                                    
                                    self.showImageView.alpha = 1.f;
                                    self.showImageView.scale = 1.f;
                                }];
                            }
                        }];
}

@end
