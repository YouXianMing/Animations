//
//  SelectedItemChain.m
//  Animations
//
//  Created by YouXianMing on 2017/11/30.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "SelectedItemChain.h"
#import "SelectItemView.h"

@interface SelectedItemChain ()

@property (nonatomic, strong) NSString *errorMessage;

@end

@implementation SelectedItemChain

- (ResponsibilityMessage *)canPassThrough {
    
    SelectItemView        *itemView = self.object;
    ResponsibilityMessage *message  = [ResponsibilityMessage new];
    message.object                  = self.object;
    
    if (itemView.content.string.length > 0) {
        
        message.checkSuccess = YES;
        
    } else {
        
        message.errorMessage = self.errorMessage;
    }
    
    return message;
}

+ (instancetype)selectedItemChainWithErrorMessage:(NSString *)string {
    
    SelectedItemChain *chain = [SelectedItemChain new];
    chain.errorMessage       = string;
    
    return chain;
    
}

@end
