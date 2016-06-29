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

@implementation SCViewShakerController

- (void)setup {
    
    [super setup];
    
    // https://github.com/rFlex/SCViewShaker
    
    UILabel *label      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    label.textAlignment = NSTextAlignmentCenter;
    label.center        = self.contentView.middlePoint;
    label.text          = @"😂";
    label.font          = [UIFont systemFontOfSize:100.f];
    [self.contentView addSubview:label];
    
    static int i = 0;
    switch (i++ % 4) {
            
        case 0:
            [label shakeWithOptions:SCShakeOptionsDirectionRotate | SCShakeOptionsForceInterpolationExpDown | SCShakeOptionsAtEndRestart | SCShakeOptionsAutoreverse force:0.15 duration:1 iterationDuration:0.03 completionHandler:nil];
            break;
            
        case 1:
            [label shakeWithOptions:SCShakeOptionsDirectionHorizontal | SCShakeOptionsForceInterpolationNone | SCShakeOptionsAtEndContinue force:0.05 duration:1 iterationDuration:0.03 completionHandler:nil];
            break;
            
        case 2:
            [label shakeWithOptions:SCShakeOptionsDirectionHorizontalAndVertical | SCShakeOptionsForceInterpolationRandom | SCShakeOptionsAtEndContinue force:0.3 duration:1 iterationDuration:0.02 completionHandler:nil];
            break;
            
        case 3:
            [label shakeWithOptions:SCShakeOptionsDirectionRotate | SCShakeOptionsForceInterpolationExpDown | SCShakeOptionsAtEndRestart force:0.15 duration:0.75 iterationDuration:0.03 completionHandler:nil];
            break;
            
        default:
            break;
    }
}

@end
