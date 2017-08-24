//
//  StudyInfoDrawView.m
//  Animations
//
//  Created by YouXianMing on 2017/8/24.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "StudyInfoDrawView.h"
#import "CGContextManager.h"
#import "UIView+SetRect.h"
#import "HexColors.h"
#import "AttributedStringConfigHelper.h"

@interface StudyInfoDrawView () {
    
    CGFloat _leftGap;  // 左边距
    CGFloat _rightGap; // 右边距
    CGFloat _topGap;   // 顶部边距
    
    CGFloat _areaWidth;
    CGFloat _areaHeight;
    
    NSInteger _hrLineCount; // 水平线条数目
}

@property (nonatomic, strong) CGContextManager *manager;
@property (nonatomic, strong) NSMutableDictionary <NSString *, DrawingAttribute *> *attributes;

@end

@implementation StudyInfoDrawView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.manager    = [CGContextManager contextManagerFromView:self];
        self.attributes = [NSMutableDictionary dictionary];
        
        _leftGap    = 50.f;
        _rightGap   = 30.f;
        _topGap     = 50.f;
        
        _areaWidth  = Width - _leftGap - _rightGap;
        _areaHeight = 125.f;
        
        _hrLineCount = 5;
        
        {
            DrawingAttribute *attribute = [DrawingAttribute new];
            attribute.lineWidth         = 0.5f;
            attribute.strokeColor       = [UIColor colorWithHexString:@"#D2DFEC"];
            attribute.fillColor         = [UIColor colorWithHexString:@"#FFB03B"];
            self.attributes[@"base"]    = attribute;
        }
        
        {
            DrawingAttribute *attribute = [DrawingAttribute new];
            attribute.lineWidth         = 1.f;
            attribute.lineCap           = kCGLineCapRound;
            attribute.strokeColor       = [UIColor colorWithHexString:@"#FFB03B"];
            attribute.fillColor         = [UIColor colorWithHexString:@"#FFB03B"];
            self.attributes[@"line"] = attribute;
        }
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [self.manager startDraw];
    
    if (self.model) {
        
        CGFloat vtGridGap = _areaWidth / (self.model.times.count - 1);
        CGFloat hrGridGap = _areaHeight / (_hrLineCount - 1);
        
        // 绘制标题
        NSMutableAttributedString *title = \
        [NSMutableAttributedString mutableAttributedStringWithString:self.model.title config:^(NSString *string, NSMutableArray<AttributedStringConfig *> *configs) {
            
            [configs addObject:[FontAttributeConfig configWithFont:[UIFont AvenirLightWithFontSize:16.f] range:NSMakeRange(0, string.length)]];
        }];
        [self.manager drawAttributeString:title atPoint:CGPointMake(Width / 2.f, _topGap / 2.f) centerAlignment:DrawContentCenterAlignmentCenterPosition offsetX:0 offsetY:0];
        
        // 绘制坐标轴
        [self.manager shouldAntialias:NO];
        [self.manager useDrawingAttribute:self.attributes[@"base"]];
        [self.manager strokeLinesPathWithPointValuesArraysBlock:^NSArray<NSArray<NSValue *> *> *{
            
            NSMutableArray *allLines = [NSMutableArray array];
            
            // 垂直线条
            for (int i = 0; i < self.model.times.count; i++) {
                
                NSMutableArray *vtLines = [NSMutableArray array];
                [vtLines addObject:CGPointValue(_leftGap + i * vtGridGap, _topGap)];
                [vtLines addObject:CGPointValue(_leftGap + i * vtGridGap, _topGap + _areaHeight)];
                
                [allLines addObject:vtLines];
            }
            
            // 水平线条
            for (int i = 0; i < _hrLineCount; i++) {
                
                NSMutableArray *hrLines = [NSMutableArray array];
                [hrLines addObject:CGPointValue(_leftGap, _topGap  + i * hrGridGap)];
                [hrLines addObject:CGPointValue(_leftGap + _areaWidth, _topGap  + i * hrGridGap)];
                
                [allLines addObject:hrLines];
            }
            
            return allLines;
            
        } closePath:NO];
        [self.manager shouldAntialias:YES];
        
        //  绘制坐标系底部的文本
        [self.model.times enumerateObjectsUsingBlock:^(StudyTimeModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx != 0) {
                
                [self.manager drawAttributeString:model.timeString atPoint:CGPointMake(_leftGap + idx * vtGridGap, _areaHeight + _topGap)
                                  centerAlignment:DrawContentCenterAlignmentBottomSide offsetX:0 offsetY:3.f];
            }
        }];
        
        // 绘制坐标系左边文本
        for (int i = 0; i < _hrLineCount; i++) {
            
            if (i == _hrLineCount - 1) {
                
                continue;
            }
            
            NSMutableAttributedString *percent = \
            [NSMutableAttributedString mutableAttributedStringWithString:[NSString stringWithFormat:@"%.f%%", (1.f - i * (1.f / (_hrLineCount - 1))) * 100.f] config:^(NSString *string, NSMutableArray<AttributedStringConfig *> *configs) {
                
                [configs addObject:[FontAttributeConfig configWithFont:[UIFont AvenirLightWithFontSize:10.f] range:NSMakeRange(0, string.length)]];
                [configs addObject:[FontAttributeConfig configWithFont:[UIFont AvenirLightWithFontSize:6.f] range:NSMakeRange(string.length - 1, 1)]];
                [configs addObject:[ForegroundColorAttributeConfig configWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.75f] range:NSMakeRange(0, string.length)]];
            }];
            
            [self.manager drawAttributeString:percent atPoint:CGPointMake(_leftGap, _topGap + i * hrGridGap) centerAlignment:DrawContentCenterAlignmentLeftSide offsetX:-3.f offsetY:0];
        }
        
        // 计算并存储中心点
        NSMutableArray <NSValue *> *centerPoints = [NSMutableArray array];
        [self.model.times enumerateObjectsUsingBlock:^(StudyTimeModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [centerPoints addObject:CGPointValue(_leftGap + idx * vtGridGap, _areaHeight - model.percent * _areaHeight + _topGap)];
        }];
        
        // 绘制坐标轴中的折线
        [self.manager useDrawingAttribute:self.attributes[@"line"]];
        [self.manager strokeLinePathWithPointValueArrayBlock:^NSArray<NSValue *> *{
            
            return centerPoints;
            
        } closePath:NO];
        
        // 绘制折线上的圆点
        [self.manager fillCirclesWithRadius:2.f centerPointValueArrayBlock:^NSArray<NSValue *> *{
            
            return [centerPoints subarrayWithRange:NSMakeRange(1, centerPoints.count - 1)];
        }];
        
        // 绘制折线上的文本
        [centerPoints enumerateObjectsUsingBlock:^(NSValue *point, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx != 0) {
                
                [self.manager drawAttributeString:self.model.times[idx].percentString atPoint:point.CGPointValue
                                  centerAlignment:DrawContentCenterAlignmentTopSide offsetX:0 offsetY:-3.f];
            }
        }];
    }
}

- (void)setModel:(StudyInfoModel *)model {
    
    _model = model;
    [self setNeedsDisplay];
}

@end
