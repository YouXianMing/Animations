//
//  PressAnimationButtonController.m
//  Animations
//
//  Created by YouXianMing on 16/1/9.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "PressAnimationButtonController.h"
#import "PressAnimationButton.h"
#import "UIFont+Fonts.h"
#import "UIView+SetRect.h"

@interface PressAnimationButtonController () <PressAnimationButtonDelegate>

@property (nonatomic, strong) PressAnimationButton *button;

@end

@implementation PressAnimationButtonController

- (void)setup {

    [super setup];
    
    self.button          = [[PressAnimationButton alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
    self.button.font     = [UIFont HeitiSCWithFontSize:14.f];
    self.button.delegate = self;
    
    self.button.normalTextColor    = [UIColor blackColor];
    self.button.highlightTextColor = [UIColor whiteColor];
    self.button.animationColor     = [UIColor blackColor];
    
    self.button.layer.borderWidth  = 0.5f;
    self.button.animationWidth     = 200;
    self.button.text               = @"YouXianMing";
    
    self.button.center = self.contentView.middlePoint;
    [self.contentView addSubview:self.button];
}

- (void)finishedEventByPressAnimationButton:(PressAnimationButton *)button {

    NSLog(@"%@", button);
}

@end
