//
//  LiveImageView.m
//  Animations
//
//  Created by YouXianMing on 15/12/27.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "LiveImageView.h"

@interface LiveImageView ()

@property (nonatomic, weak) CALayer *viewLayer;

@end

@implementation LiveImageView

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.duration  = 0.3f;
        self.viewLayer = self.layer;
    }
    
    return self;
}

@synthesize image = _image;

- (void)setImage:(UIImage *)image {
    
    if (_image != image) {
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"contents"];
        animation.fromValue         = (__bridge id)(_image.CGImage);
        animation.toValue           =  (__bridge id)(image.CGImage);
        animation.duration          = self.duration;
        self.viewLayer.contents     = (__bridge id)(image.CGImage);
        [self.viewLayer addAnimation:animation forKey:nil];
        
        _image = image;
    }
}

- (UIImage *)image {
    
    return _image;
}

@end
