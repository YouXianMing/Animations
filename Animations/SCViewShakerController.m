//
//  SCViewShakerController.m
//  Animations
//
//  Created by YouXianMing on 16/2/25.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "SCViewShakerController.h"
#import "UIView+SetRect.h"
#import "UIView+Shake.h"

@interface SCViewShakerController ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation SCViewShakerController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // https://github.com/rFlex/SCViewShaker
    
    self.label               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.center        = self.contentView.middlePoint;
    self.label.text          = @"😂";
    self.label.font          = [UIFont systemFontOfSize:100.f];
    [self.contentView addSubview:self.label];
    
    static int i = 0;
    switch (i++ % 4) {
            
        case 0:
            [self.label shakeWithOptions:SCShakeOptionsDirectionRotate | SCShakeOptionsForceInterpolationExpDown | SCShakeOptionsAtEndRestart | SCShakeOptionsAutoreverse force:0.15 duration:1 iterationDuration:0.03 completionHandler:nil];
            break;
            
        case 1:
            [self.label shakeWithOptions:SCShakeOptionsDirectionHorizontal | SCShakeOptionsForceInterpolationNone | SCShakeOptionsAtEndContinue force:0.05 duration:1 iterationDuration:0.03 completionHandler:nil];
            break;
            
        case 2:
            [self.label shakeWithOptions:SCShakeOptionsDirectionHorizontalAndVertical | SCShakeOptionsForceInterpolationRandom | SCShakeOptionsAtEndContinue force:0.3 duration:1 iterationDuration:0.02 completionHandler:nil];
            break;
            
        case 3:
            [self.label shakeWithOptions:SCShakeOptionsDirectionRotate | SCShakeOptionsForceInterpolationExpDown | SCShakeOptionsAtEndRestart force:0.15 duration:0.75 iterationDuration:0.03 completionHandler:nil];
            break;
            
        default:
            break;
    }
}

- (void)dealloc {

    [self.label endShake];
}

@end
