//
//  UIView+CustomViewController.m
//  Animations
//
//  Created by YouXianMing on 16/6/16.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "UIView+CustomViewController.h"
#import "CustomViewController.h"

@implementation UIView (CustomViewController)

+ (instancetype)viewWithTag:(NSInteger)tag fromController:(CustomViewController *)controller {
    
    return [controller viewWithTag:tag];
}

- (void)setTag:(NSInteger)tag toController:(CustomViewController *)controller {

    self.tag = tag;
    [controller setView:self withTag:tag];
}

@end
