//
//  UIView+ShimmeringViewCategory.m
//  AjMall
//
//  Created by YouXianMing on 2020/6/16.
//  Copyright © 2020 YouXianMing. All rights reserved.
//

#import "UIView+ShimmeringViewCategory.h"

@implementation UIView (ShimmeringViewCategory)

- (FBShimmeringView *)addToFBShimmeringView {
    
    CGRect frame = self.frame;
    self.frame   = self.bounds;
    
    FBShimmeringView *view = [[FBShimmeringView alloc] initWithFrame:frame];
    view.contentView       = self;
    
    return view;
}

@end
