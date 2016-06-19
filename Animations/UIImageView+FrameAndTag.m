//
//  UIImageView+FrameAndTag.m
//  SetRect
//
//  Created by YouXianMing on 16/6/19.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "UIImageView+FrameAndTag.h"

@implementation UIImageView (FrameAndTag)

+ (instancetype)insertIntoView:(UIView *)view
                           tag:(NSInteger)tag
                    attachedTo:(id <AccessViewTagProtocol>)object
                    imageNamed:(NSString *)imageName
                    setupBlock:(ViewSetupBlock)block {
    
    UIImageView *imageView = [[[self class] alloc] initWithImage:[UIImage imageNamed:imageName]];
    [object setView:imageView withTag:tag];
    [view addSubview:imageView];
    
    if (block) {
        
        block(imageView);
    }
    
    return imageView;
}

+ (instancetype)insertIntoView:(UIView *)view imageNamed:(NSString *)imageName setupBlock:(ViewSetupBlock)block {
    
    UIImageView *imageView = [[[self class] alloc] initWithImage:[UIImage imageNamed:imageName]];
    [view addSubview:imageView];
    
    if (block) {
        
        block(imageView);
    }
    
    return imageView;
}

@end
