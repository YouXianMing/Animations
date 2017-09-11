//
//  ParticleSKView.m
//  Particles
//
//  Created by YouXianMing on 2017/9/7.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "ParticleSKView.h"
#import "ParticleScene.h"

@interface ParticleSKView ()

@end

@implementation ParticleSKView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.showsFPS       = YES;
        self.showsNodeCount = YES;
        
        ParticleScene *scene = [ParticleScene sceneWithSize:self.bounds.size];
        [self presentScene:scene];
    }
    
    return self;
}

@end
