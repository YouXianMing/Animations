//
//  ParticleScene.m
//  Particles
//
//  Created by YouXianMing on 2017/9/7.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "ParticleScene.h"

@implementation ParticleScene

- (instancetype)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor clearColor];
        
        NSString      *emitterPath = [[NSBundle mainBundle] pathForResource:@"Magic" ofType:@"sks"];
        
        SKEmitterNode *emitterNode = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
        emitterNode.position       = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        [self addChild:emitterNode];
    }
    
    return self;
}

@end
