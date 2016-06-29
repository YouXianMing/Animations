//
//  DrawWaveViewController.m
//  Animations
//
//  Created by YouXianMing on 15/12/5.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "DrawWaveViewController.h"
#import "DrawView.h"
#import "DrawLineView.h"
#import "UIView+SetRect.h"

@interface DrawWaveViewController ()

@property (nonatomic, strong) DrawView       *drawView;
@property (nonatomic, strong) DrawLineView   *drawLineView;
@property (nonatomic, strong) CADisplayLink  *displayLink;

@end

@implementation DrawWaveViewController

- (void)setup {

    [super setup];
    
    self.drawView        = [[DrawView alloc] initWithFrame:CGRectMake(0, 0, Width, 200)];
    self.drawView.center = self.contentView.center;
    self.drawView.y     += 100;
    [self.contentView addSubview:self.drawView];
    
    self.drawLineView        = [[DrawLineView alloc] initWithFrame:CGRectMake(0, 0, Width, 200)];
    self.drawLineView.center = self.contentView.center;
    self.drawLineView.y     -= 100;
    [self.contentView addSubview:self.drawLineView];
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawEvent)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)drawEvent {
    
    [self.drawView setNeedsDisplay];
    [self.drawLineView setNeedsDisplay];
}

- (void)viewDidDisappear:(BOOL)animated {

    [self.displayLink invalidate];
    [super viewDidDisappear:animated];
}

@end
