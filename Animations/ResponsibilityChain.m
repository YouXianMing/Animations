//
//  ResponsibilityChain.m
//  Animations
//
//  Created by YouXianMing on 2017/11/1.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "ResponsibilityChain.h"

@implementation ResponsibilityChain

- (ResponsibilityMessage *)canPassThrough {
    
    ResponsibilityMessage *message = [ResponsibilityMessage new];
    message.checkSuccess           = YES;
    message.object                 = self.object;
    
    return message;
}

@end
