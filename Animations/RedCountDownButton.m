//
//  RedCountDownButton.m
//  Animations
//
//  Created by YouXianMing on 2017/7/5.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "RedCountDownButton.h"
#import "UIView+SetRect.h"
#import "AttributedStringConfigHelper.h"
#import "RegexManager.h"

@interface RedCountDownButton ()

@property (nonatomic, strong) UILabel *normalLabel;
@property (nonatomic, strong) UILabel *countDownLabel;

@end

@implementation RedCountDownButton

- (void)countDownEventWithString:(id)string {
    
    NSString                  *totalString = string;
    NSMutableAttributedString *atbString   = nil;
    atbString = [NSMutableAttributedString mutableAttributedStringWithString:totalString config:^(NSString *source, NSMutableArray<AttributedStringConfig *> *configs) {
        
        if ([source existWithRegexPattern:@" \\d+s "]) {

            NSRange fullRange   = NSMakeRange(0, source.length);
            NSRange secondRange = [[source matchsWithRegexPattern:@" \\d+s "].firstObject rangeValue];
            
            [configs addObject:[ForegroundColorAttributeConfig configWithColor:[UIColor grayColor] range:fullRange]];
            [configs addObject:[ForegroundColorAttributeConfig configWithColor:[UIColor blackColor] range:secondRange]];
            [configs addObject:[FontAttributeConfig configWithFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.f] range:fullRange]];
            [configs addObject:[FontAttributeConfig configWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.f] range:secondRange]];
        }
    }];
    
    self.countDownLabel.attributedText = atbString;
    [self.countDownLabel sizeToFit];
    self.countDownLabel.centerY = self.height / 2.f;
    self.countDownLabel.left    = 10.f;
}

- (void)configNomalContentView:(UIView *)normalContentView countDownContentView:(UIView *)countDownContentView {
    
    self.normalLabel = [[UILabel alloc] init];
    [normalContentView addSubview:self.normalLabel];
    
    self.countDownLabel = [[UILabel alloc] init];
    [countDownContentView addSubview:self.countDownLabel];
}

- (void)setNormalString:(id)normalString {
    
    NSString *totalString = normalString;
    
    self.normalLabel.attributedText = [NSMutableAttributedString mutableAttributedStringWithString:totalString config:^(NSString *string, NSMutableArray<AttributedStringConfig *> *configs) {
        
        NSRange fullRange = NSMakeRange(0, string.length);
        NSRange smsRange  = [[string matchsWithRegexPattern:@"SMS"].firstObject rangeValue];
        
        [configs addObject:[ForegroundColorAttributeConfig configWithColor:[UIColor redColor] range:fullRange]];
        [configs addObject:[ForegroundColorAttributeConfig configWithColor:[UIColor blackColor] range:smsRange]];
        [configs addObject:[FontAttributeConfig configWithFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.f] range:fullRange]];
        [configs addObject:[FontAttributeConfig configWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.f] range:smsRange]];
    }];
    
    [self.normalLabel sizeToFit];
    self.normalLabel.center = self.middlePoint;
}

- (void)isHighlighted:(BOOL)highlighted {
    
    [UIView animateWithDuration:0.25f delay:0.f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.normalLabel.alpha = highlighted ? 0.25f : 1.f;
        
    } completion:nil];
}

@end
