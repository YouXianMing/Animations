//
//  ScrollCarouselItemView.m
//  iCarouselExample
//
//  Created by YouXianMing on 2016/12/28.
//  Copyright © 2016年 TechCode. All rights reserved.
//

#import "ScrollCarouselItemView.h"
#import "UIView+SetRect.h"

static CGFloat gap = 0.f;

@interface ScrollCarouselItemView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ScrollCarouselItemView

- (void)setup {
    
    self.layer.masksToBounds = YES;
}

- (void)buildSubViews {
    
    self.imageView             = [[UIImageView alloc] initWithFrame:CGRectMake(-gap, 0, Width, self.height)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.imageView];
}

- (void)loadContent {
    
    self.imageView.image = [UIImage imageNamed:self.adpter.data];
}

- (void)offsetX:(CGFloat)x {
    
    self.imageView.x = 0.95f * x;
}

+ (CGFloat)itemWidth {
    
    return Width - gap * 2.f;
}

@end
