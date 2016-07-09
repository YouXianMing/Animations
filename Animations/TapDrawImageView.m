//
//  TapDrawImageView.m
//  TapDrawImageView
//
//  Created by YouXianMing on 16/5/9.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "TapDrawImageView.h"

@interface TapDrawImageView ()

@property (nonatomic, strong) TapDrawPathManager  *currentSelectedManager;
@property (nonatomic, strong) UIImageView         *imageView;

@end

@implementation TapDrawImageView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.pathManagers    = [NSMutableArray array];
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self.pathManagers enumerateObjectsUsingBlock:^(TapDrawPathManager *pathManager, NSUInteger idx, BOOL *stop) {
        
        TapDrawObject *drawObject = [pathManager.colorsType objectForKey:pathManager.currentDrawType];
        
        // Set Fill Color.
        {
            CGFloat red   = 0;
            CGFloat green = 0;
            CGFloat blue  = 0;
            CGFloat alpha = 0;
            [drawObject.fillColor getRed:&red green:&green blue:&blue alpha:&alpha];
            CGContextSetRGBFillColor(context, red, green, blue, alpha);
        }
        
        // Set Stroke Color.
        {
            CGFloat red   = 0;
            CGFloat green = 0;
            CGFloat blue  = 0;
            CGFloat alpha = 0;
            [drawObject.strokeColor getRed:&red green:&green blue:&blue alpha:&alpha];
            CGContextSetRGBStrokeColor(context, red, green, blue, alpha);
        }
        
        pathManager.path.lineWidth = drawObject.lineWidth;
        [pathManager.path fill];
        [pathManager.path stroke];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch     = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    [self.pathManagers enumerateObjectsUsingBlock:^(TapDrawPathManager *pathManager, NSUInteger idx, BOOL *stop) {
        
        if ([pathManager.path containsPoint:touchPoint]) {
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(tapDrawImageView:selectedPathManager:)]) {
                
                [self.delegate tapDrawImageView:self selectedPathManager:pathManager];
            }
            
            if ([pathManager.currentDrawType isEqualToString:tapDrawImageDisableState] == NO) {
                
                pathManager.currentDrawType = tapDrawImageViewHighlightState;
                _currentSelectedManager     = pathManager;
                [self setNeedsDisplay];
            }
            
            *stop = YES;
        }
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if (_currentSelectedManager) {
        
        _currentSelectedManager.currentDrawType = tapDrawImageViewNormalState;
        [self setNeedsDisplay];
    }
    _currentSelectedManager = nil;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if (_currentSelectedManager) {
        
        _currentSelectedManager.currentDrawType = tapDrawImageViewNormalState;
        [self setNeedsDisplay];
    }
    _currentSelectedManager = nil;
}

@end
