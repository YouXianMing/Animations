//
//  PathView.m
//  Animations
//
//  Created by YouXianMing on 15/11/17.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "PathView.h"
#import "CGContextObject.h"

@interface PathView ()

@property (nonatomic)         CGFloat           width;
@property (nonatomic)         CGFloat           height;
@property (nonatomic, strong) CGContextObject  *contextObject;

@end

@implementation PathView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
    
        self.backgroundColor = [UIColor clearColor];
        
        self.width  = self.bounds.size.width;
        self.height = self.bounds.size.height;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextObjectConfig *config = [CGContextObjectConfig new];
    CGFloat lengths[]             = {2, 2};
    config.lengths                = lengths;
    config.phase                  = 0;
    config.count                  = 2;
    config.strokeColor            = [RGBColor colorWithUIColor:[[UIColor cyanColor] colorWithAlphaComponent:0.5f]];
    config.fillColor              = [RGBColor colorWithUIColor:[UIColor clearColor]];
    config.lineWidth              = 0.5f;

    self.contextObject = [[CGContextObject alloc] initWithCGContext:UIGraphicsGetCurrentContext() config:config];
    [self.contextObject contextConfig:nil drawStrokeBlock:^(CGContextObject *contextObject) {
    
        [self.contextObject addRectPath:CGRectMake(self.gap, self.gap, self.width - self.gap * 2, self.height - self.gap * 2)];
    }];
}

@end
