//
//  FlowStyleCell.m
//  LayoutViewController
//
//  Created by YouXianMing on 16/5/3.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "FlowStyleCell.h"
#import "UIImageView+WebCache.h"
#import "WaterfallPictureModel.h"
#import "UIView+AnimationProperty.h"
#import "UIView+SetRect.h"
#import "Math.h"

@interface FlowStyleCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation FlowStyleCell

- (void)setupCell {
    
    self.backgroundColor   = [UIColor whiteColor];
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:0.25f].CGColor;
}

- (void)buildSubview {
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.imageView.userInteractionEnabled = NO;
    [self addSubview:self.imageView];
}

- (void)loadContent {
    
    WaterfallPictureModel *model = self.data;
    self.imageView.bounds        = self.frame;
    self.imageView.center        = self.middlePoint;
    self.imageView.alpha         = 0.f;
    __weak FlowStyleCell *wself  = self;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.isrc]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 
                                 wself.imageView.image = image;
                                 wself.scale           = 0.95f;
                                 
                                 [UIView animateWithDuration:0.5f delay:0.f options:UIViewAnimationOptionAllowUserInteraction
                                                  animations:^{
                                                      
                                                      wself.imageView.alpha = 1.f;
                                                      wself.scale           = 1.0f;
                                                      
                                                  } completion:nil];
                             }];
}

@end
