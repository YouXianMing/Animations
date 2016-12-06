//
//  HeaderIconCell.m
//  Animations
//
//  Created by YouXianMing on 2016/11/24.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "HeaderIconCell.h"
#import "UIView+SetRect.h"
#import "UIView+AnimationProperty.h"
#import "Math.h"
#import "ShapeView.h"
#import "UIColor+ForPublicUse.h"
#import "GCD.h"
#import "UIImage+ImageEffects.h"

static CGFloat _HeaderIconCellHeight = 300.f;

@interface HeaderIconCell () {
    
    Math *_scale;
    Math *_blurImageViewAlpha;
    Math *_grayImageViewAlpha;
}

@property (nonatomic, strong) UIView      *backgroundContentView;
@property (nonatomic, strong) UIView      *scaleContentView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *blurImageView;
@property (nonatomic, strong) UIImageView *grayImageView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel     *nameLabel;

@end

@implementation HeaderIconCell

- (void)setupCell {
    
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    _scale               = [Math mathOnceLinearEquationWithPointA:MATHPointMake(0, 1.f) PointB:MATHPointMake(-200, 2.f)];
    _blurImageViewAlpha  = [Math mathOnceLinearEquationWithPointA:MATHPointMake(0, 0.f) PointB:MATHPointMake(-150, 1.f)];
    _grayImageViewAlpha  = [Math mathOnceLinearEquationWithPointA:MATHPointMake(0, 0.f) PointB:MATHPointMake(100.f, 1.f)];
}

- (void)buildSubview {
    
    self.backgroundContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, HeaderIconCell.cellHeight)];
    [self addSubview:self.backgroundContentView];
    
    // Used for scale.
    self.scaleContentView                     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, HeaderIconCell.cellHeight)];
    self.scaleContentView.layer.anchorPoint   = CGPointMake(0.5f, 1.f);
    self.scaleContentView.top                 = 0.f;
    self.scaleContentView.layer.masksToBounds = YES;
    [self.backgroundContentView addSubview:self.scaleContentView];
    
    // Normal imageView.
    self.backgroundImageView             = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, HeaderIconCell.cellHeight)];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundImageView.image       = [UIImage imageNamed:@"gerenBG"];
    [self.scaleContentView addSubview:self.backgroundImageView];
    
    // Blur imageView.
    self.blurImageView             = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, HeaderIconCell.cellHeight)];
    self.blurImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.blurImageView.alpha       = 0.f;
    [self.scaleContentView addSubview:self.blurImageView];
    [GCDQueue executeInGlobalQueue:^{
        
        UIImage *image = [[UIImage imageNamed:@"gerenBG"] blurImage];
        [GCDQueue executeInMainQueue:^{
            
            self.blurImageView.image = image;
        }];
    }];
    
    // Gray imageView.
    self.grayImageView             = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, HeaderIconCell.cellHeight)];
    self.grayImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.grayImageView.alpha       = 0.f;
    [self.scaleContentView addSubview:self.grayImageView];
    [GCDQueue executeInGlobalQueue:^{
        
        UIImage *image = [[UIImage imageNamed:@"gerenBG"] grayScale];
        [GCDQueue executeInMainQueue:^{
            
            self.grayImageView.image = image;
        }];
    }];
    
    // Bottom shapeView.
    ShapeView *areaView = [[ShapeView alloc] initWithFrame:CGRectMake(0, 0, Width, HeaderIconCell.cellHeight)];
    areaView.fillColor  = [UIColor backgroundColor];
    areaView.points     = @[[NSValue valueWithCGPoint:CGPointMake(0, HeaderIconCell.cellHeight)],
                            [NSValue valueWithCGPoint:CGPointMake(0, HeaderIconCell.cellHeight - 50.f)],
                            [NSValue valueWithCGPoint:CGPointMake(Width, HeaderIconCell.cellHeight - 100.f)],
                            [NSValue valueWithCGPoint:CGPointMake(Width, HeaderIconCell.cellHeight)],
                            [NSValue valueWithCGPoint:CGPointMake(0, HeaderIconCell.cellHeight)]];
    [self addSubview:areaView];
    
    // Icon imageView.
    self.iconImageView                     = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 110.f, 110.f)];
    self.iconImageView.layer.cornerRadius  = self.iconImageView.width / 2.f;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.borderWidth   = 1.f;
    self.iconImageView.layer.borderColor   = [[UIColor grayColor] colorWithAlphaComponent:0.25f].CGColor;
    self.iconImageView.image               = [UIImage imageNamed:@"girl"];
    self.iconImageView.centerX             = Width / 2.f;
    self.iconImageView.centerY             = HeaderIconCell.cellHeight - 100 + 25.f;
    [self addSubview:self.iconImageView];
    
    // Name label.
    self.nameLabel           = [[UILabel alloc] init];
    self.nameLabel.text      = @"YouXianMing";
    self.nameLabel.font      = [UIFont fontWithName:@"GillSans-LightItalic" size:16.f];
    self.nameLabel.textColor = [UIColor darkGrayColor];
    [self.nameLabel sizeToFit];
    self.nameLabel.centerX   = Width / 2.f;
    self.nameLabel.top       = self.iconImageView.bottom + 15.f;
    [self addSubview:self.nameLabel];
}

- (void)offsetY:(CGFloat)offsetY {
    
    if (offsetY <= 0) {
        
        self.scaleContentView.scale = offsetY * _scale.k + _scale.b;
        self.backgroundImageView.y  = 0.f;

        self.blurImageView.alpha = offsetY * _blurImageViewAlpha.k + _blurImageViewAlpha.b;
        self.grayImageView.alpha = 0.f;
        
    } else {
        
        self.scaleContentView.scale = 1.f;
        self.backgroundImageView.y  = offsetY / 2.f;
        
        self.blurImageView.alpha = 0.f;
        self.grayImageView.y     = offsetY / 2.f;
        self.grayImageView.alpha = offsetY * _grayImageViewAlpha.k + _grayImageViewAlpha.b;
    }
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {

    _HeaderIconCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {

    return _HeaderIconCellHeight;
}

@end
