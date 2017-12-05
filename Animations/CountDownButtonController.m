//
//  CountDownButtonController.m
//  Animations
//
//  Created by YouXianMing on 2017/7/5.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "CountDownButtonController.h"
#import "RedCountDownButton.h"
#import "UIView+SetRect.h"
#import "LoadingView.h"
#import "MessageView.h"
#import "GCD.h"

@interface CountDownButtonController () <CountDownButtonDelegate>

@property (nonatomic, strong) LoadingView        *loadingView;
@property (nonatomic, strong) RedCountDownButton *countDownButton;

@end

@implementation CountDownButtonController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.countDownButton = [RedCountDownButton countDownButtonWithFrame:CGRectMake(0, 0, 230, 45.f)
                                                               delegate:self
                                                       countDownStrings:@[@"Remain 0s to restart",
                                                                          @"Remain 1s to restart .",
                                                                          @"Remain 2s to restart ..",
                                                                          @"Remain 3s to restart ...",
                                                                          @"Remain 4s to restart ..",
                                                                          @"Remain 5s to restart .",
                                                                          @"Remain 6s to restart ..",
                                                                          @"Remain 7s to restart ...",
                                                                          @"Remain 8s to restart ..",
                                                                          @"Remain 9s to restart ."]
                                                           normalString:@"Tap This to send SMS code"];
    self.countDownButton.layer.borderWidth = 0.5f;
    self.countDownButton.layer.borderColor = [UIColor redColor].CGColor;
    self.countDownButton.center            = self.contentView.middlePoint;
    [self.contentView addSubview:self.countDownButton];
}

- (void)countDownButtonDidTaped:(CountDownButton *)button {
    
    self.loadingView = LoadingView.build.disableContentViewInteraction;
    self.loadingView.showIn(self.loadingAreaView);
    
    [GCDQueue executeInMainQueue:^{
        
        [self.loadingView hide];
        if (arc4random() % 5 == 0) {
                        
            MessageView.build.autoHidden.disableContentViewInteraction.withMessage(MakeMessageViewObject(@"Error", @"Network error !")).showIn(self.windowAreaView);
            
        } else {
            
            [button start];
        }
        
    } afterDelaySecs:1.f];
}

@end
