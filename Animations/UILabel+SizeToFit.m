//
//  UILabel+SizeToFit.m
//  Animations
//
//  Created by YouXianMing on 2016/11/11.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "UILabel+SizeToFit.h"

@implementation UILabel (SizeToFit)

- (void)sizeToFitWithText:(NSString *)text config:(void (^)(UILabel *label))configBlock {

    self.text = text;
    [self sizeToFit];
    
    if (configBlock) {
        
        configBlock(self);
    }
}

- (void)sizeToFitWithAttributedText:(NSAttributedString *)text config:(void (^)(UILabel *label))configBlock {
    
    self.attributedText = text;
    [self sizeToFit];
    
    if (configBlock) {
        
        configBlock(self);
    }
}

@end
