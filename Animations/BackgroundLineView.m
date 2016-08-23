//
//  BackgroundLineView.m
//  Animations
//
//  Created by YouXianMing on 16/8/23.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "BackgroundLineView.h"

#pragma mark - Private class - @interface LineBackground

@interface LineBackground : UIView

@property (nonatomic) CGFloat lineWidth;
@property (nonatomic) CGFloat lineGap;
@property (nonatomic) CGFloat rotate;

@property (nonatomic, strong) UIColor *lineColor;

+ (LineBackground *)lineBackgroundWithLength:(CGFloat)length;

@end

#pragma mark - Class - BackgroundLineView

@interface BackgroundLineView ()

@property (nonatomic, strong) LineBackground *backgroundView;

@end

@implementation BackgroundLineView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.layer.masksToBounds = YES;
        
        self.backgroundView = [LineBackground lineBackgroundWithLength:0];
        [self addSubview:self.backgroundView];
        
        _lineWidth = 5.f;
        _lineGap   = 3.f;
        _lineColor = [UIColor grayColor];
        _rotate    = 0.f;
    }
    
    return self;
}

+ (instancetype)backgroundLineViewWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth lineGap:(CGFloat)lineGap
                                  lineColor:(UIColor *)lineColor rotate:(CGFloat)rotate {

    BackgroundLineView *lineView = [[[self class] alloc] initWithFrame:frame];
    lineView.lineWidth           = lineWidth;
    lineView.lineGap             = lineGap;
    lineView.lineColor           = lineColor;
    lineView.rotate              = rotate;
    
    return lineView;
}

- (void)layoutSubviews {

    [super layoutSubviews];
    [self setupBackgroundView];
}

- (void)setupBackgroundView {

    CGFloat drawLength     = sqrt(self.bounds.size.width * self.bounds.size.width + self.bounds.size.height * self.bounds.size.height);
    _backgroundView.frame  = CGRectMake(0, 0, drawLength, drawLength);
    _backgroundView.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    [_backgroundView setNeedsDisplay];
}

- (void)setLineGap:(CGFloat)lineGap {

    _lineGap                = lineGap;
    _backgroundView.lineGap = lineGap;
    [_backgroundView setNeedsDisplay];
}

- (void)setLineWidth:(CGFloat)lineWidth {

    _lineWidth                = lineWidth;
    _backgroundView.lineWidth = lineWidth;
    [_backgroundView setNeedsDisplay];
}

- (void)setLineColor:(UIColor *)lineColor {

    _lineColor                = lineColor;
    _backgroundView.lineColor = lineColor;
    [_backgroundView setNeedsDisplay];
}

- (void)setRotate:(CGFloat)rotate {

    _rotate                = rotate;
    _backgroundView.rotate = rotate;
    [_backgroundView setNeedsDisplay];
}

@end

#pragma mark - Private class - @implementation LineBackground

@implementation LineBackground

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
    
        self.backgroundColor = [UIColor clearColor];
        self.lineWidth       = 5.f;
        self.lineGap         = 3.f;
        self.rotate          = 0.f;
        self.lineColor       = [UIColor grayColor];
    }
    
    return self;
}

+ (LineBackground *)lineBackgroundWithLength:(CGFloat)length {

    LineBackground *view = [[LineBackground alloc] initWithFrame:CGRectMake(0, 0, length, length)];
    return view;
}

- (void)drawRect:(CGRect)rect {

    [super drawRect:rect];
    
    if (self.bounds.size.width <= 0 || self.bounds.size.height <= 0) {
        
        return;
    }
    
    CGContextRef context      = UIGraphicsGetCurrentContext();
    CGFloat      width        = self.bounds.size.width;
    CGFloat      height       = self.bounds.size.height;
    CGFloat      drawLength   = sqrt(width * width + height * height);
    CGFloat      outerX       = (drawLength - width)  / 2.0;
    CGFloat      outerY       = (drawLength - height) / 2.0;
    CGFloat      tmpLineWidth = _lineWidth <= 0 ? 5 : _lineWidth;
    CGFloat      tmpLineGap   = _lineGap   <= 0 ? 3 : _lineGap;
    
    CGFloat red   = 0;
    CGFloat green = 0;
    CGFloat blue  = 0;
    CGFloat alpha = 0;
    
    CGContextTranslateCTM(context, 0.5 * drawLength, 0.5 * drawLength);
    CGContextRotateCTM(context, _rotate);
    CGContextTranslateCTM(context, -0.5 * drawLength, -0.5 * drawLength);
    [_lineColor getRed:&red green:&green blue:&blue alpha:&alpha];
    CGContextSetRGBFillColor(context, red, green, blue, alpha);
    
    CGFloat currentX = -outerX;
    
    while (currentX < drawLength) {
        
        CGContextAddRect(context, CGRectMake(currentX, -outerY, tmpLineWidth, drawLength));
        currentX += tmpLineWidth + tmpLineGap;
    }
    
    CGContextFillPath(context);
}

@end

