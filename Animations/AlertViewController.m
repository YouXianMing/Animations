//
//  AlertViewController.m
//  Animations
//
//  Created by YouXianMing on 16/1/2.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "AlertViewController.h"
#import "UIButton+inits.h"
#import "UIButton+ItemStyle.h"
#import "RedStyle.h"
#import "UIView+SetRect.h"
#import "MessageView.h"
#import "AlertView.h"
#import "LoadingView.h"
#import "CircleLoadingView.h"

typedef enum : NSUInteger {
    
    kMessageAlertView = 1000,
    kButtonsAlertView,
    kLoadingAlertView,
    kCircleLoadingAlertView,
    
} EAlertViewControllerValue;

@interface AlertViewController () <BaseMessageViewDelegate>

@end

@implementation AlertViewController

- (void)setup {
    
    [super setup];
    
    {
        UIButton *messageButton      = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 180.f, 30.f)];
        messageButton.style          = [RedStyle new];
        messageButton.exclusiveTouch = YES;
        messageButton.center         = CGPointMake(self.contentView.centerX, self.contentView.height / 5.f * 1);
        messageButton.normalTitle    = NSStringFromClass([MessageView class]);
        messageButton.tag            = kMessageAlertView;
        [messageButton addTarget:self touchUpInsideAction:@selector(buttonsEvent:)];
        [self.contentView addSubview:messageButton];
    }
    
    {
        UIButton *messageButton      = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 180.f, 30.f)];
        messageButton.style          = [RedStyle new];
        messageButton.exclusiveTouch = YES;
        messageButton.center         = CGPointMake(self.contentView.centerX, self.contentView.height / 5.f * 2);
        messageButton.normalTitle    = NSStringFromClass([AlertView class]);
        messageButton.tag            = kButtonsAlertView;
        [messageButton addTarget:self touchUpInsideAction:@selector(buttonsEvent:)];
        [self.contentView addSubview:messageButton];
    }
    
    {
        UIButton *messageButton      = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 180.f, 30.f)];
        messageButton.style          = [RedStyle new];
        messageButton.exclusiveTouch = YES;
        messageButton.center         = CGPointMake(self.contentView.centerX, self.contentView.height / 5.f * 3);
        messageButton.normalTitle    = NSStringFromClass([LoadingView class]);
        messageButton.tag            = kLoadingAlertView;
        [messageButton addTarget:self touchUpInsideAction:@selector(buttonsEvent:)];
        [self.contentView addSubview:messageButton];
    }
    
    {
        UIButton *messageButton      = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 180.f, 30.f)];
        messageButton.style          = [RedStyle new];
        messageButton.exclusiveTouch = YES;
        messageButton.center         = CGPointMake(self.contentView.centerX, self.contentView.height / 5.f * 4);
        messageButton.normalTitle    = NSStringFromClass([CircleLoadingView class]);
        messageButton.tag            = kCircleLoadingAlertView;
        [messageButton addTarget:self touchUpInsideAction:@selector(buttonsEvent:)];
        [self.contentView addSubview:messageButton];
    }
}

- (void)buttonsEvent:(UIButton *)button {
    
    if (button.tag == kMessageAlertView) {
        
        NSString *title                  = arc4random() % 2 ? @"" : @"赤壁赋";
        NSString *content                = @"惟江上之清风，与山间之明月，\n耳得之而为声，目遇之而成色，\n取之无禁，用之不竭。";
        MessageViewObject *messageObject = MakeMessageViewObject(title, content);
        
        if (arc4random() % 2) {
            
            [MessageView showAutoHiddenMessageViewWithMessageObject:messageObject delegate:self contentView:self.windowView viewTag:arc4random() % 100];
            
        } else {
            
            [MessageView showAutoHiddenMessageViewInKeyWindowWithMessageObject:messageObject delegate:self viewTag:arc4random() % 100];
        }
        
    } else if (button.tag == kButtonsAlertView) {
        
        NSString *content                     = arc4random() % 2 ? @"Network error, please try later." : @"Drinking hot water is an excellent natural remedy for colds.";
        NSArray  *buttonTitles                = arc4random() % 2 ? @[AlertViewNormalStyle(@"Cancel"), AlertViewRedStyle(@"Confirm")] : @[AlertViewRedStyle(@"Confirm")];
        AlertViewMessageObject *messageObject = MakeAlertViewMessageObject(content, buttonTitles);
        
        if (arc4random() % 2) {
            
            [AlertView showManualHiddenMessageViewWithMessageObject:messageObject delegate:self contentView:self.windowView viewTag:arc4random() % 100];
            
        } else {
            
            [AlertView showManualHiddenMessageViewInKeyWindowWithMessageObject:messageObject delegate:self viewTag:arc4random() % 100];
        }
        
    } else if (button.tag == kLoadingAlertView) {
        
        if (arc4random() % 2) {
            
            [LoadingView showAutoHiddenMessageViewWithMessageObject:nil delegate:self contentView:self.windowView viewTag:arc4random() % 100 delayAutoHidenDuration:8.f];
            
        } else {
            
            [LoadingView showAutoHiddenMessageViewInKeyWindowWithMessageObject:nil delegate:self viewTag:arc4random() % 100 delayAutoHidenDuration:8.f];
        }
        
    } else if (button.tag == kCircleLoadingAlertView) {
        
        if (arc4random() % 2) {
            
            [CircleLoadingView showAutoHiddenMessageViewWithMessageObject:nil delegate:self contentView:self.windowView viewTag:arc4random() % 100
                                                   delayAutoHidenDuration:8.f];
            
        } else {
            
            [CircleLoadingView showAutoHiddenMessageViewInKeyWindowWithMessageObject:nil delegate:self viewTag:arc4random() % 100 delayAutoHidenDuration:8.f];
        }
    }
}

#pragma mark - BaseMessageViewDelegate

- (void)baseMessageView:(__kindof BaseMessageView *)messageView event:(id)event {
    
    NSLog(@"%@, tag:%ld event:%@", NSStringFromClass([messageView class]), (long)messageView.tag, event);
    [messageView hide];
}

- (void)baseMessageViewWillAppear:(__kindof BaseMessageView *)messageView {
    
    NSLog(@"%@, tag:%ld WillAppear", NSStringFromClass([messageView class]), (long)messageView.tag);
}

- (void)baseMessageViewDidAppear:(__kindof BaseMessageView *)messageView {
    
    NSLog(@"%@, tag:%ld DidAppear, contentView is %@", NSStringFromClass([messageView class]), (long)messageView.tag, NSStringFromClass([messageView.contentView class]));
}

- (void)baseMessageViewWillDisappear:(__kindof BaseMessageView *)messageView {
    
    NSLog(@"%@, tag:%ld WillDisappear", NSStringFromClass([messageView class]), (long)messageView.tag);
}

- (void)baseMessageViewDidDisappear:(__kindof BaseMessageView *)messageView {
    
    NSLog(@"%@, tag:%ld DidDisappear", NSStringFromClass([messageView class]), (long)messageView.tag);
}

@end
