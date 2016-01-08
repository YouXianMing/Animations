//
//  AlertViewController.m
//  Animations
//
//  Created by YouXianMing on 16/1/2.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "AlertViewController.h"
#import "UIButton+inits.h"
#import "UIView+SetRect.h"
#import "MessageAlertView.h"
#import "ButtonsAlertView.h"

typedef enum : NSUInteger {
    
    kMessageAlertView = 1000,
    kButtonsAlertView,
    
} EAlertViewControllerValue;

@interface AlertViewController () <AbstractAlertViewDelegate>

@end

@implementation AlertViewController

- (void)setup {
    
    [super setup];
    
    {
        UIButton *messageButton = [UIButton createButtonWithFrame:CGRectMake(0, 0, 180, 30)
                                                       buttonType:kButtonRed
                                                            title:@"MessageAlertView"
                                                              tag:kMessageAlertView
                                                           target:self
                                                           action:@selector(buttonsEvent:)];
        [messageButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        messageButton.center = CGPointMake(self.contentView.centerX, self.contentView.height / 3.f);
        [self.contentView addSubview:messageButton];
    }
    
    {
        UIButton *messageButton = [UIButton createButtonWithFrame:CGRectMake(0, 0, 180, 30)
                                                       buttonType:kButtonRed
                                                            title:@"ButtonsAlertView"
                                                              tag:kButtonsAlertView
                                                           target:self
                                                           action:@selector(buttonsEvent:)];
        [messageButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        messageButton.center = CGPointMake(self.contentView.centerX, self.contentView.height / 3.f * 2);
        [self.contentView addSubview:messageButton];
    }
}

- (void)buttonsEvent:(UIButton *)button {
    
    if (button.tag == kMessageAlertView) {
        
        AbstractAlertView *alertView     = [[MessageAlertView alloc] init];
        alertView.message                = @"惟江上之清风，与山间之明月，耳得之而为声，目遇之而成色，取之无禁，用之不竭。";
        alertView.contentView            = self.contentView;
        alertView.autoHiden              = YES;
        alertView.delayAutoHidenDuration = 2.f;
        [alertView show];
        
    } else if (button.tag == kButtonsAlertView) {
        
        AbstractAlertView *showView = [ButtonsAlertView new];
        showView.delegate         = self;
        showView.contentView      = self.contentView;
        showView.buttonsTitle     = @[@"继续", @"放弃"];
        showView.message          = @"您的可用余额不足";
        UIButton *button          = (UIButton *)[showView viewWithKey:@"secondButton"];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [showView show];
    }
}

- (void)alertView:(AbstractAlertView *)alertView data:(id)data atIndex:(NSInteger)index {
    
    [alertView hide];
}

@end
