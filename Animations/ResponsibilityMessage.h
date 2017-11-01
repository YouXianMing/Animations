//
//  ResponsibilityMessage.h
//  Animations
//
//  Created by YouXianMing on 2017/11/1.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponsibilityMessage : NSObject

@property (nonatomic, weak)   id object;
@property (nonatomic) BOOL       checkSuccess;
@property (nonatomic, strong) id errorMessage;

@end
