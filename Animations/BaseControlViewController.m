//
//  BaseControlViewController.m
//  Animations
//
//  Created by YouXianMing on 16/5/26.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "BaseControlViewController.h"
#import "SelectedIconButton.h"
#import "POPPressButton.h"
#import "UIView+SetRect.h"

@interface BaseControlViewController ()

@end

@implementation BaseControlViewController

- (void)setup {
    
    [super setup];
    
    {
        SelectedIconButton *button = [[SelectedIconButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        button.center              = self.contentView.middlePoint;
        button.selected            = YES;
        button.target              = self;
        button.selector            = @selector(buttonsEvent:);
        [self.contentView addSubview:button];
        
        button.centerY -= 100;
    }
    
    {
        POPPressButton *button = [[POPPressButton alloc] initWithFrame:CGRectMake(0, 0, 180, 40)];
        button.center              = self.contentView.middlePoint;
        button.selected            = YES;
        button.target              = self;
        button.animationDuration   = 0.35f;
        button.title               = @"POPPressButton";
        button.selector            = @selector(buttonsEvent:);
        [self.contentView addSubview:button];
        
        button.centerY += 100;
    }
}

- (void)buttonsEvent:(id)sender {
    
    if ([sender isKindOfClass:[SelectedIconButton class]]) {
        
        SelectedIconButton *button = sender;
        NSLog(@"SelectedIconButton %@", [NSString stringWithFormat:@"%@", button.selected == YES ? @"selected" : @"unSelected"]);
        
    } else if ([sender isKindOfClass:[POPPressButton class]]) {
    
        NSLog(@"%@ Event", sender);
    }
}

@end
