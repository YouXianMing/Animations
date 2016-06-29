//
//  UIView+AccessViewTag.m
//  Animations
//
//  Created by YouXianMing on 16/6/17.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "UIView+AccessViewTag.h"
#import "AccessViewTagProtocol.h"

@implementation UIView (AccessViewTag)

+ (instancetype)viewWithTag:(NSInteger)tag from:(id <AccessViewTagProtocol>)object {

    return [object viewWithTag:tag];
}

- (void)setTag:(NSInteger)tag attachedTo:(id <AccessViewTagProtocol>)object {

    self.tag = tag;
    [object setView:self withTag:tag];
}

@end
