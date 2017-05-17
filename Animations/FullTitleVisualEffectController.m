//
//  FullTitleVisualEffectController.m
//  Animations
//
//  Created by YouXianMing on 2017/5/17.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "FullTitleVisualEffectController.h"
#import "UIView+SetRect.h"
#import "UIFont+Fonts.h"

@interface FullTitleVisualEffectController ()

@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) UIVisualEffectView *vibrancyEffectView;

@end

@implementation FullTitleVisualEffectController

- (void)makeViewsConfig:(NSMutableDictionary<NSString *,ControllerBaseViewConfig *> *)viewsConfig {
    
    viewsConfig[contentViewId].frame = CGRectMake(0, 0, Width, Height);
}

- (void)setupSubViews {
    
    // 添加模糊效果
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    self.effectView.frame                  = self.titleView.bounds;
    self.effectView.userInteractionEnabled = YES;
    [self.titleView addSubview:self.effectView];
    
    // 需要与作用的effectView的效果一致
    _vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIVibrancyEffect effectForBlurEffect:(UIBlurEffect *)self.effectView.effect]];
    _vibrancyEffectView.frame = self.effectView.bounds;
    [self.effectView.contentView addSubview:self.vibrancyEffectView];
    
    // Back button.
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    backButton.center    = CGPointMake(20, self.titleView.middleY);
    [backButton setImage:[UIImage imageNamed:@"backIcon"]             forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"backIcon_highlighted"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    [backButton.imageView setContentMode:UIViewContentModeCenter];
    [self.titleView addSubview:backButton];
    
    // Title label.
    UILabel *headlinelabel      = [UILabel new];
    headlinelabel.font          = [UIFont HeitiSCWithFontSize:20.f];
    headlinelabel.textAlignment = NSTextAlignmentCenter;
    headlinelabel.textColor     = [UIColor colorWithRed:0.329  green:0.329  blue:0.329 alpha:1];
    headlinelabel.text          = self.title;
    [headlinelabel sizeToFit];
    headlinelabel.center        = self.titleView.middlePoint;
    [_vibrancyEffectView.contentView addSubview:backButton];
    [_vibrancyEffectView.contentView addSubview:headlinelabel];
}

- (void)popSelf {
    
    [self popViewControllerAnimated:YES];
}

@end
