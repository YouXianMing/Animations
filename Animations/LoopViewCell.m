//
//  LoopViewCell.m
//  InfiniteLoopView
//
//  Created by YouXianMing on 16/5/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "LoopViewCell.h"
#import "InfiniteLoopView.h"
#import "UIView+SetRect.h"
#import "PlaceholderImageView.h"
#import "UIImageView+WebCache.h"
#import "UIView+ConvertRect.h"
#import "Math.h"

@interface LoopViewCell () {
    
    Math *_math;
}

@property (nonatomic, strong) PlaceholderImageView *imageView;

@end

@implementation LoopViewCell

- (void)setupCollectionViewCell {
    
    self.layer.masksToBounds = YES;
    
    _math = [Math mathOnceLinearEquationWithPointA:MATHPointMake(0, Width / 2.f) PointB:MATHPointMake(-Width, Width / 2.f + Width * 0.9)];
}

- (void)buildSubView {
    
    self.imageView                     = [[PlaceholderImageView alloc] initWithFrame:self.bounds];
    self.imageView.placeholderImage    = [UIImage imageNamed:@"详情默认图"];
    [self addSubview:self.imageView];
}

- (void)loadContent {
        
    self.imageView.urlString = [self.dataModel imageUrlString];
}

- (void)contentOffset:(CGPoint)offset {
    
    [self resetImageViewCenterPoint];
}

- (void)resetImageViewCenterPoint {
    
    CGPoint point = [self frameOriginFromView:self.window];
    self.imageView.centerX = _math.k * point.x + _math.b;
}

@end
