//
//  LoopViewCell.m
//  InfiniteLoopView
//
//  Created by YouXianMing on 16/5/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "LoopViewCell.h"
#import "UIImageView+WebCache.h"

@interface LoopViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LoopViewCell

- (void)setupCollectionViewCell {
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.85f];
}

- (void)buildSubView {
    
    self.imageView                     = [[UIImageView alloc] init];
    self.imageView.layer.masksToBounds = YES;
    self.imageView.contentMode         = UIViewContentModeScaleAspectFill;
    [self addSubview:self.imageView];
}

- (void)loadContent {
    
    CGFloat width        = self.frame.size.width;
    CGFloat height       = self.frame.size.height;
    self.imageView.frame = CGRectMake(0, 0, width, height);
    self.imageView.alpha = 0.f;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[self.dataModel imageUrlString]]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 
                                 [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:1.f initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                                     
                                     self.imageView.alpha = 1.f;
                                     self.imageView.image = image;
                                     
                                 } completion:nil];
                             }];
}

@end
