//
//  SubmitItemStyle.m
//  Animations
//
//  Created by YouXianMing on 2017/11/28.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "SubmitItemStyle.h"
#import "UIButton+Inits.h"
#import "HexColors.h"
#import "UIImage+SolidColor.h"
#import "UIFont+Fonts.h"

@implementation SubmitItemStyle

- (void)makeStyleEffective {
    
    UIButton *button = self.source;
    
    button.layer.cornerRadius         = 3.f;
    button.layer.borderColor          = [UIColor colorWithHexString:@"#009BD8"].CGColor;
    button.layer.borderWidth          = 0.5f;
    button.layer.masksToBounds        = YES;
    button.backgroundNormalImage      = [UIImage imageWithSize:CGSizeMake(10, 10) color:[UIColor colorWithHexString:@"#009BD8"]];
    button.backgroundHighlightedImage = [UIImage imageWithSize:CGSizeMake(10, 10) color:[[UIColor colorWithHexString:@"#009BD8"] colorWithAlphaComponent:0.5]];
    button.titleLabel.font            = [UIFont HeitiSCWithFontSize:16.f];
}

@end
