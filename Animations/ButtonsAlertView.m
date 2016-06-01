//
//  ButtonsAlertView.m
//  Animations
//
//  Created by YouXianMing on 16/1/2.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ButtonsAlertView.h"
#import "UIFont+Fonts.h"
#import "UIView+SetRect.h"
#import "UIView+UserInteraction.h"
#import "POP.h"
#import "HexColors.h"

@interface ButtonsAlertView ()

@property (nonatomic, strong) UIButton  *firstButton;
@property (nonatomic, strong) UIButton  *secondButton;
@property (nonatomic, strong) UIView    *blackView;
@property (nonatomic, strong) UIView    *messageView;

@end

@implementation ButtonsAlertView


+ (UIView *)lineViewWithFrame:(CGRect)frame color:(UIColor *)color {
    
    UIView *line         = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = color;
    
    return line;
}

- (instancetype)init {
    
    if (self) {
        
        self = [super init];
        
        // Create Button.
        self.firstButton  = [[UIButton alloc] initWithFrame:CGRectZero];
        self.secondButton = [[UIButton alloc] initWithFrame:CGRectZero];
        
        self.firstButton.userInteractionEnabled = NO;
        self.firstButton.tag                    = 0;
        self.firstButton.titleLabel.font        = [UIFont HeitiSCWithFontSize:16.f];
        [self.firstButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.firstButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self.firstButton addTarget:self action:@selector(messageButtonsEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        self.secondButton.userInteractionEnabled = NO;
        self.secondButton.tag                    = 0;
        self.secondButton.titleLabel.font        = [UIFont HeitiSCWithFontSize:16.f];
        [self.secondButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.secondButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self.secondButton addTarget:self action:@selector(messageButtonsEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        // Store View.
        [self setView:self.firstButton  withKey:@"firstButton"];
        [self setView:self.secondButton withKey:@"secondButton"];
    }
    
    return self;
}

- (void)setContentView:(UIView *)contentView {
    
    [super setContentView:contentView];
    self.frame = contentView.bounds;
}

- (void)show {
    
    if (self.contentView) {
        
        [self.contentView addSubview:self];
        
        [self.contentView enabledUserInteraction];
        [self createBlackView];
        [self createMessageView];
    }
}

- (void)hide {
    
    if (self.contentView) {
        
        [self removeViews];
    }
}

- (void)createBlackView {
    
    self.blackView                 = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.blackView.backgroundColor = [UIColor blackColor];
    self.blackView.alpha           = 0;
    [self addSubview:self.blackView];
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.blackView.alpha = 0.25f;
    }];
}

- (void)createMessageView {
    
    // 创建信息label
    NSString *text          = self.message;
    UILabel *textLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 210, 0)];
    textLabel.text          = text;
    textLabel.font          = [UIFont HeitiSCWithFontSize:15.f];
    textLabel.textColor     = [UIColor blackColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.numberOfLines = 0;
    [textLabel sizeToFit];
    
    // 创建信息窗体view
    self.messageView                    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 240, textLabel.height + 100)];
    self.messageView.backgroundColor    = [UIColor whiteColor];
    self.messageView.layer.cornerRadius = 10.f;
    self.messageView.center             = self.contentView.middlePoint;
    textLabel.center                    = CGPointMake(self.messageView.middleX, 0);
    textLabel.top                       = 30;
    self.messageView.alpha              = 0.f;
    [self.messageView addSubview:textLabel];
    [self addSubview:self.messageView];
    
    // 处理按钮
    NSArray *buttonsInfo = self.buttonsTitle;
    
    // 如果有1个按钮
    if (buttonsInfo.count == 1) {
        
        [self.messageView addSubview:[[self class] lineViewWithFrame:CGRectMake(0, self.messageView.height - 40, self.messageView.width, 0.5f) color:[UIColor colorWithHexString:@"#B9B9B9"]]];
        
        self.firstButton.frame                  = CGRectMake(0, self.messageView.height - 40, self.messageView.width, 40);
        self.firstButton.userInteractionEnabled = NO;
        self.firstButton.tag                    = 0;
        self.firstButton.titleLabel.font        = [UIFont HeitiSCWithFontSize:16.f];
        self.firstButton.exclusiveTouch         = YES;
        [self.firstButton setTitle:self.buttonsTitle[0] forState:UIControlStateNormal];
        [self.firstButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.firstButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self.firstButton addTarget:self action:@selector(messageButtonsEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.messageView addSubview:self.firstButton];
    }
    
    // 如果有2个按钮
    if (buttonsInfo.count == 2) {
        
        [self.messageView addSubview:[[self class] lineViewWithFrame:CGRectMake(0, self.messageView.height - 40, self.messageView.width, 0.5f)
                                                               color:[UIColor colorWithHexString:@"#B9B9B9"]]];
        [self.messageView addSubview:[[self class] lineViewWithFrame:CGRectMake(self.messageView.width / 2.f, self.messageView.height - 40, 0.5f, 40.f)
                                                               color:[UIColor colorWithHexString:@"#B9B9B9"]]];
        
        self.firstButton.frame          = CGRectMake(0, self.messageView.height - 40, self.messageView.width / 2.f, 40);
        self.firstButton.exclusiveTouch = YES;
        [self.firstButton setTitle:self.buttonsTitle[0] forState:UIControlStateNormal];
        [self.messageView addSubview:self.firstButton];
        
        self.secondButton.frame          = CGRectMake(self.messageView.width / 2.f, self.messageView.height - 40, self.messageView.width / 2.f, 40);
        self.secondButton.exclusiveTouch = YES;
        [self.secondButton setTitle:self.buttonsTitle[1] forState:UIControlStateNormal];
        [self.messageView addSubview:self.secondButton];
    }
    
    // 执行动画
    POPBasicAnimation  *alpha = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    alpha.toValue             = @(1.f);
    alpha.duration            = 0.3f;
    [self.messageView pop_addAnimation:alpha forKey:nil];
    
    POPSpringAnimation *scale = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scale.fromValue           = [NSValue valueWithCGSize:CGSizeMake(1.75f, 1.75f)];
    scale.toValue             = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scale.dynamicsTension     = 1000;
    scale.dynamicsMass        = 1.3;
    scale.dynamicsFriction    = 10.3;
    scale.springSpeed         = 20;
    scale.springBounciness    = 15.64;
    scale.delegate            = self;
    [self.messageView.layer pop_addAnimation:scale forKey:nil];
}

- (void)removeViews {
    
    [UIView animateWithDuration:0.2f animations:^{
        
        self.blackView.alpha       = 0.f;
        self.messageView.alpha     = 0.f;
        self.messageView.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
        
    } completion:^(BOOL finished) {
        
        [self.contentView disableUserInteraction];
        [self removeFromSuperview];
    }];
}

- (void)messageButtonsEvent:(UIButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:clickAtIndex:data:)]) {
        
        [self.delegate alertView:self clickAtIndex:button.tag data:nil];
    }
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished {
    
    self.firstButton.userInteractionEnabled  = YES;
    self.secondButton.userInteractionEnabled = YES;
}


@end
