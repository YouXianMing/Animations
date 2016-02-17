//
//  CAGradientMaskView.m
//  Animations
//
//  Created by YouXianMing on 16/2/16.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CAGradientMaskView.h"
#import "CAGradientView.h"

@interface CAGradientMaskView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic)         UIView      *theMaskView;

@property (nonatomic)         CGFloat      width;
@property (nonatomic)         CGFloat      height;
@property (nonatomic)         CGRect       theOldFrame;
@property (nonatomic)         CGRect       theNewFrame;

@end

@implementation CAGradientMaskView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
     
        self.layer.masksToBounds = YES;
        
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.imageView];
        
        self.width       = self.frame.size.width;
        self.height      = self.frame.size.height;
        self.theOldFrame = CGRectMake(-self.width / 2.f, 0, self.width + self.width / 2.f, self.height);
        self.theNewFrame = CGRectMake(self.width, 0, self.width + self.width / 2.f, self.height);
        
        self.theMaskView          = [[UIView alloc] initWithFrame:self.theOldFrame];
        UIView *blackView         = [[UIView alloc] initWithFrame:CGRectMake(self.width / 2.f, 0, self.width, self.height)];
        blackView.backgroundColor = [UIColor blackColor];
        [self.theMaskView addSubview:blackView];
        
        CAGradientView *gradientView = [[CAGradientView alloc] initWithFrame:CGRectMake(0, 0, self.width / 2.f, self.height)];
        gradientView.colors          = @[[UIColor clearColor], [UIColor blackColor]];
        gradientView.locations       = @[@(0.5f), @(1.f)];
        gradientView.startPoint      = CGPointMake(0, 0);
        gradientView.endPoint        = CGPointMake(1, 0);
        [self.theMaskView addSubview:gradientView];
        self.imageView.layer.mask = self.theMaskView.layer;
    }
    
    return self;
}

- (void)fadeAnimated:(BOOL)animated {

    if (animated) {
        
        [UIView animateWithDuration:(self.fadeDuradtion <= 0 ? 1 : self.fadeDuradtion) animations:^{
            
            self.theMaskView.frame = self.theNewFrame;
        }];
        
    } else {
    
        self.theMaskView.frame = self.theNewFrame;
    }
}

- (void)showAnimated:(BOOL)animated {

    if (animated) {
        
        [UIView animateWithDuration:(self.fadeDuradtion <= 0 ? 1 : self.fadeDuradtion) animations:^{
            
            self.theMaskView.frame = self.theOldFrame;
        }];
        
    } else {
    
        self.theMaskView.frame = self.theOldFrame;
    }
}

#pragma mark - overwrite setter & getter method.

@synthesize contentMode = _contentMode;

- (UIViewContentMode)contentMode {

    return _imageView.contentMode;
}

- (void)setContentMode:(UIViewContentMode)contentMode {

    _imageView.contentMode = contentMode;
}

@synthesize image = _image;

- (UIImage *)image {
    
    return _imageView.image;
}

- (void)setImage:(UIImage *)image {

    _imageView.image = image;
}

@end
