//
//  AbsAlertMessageView.m
//  TechCode
//
//  Created by YouXianMing on 16/5/15.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "AbsAlertMessageView.h"

@interface AbsAlertMessageView ()

@property (nonatomic, strong) NSMapTable  *mapTable;

@end

@implementation AbsAlertMessageView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.delayAutoHidenDuration = 2.f;
        self.autoHiden              = NO;
        self.mapTable               = [NSMapTable strongToWeakObjectsMapTable];
    }
    
    return self;
}

- (void)show {
    
    [NSException raise:@"AlertViewProtocol"
                format:@"Cannot use show method from subclass."];
}

- (void)hide {
    
    [NSException raise:@"AlertViewProtocol"
                format:@"Cannot use hide method from subclass."];
}

- (void)setView:(UIView *)view withKey:(NSString *)key {
    
    [self.mapTable setObject:view forKey:key];
}

- (UIView *)viewWithKey:(NSString *)key {
    
    return [self.mapTable objectForKey:key];
}

@end
