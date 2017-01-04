//
//  RedStyle.m
//  Animations
//
//  Created by YouXianMing on 2016/12/25.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "RedStyle.h"

@implementation RedStyle

- (void)makeEffect {

    UIButton *button = self.item;
    
    button.layer.borderWidth   = 0.5f;
    button.layer.borderColor   = [UIColor redColor].CGColor;
    button.layer.masksToBounds = YES;
    
    button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:14.f];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
}

@end
