//
//  SKEmitterNodeController.m
//  Animations
//
//  Created by YouXianMing on 2017/9/11.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "SKEmitterNodeController.h"
#import "ParticleSKView.h"

@interface SKEmitterNodeController ()

@end

@implementation SKEmitterNodeController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.backgroundView.backgroundColor = [UIColor blackColor];
    
    ParticleSKView *view = [[ParticleSKView alloc] initWithFrame:self.contentView.bounds];
    view.center          = self.contentView.center;
    [self.contentView addSubview:view];
}

@end
