//
//  MoreInfoView.m
//  Animations
//
//  Created by YouXianMing on 15/11/24.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "MoreInfoView.h"

@implementation MoreInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        CGRect rect = frame;
        self.layer.borderWidth   = 0.5f;
        self.layer.borderColor   = [UIColor blackColor].CGColor;
        self.layer.masksToBounds = YES;
        
        /*
         *     --------------     *
         *-50->|-view-width-|<-50-*
         *     --------------     *
         */
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-50, 0, rect.size.width + 50 * 2, rect.size.height)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
    }
    
    return self;
}

@end
