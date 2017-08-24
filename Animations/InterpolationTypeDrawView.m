//
//  InterpolationTypeDrawView.m
//  Animations
//
//  Created by YouXianMing on 2017/8/24.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "InterpolationTypeDrawView.h"
#import "CGContextManager.h"
#import "DrawingAttribute.h"
#import "HexColors.h"
#import "UIView+SetRect.h"
#import "UIBezierPath+Interpolation.h"

@interface InterpolationTypeDrawView () {
    
    CGFloat _leftGap;  // 左边距
    CGFloat _rightGap; // 右边距
    CGFloat _topGap;   // 顶部边距
    
    CGFloat _areaWidth;
    CGFloat _areaHeight;
    
}

@property (nonatomic, strong) CGContextManager                                     *manger;
@property (nonatomic, strong) NSMutableDictionary <NSString *, DrawingAttribute *> *attributes;

@end

@implementation InterpolationTypeDrawView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.manger     = [CGContextManager contextManagerFromView:self];
        self.attributes = [NSMutableDictionary dictionary];
        
        _leftGap    = 20.f;
        _rightGap   = 20.f;
        _topGap     = 20.f;
        
        _areaWidth  = Width - _leftGap - _rightGap;
        _areaHeight = self.height - 40.f;
        
        {
            DrawingAttribute *attribute = [DrawingAttribute new];
            attribute.lineWidth         = 0.5f;
            attribute.strokeColor       = [UIColor colorWithHexString:@"#D2DFEC"];
            attribute.fillColor         = [UIColor colorWithHexString:@"#FFB03B"];
            self.attributes[@"base"]    = attribute;
        }
        
        {
            DrawingAttribute *attribute = [DrawingAttribute new];
            attribute.lineWidth         = 0.5f;
            attribute.lineCap           = kCGLineCapRound;
            attribute.lineDashLengths   = @[@(4.f), @(2.f)];
            attribute.strokeColor       = [UIColor colorWithHexString:@"#404139"];
            attribute.fillColor         = [UIColor colorWithHexString:@"#FFB03B"];
            self.attributes[@"line"] = attribute;
        }
        
        {
            DrawingAttribute *attribute = [DrawingAttribute new];
            attribute.lineWidth         = 1.f;
            attribute.strokeColor       = [UIColor colorWithHexString:@"#FFB03B"];
            self.attributes[@"path"]    = attribute;
        }
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [self.manger startDraw];
    
    [self.manger useDrawingAttribute:self.attributes[@"base"]];
    [self.manger shouldAntialias:NO];
    [self.manger strokeLinesPathWithPointValuesArraysBlock:^NSArray<NSArray<NSValue *> *> *{
        
        return @[@[CGPointValue(_leftGap, _topGap), CGPointValue(_leftGap, _topGap + _areaHeight)],
                 @[CGPointValue(_leftGap, _topGap + _areaHeight / 2.f), CGPointValue(_leftGap + _areaWidth, _topGap + _areaHeight / 2.f)]];
        
    } closePath:NO];
    [self.manger shouldAntialias:YES];
    
    NSArray <NSValue *> *points = [self randomPoints];
    
    [self.manger useDrawingAttribute:self.attributes[@"line"]];
    [self.manger strokeLinePathWithPointValueArrayBlock:^NSArray<NSValue *> *{
        
        return points;
        
    } closePath:NO];
    
    [self.manger useDrawingAttribute:self.attributes[@"path"]];
    UIBezierPath *path = [UIBezierPath interpolateCGPointsWithHermite:points closed:NO];
    [path stroke];
    
    [self.manger useDrawingAttribute:self.attributes[@"line"]];
    [self.manger fillCirclesWithRadius:2.f centerPointValueArrayBlock:^NSArray<NSValue *> *{
        
        return points;
    }];
}

- (NSArray <NSValue *> *)randomPoints {
    
    NSInteger count = 14;
    CGFloat   gap   = _areaWidth / (count - 1);
    
    NSMutableArray *points = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        
        CGFloat randomValue = (arc4random() % 2 == 0 ? 1.f : -1.f) * (arc4random() % (NSInteger)(_areaHeight * 0.5f));
        [points addObject:CGPointValue(_leftGap + i * gap, _topGap + _areaHeight * 0.5f + randomValue)];
    }
    
    return points;
}

@end
