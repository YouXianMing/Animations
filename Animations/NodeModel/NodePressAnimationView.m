//
//  NodePressAnimationView.m
//  YoCelsius
//
//  Created by YouXianMing on 15/11/12.
//  Copyright © 2015年 XianMingYou. All rights reserved.
//

#import "NodePressAnimationView.h"

#define  SHOW_VIEW_WIDTH    1000
#define  TIME_END_DURATION  0.5
#define  TIME_NOR_DURATION  0.35

@interface NodePressAnimationView ()

@property (nonatomic, strong) UIButton  *button;         // 创建出按钮
@property (nonatomic, strong) UILabel   *normalLabel;    // 普通label
@property (nonatomic, strong) UILabel   *highlightLabel; // 高亮状态的label
@property (nonatomic, strong) UIView    *showView;       // 显示用的view

@end

@implementation NodePressAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.layer.masksToBounds = YES;
        
        // 创建出showView
        [self createShowView];
        
        // 创建出button
        [self createButtonWithFrame:self.bounds];
        
        // 创建出label
        [self createLabelsWithFrame:self.bounds];
    }
    
    return self;
}

#pragma mark - button相关
- (void)createButtonWithFrame:(CGRect)frame {
    
    self.button = [[UIButton alloc] initWithFrame:frame];
    
    // 添加按钮
    [self addSubview:self.button];
    
    // 添加事件
    {
        // 按住按钮后没有松手的动画
        [self.button addTarget:self
                        action:@selector(buttonTouchDownAndDragEnter)
              forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
        
        // 按住按钮松手后的动画
        [self.button addTarget:self
                        action:@selector(buttonTouchUpInside)
              forControlEvents:UIControlEventTouchUpInside];
        
        // 按住按钮后拖拽出去的动画
        [self.button addTarget:self
                        action:@selector(buttonTouchDragExit)
              forControlEvents:UIControlEventTouchDragExit];
    }
}

- (void)buttonTouchDownAndDragEnter {
    
    self.showView.bounds = ((CALayer *)self.showView.layer.presentationLayer).bounds;
    self.showView.alpha  = ((CALayer *)self.showView.layer.presentationLayer).opacity;
    
    self.normalLabel.alpha    = ((CALayer *)self.normalLabel.layer.presentationLayer).opacity;
    self.highlightLabel.alpha = ((CALayer *)self.highlightLabel.layer.presentationLayer).opacity;
    
    // 移除之前的动画状态
    [self.showView.layer removeAllAnimations];
    
    [UIView animateWithDuration:(self.toEndDuration <= 0 ? TIME_END_DURATION : self.toEndDuration) animations:^{
        
        self.showView.bounds = CGRectMake(0, 0, SHOW_VIEW_WIDTH, (self.animationWidth <= 0? SHOW_VIEW_WIDTH : self.animationWidth));
        self.showView.alpha  = 1;
                         
        self.normalLabel.alpha    = 0.f;
        self.highlightLabel.alpha = 1.f;
        
    } completion:^(BOOL finished) {
        
        if (finished == YES) {
            
            if (_delegate && ([_delegate respondsToSelector:@selector(nodePressAnimationViewCompleteEventWithView:)])) {
                
                [_delegate nodePressAnimationViewCompleteEventWithView:self];
            }
        }
    }];
}

- (void)buttonTouchUpInside {
    
    self.showView.bounds = ((CALayer *)self.showView.layer.presentationLayer).bounds;
    self.showView.alpha  = ((CALayer *)self.showView.layer.presentationLayer).opacity;
    
    self.normalLabel.alpha    = ((CALayer *)self.normalLabel.layer.presentationLayer).opacity;
    self.highlightLabel.alpha = ((CALayer *)self.highlightLabel.layer.presentationLayer).opacity;
    
    // 移除之前的动画状态
    [self.showView.layer removeAllAnimations];
    
    [UIView animateWithDuration:(self.toNormalDuration <= 0 ? TIME_NOR_DURATION : self.toNormalDuration) animations:^{
        
        self.showView.bounds = CGRectMake(0, 0, SHOW_VIEW_WIDTH, 0);
        self.showView.alpha  = 0;
        
        self.normalLabel.alpha    = 1.f;
        self.highlightLabel.alpha = 0.f;
        
    } completion:nil];
}

- (void)buttonTouchDragExit {
    
    self.showView.bounds = ((CALayer *)self.showView.layer.presentationLayer).bounds;
    self.showView.alpha  = ((CALayer *)self.showView.layer.presentationLayer).opacity;
    
    self.normalLabel.alpha    = ((CALayer *)self.normalLabel.layer.presentationLayer).opacity;
    self.highlightLabel.alpha = ((CALayer *)self.highlightLabel.layer.presentationLayer).opacity;
    
    // 移除之前的动画状态
    [self.showView.layer removeAllAnimations];
    
    [UIView animateWithDuration:(self.toNormalDuration <= 0 ? TIME_NOR_DURATION : self.toNormalDuration) animations:^{
        
        self.showView.bounds = CGRectMake(0, 0, SHOW_VIEW_WIDTH, 0);
        self.showView.alpha  = 0;
        
        self.normalLabel.alpha    = 1.f;
        self.highlightLabel.alpha = 0.f;
        
    } completion:nil];
}

#pragma mark - showView相关
- (void)createShowView {
    
    self.showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SHOW_VIEW_WIDTH, 0)];
    [self addSubview:self.showView];
    
    self.showView.alpha  = 0.f;
    self.showView.center = CGPointMake(self.frame.size.width / 2.f, self.frame.size.height / 2.f);
    
    self.showView.transform              = CGAffineTransformMakeRotation(45 * M_PI / 180.0);
    self.showView.backgroundColor        = [UIColor redColor];
    self.showView.userInteractionEnabled = NO;
}

#pragma mark - label相关
- (void)createLabelsWithFrame:(CGRect)frame {
    
    self.normalLabel    = [[UILabel alloc] initWithFrame:frame];
    self.highlightLabel = [[UILabel alloc] initWithFrame:frame];
    
    self.normalLabel.alpha    = 1.f;
    self.highlightLabel.alpha = 0.f;
    
    self.normalLabel.textAlignment    = NSTextAlignmentCenter;
    self.highlightLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.highlightLabel];
    [self addSubview:self.normalLabel];
}

#pragma mark - 重写setter,getter方法
@synthesize font = _font;
- (void)setFont:(UIFont *)font {
    
    _font                    = font;
    self.normalLabel.font    = font;
    self.highlightLabel.font = font;
}

- (UIFont *)font {
    
    return _font;
}

@synthesize text = _text;
- (void)setText:(NSString *)text {
    
    _text                    = text;
    self.normalLabel.text    = text;
    self.highlightLabel.text = text;
}

- (NSString *)text {
    
    return _text;
}

@synthesize normalTextColor = _normalTextColor;
- (void)setNormalTextColor:(UIColor *)normalTextColor {
    
    _normalTextColor           = normalTextColor;
    self.normalLabel.textColor = normalTextColor;
}

- (UIColor *)normalTextColor {
    
    return _normalTextColor;
}

@synthesize highlightTextColor = _highlightTextColor;
- (void)setHighlightTextColor:(UIColor *)highlightTextColor {
    
    _highlightTextColor           = highlightTextColor;
    self.highlightLabel.textColor = highlightTextColor;
}

- (UIColor *)highlightTextColor {
    
    return _highlightTextColor;
}

@synthesize animationColor = _animationColor;
- (void)setAnimationColor:(UIColor *)animationColor {
    
    _animationColor               = animationColor;
    self.showView.backgroundColor = animationColor;
}

- (UIColor *)animationColor {
    
    return _animationColor;
}

@end
