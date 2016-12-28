//
//  PlaceholderImageView.m
//  SDWebImageViewPlaceHorder
//
//  Created by YouXianMing on 16/8/19.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "PlaceholderImageView.h"
#import "UIImageView+WebCache.h"

@interface PlaceholderImageView ()

@property (nonatomic, strong) UIImageView *placeHoderImageView;
@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, strong) UIImageView *normalImageView;
@property (nonatomic, strong) NSString    *pUrlString;

@end

@implementation PlaceholderImageView

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.placeHoderImageView.frame = self.bounds;
    self.contentImageView.frame    = self.bounds;
    self.normalImageView.frame     = self.bounds;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.layer.masksToBounds = YES;
        
        self.placeHoderImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.contentImageView    = [[UIImageView alloc] initWithFrame:self.bounds];
        self.normalImageView     = [[UIImageView alloc] initWithFrame:self.bounds];
        
        [self addSubview:self.placeHoderImageView];
        [self addSubview:self.contentImageView];
        [self addSubview:self.normalImageView];
        
        self.contentImageContentMode     = UIViewContentModeScaleAspectFill;
        self.placeholderImageContentMode = UIViewContentModeScaleAspectFill;
    }
    
    return self;
}

#pragma mark - Setter & Getter.

- (void)setPlaceholderImage:(UIImage *)placeholderImage {
    
    _placeHoderImageView.image = placeholderImage;
}

- (UIImage *)placeholderImage {
    
    return _placeHoderImageView.image;
}

- (void)setUrlString:(NSString *)urlString {
    
    _pUrlString             = urlString;
    _contentImageView.alpha = 0.f;
    
    NSURL *url = [NSURL URLWithString:urlString];
    [_contentImageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       
        if (image) {
            
            if (cacheType == SDImageCacheTypeNone || cacheType == SDImageCacheTypeDisk) {
                
                [UIView animateWithDuration:0.5f animations:^{
                    
                    _contentImageView.alpha = 1.f;
                }];
                
            } else {
            
                _contentImageView.alpha = 1.f;
            }
        }
    }];
}

- (NSString *)urlString {

    return _pUrlString;
}

- (void)setPlaceholderImageContentMode:(UIViewContentMode)placeholderImageContentMode {

    _placeHoderImageView.contentMode = placeholderImageContentMode;
}

- (UIViewContentMode)placeholderImageContentMode {

    return _placeHoderImageView.contentMode;
}

- (void)setContentImageContentMode:(UIViewContentMode)contentImageContentMode {

    _contentImageView.contentMode = contentImageContentMode;
    _normalImageView.contentMode  = contentImageContentMode;
    
}

- (UIViewContentMode)contentImageContentMode {

    return _contentImageView.contentMode;
}

@end
