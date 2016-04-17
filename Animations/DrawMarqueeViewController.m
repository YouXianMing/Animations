//
//  DrawMarqueeViewController.m
//  Animations
//
//  Created by YouXianMing on 16/4/13.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "DrawMarqueeViewController.h"
#import "DrawMarqueeView.h"
#import "NSString+LabelWidthAndHeight.h"
#import "UIView+SetRect.h"
#import "UIFont+Fonts.h"
#import "UIView+GlowView.h"
#import "GCD.h"

@interface DrawMarqueeViewController () <DrawMarqueeViewDelegate>

@property (nonatomic, strong) UILabel *label;

@end

@implementation DrawMarqueeViewController

- (void)setup {

    [super setup];
    
    self.backgroundView.backgroundColor = [UIColor blackColor];
    
    DrawMarqueeView *drawMarqueeView  = [[DrawMarqueeView alloc] initWithFrame:CGRectMake(0, 0, 250.f, 20)];
    drawMarqueeView.layer.borderWidth = 0.5f;
    drawMarqueeView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.25].CGColor;
    drawMarqueeView.speed             = 0.5f;
    drawMarqueeView.delegate          = self;
    drawMarqueeView.marqueeDirection  = kDrawMarqueeLeft;
    drawMarqueeView.center            = self.contentView.middlePoint;
    [self.contentView addSubview:drawMarqueeView];
    [drawMarqueeView addContentView:[self createLabelWithText:@"Copyright © 2016 YouXianMing. All rights reserved."
                                                    textColor:[self randomColor]]];
    [drawMarqueeView startAnimation];
}

- (UILabel *)createLabelWithText:(NSString *)text textColor:(UIColor *)textColor {

    NSString *string = [NSString stringWithFormat:@" %@ ", text];
    CGFloat   width  = [string widthWithStringAttribute:@{NSFontAttributeName : [UIFont HeitiSCWithFontSize:14.f]}];
    UILabel  *label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
    label.font       = [UIFont HeitiSCWithFontSize:14.f];
    label.text       = string;
    label.textColor  = textColor;
    
    label.glowRadius            = @(2.f);
    label.glowOpacity           = @(1.f);
    label.glowColor             = [textColor colorWithAlphaComponent:0.86];
    label.glowDuration          = @(1.f);
    label.hideDuration          = @(3.f);
    label.glowAnimationDuration = @(2.f);
    [label createGlowLayer];
    [label insertGlowLayer];
    [label startGlowLoop];
    
    return label;
}

- (void)drawMarqueeView:(DrawMarqueeView *)drawMarqueeView animationDidStopFinished:(BOOL)finished {

    [drawMarqueeView stopAnimation];
    
    [GCDQueue executeInMainQueue:^{
        
        [drawMarqueeView addContentView:[self createLabelWithText:[self randomString] textColor:[self randomColor]]];
        [drawMarqueeView startAnimation];
        
    } afterDelaySecs:1.f];
}

- (NSString *)randomString {

    NSArray *array = @[@"台湾释放被遣返诈骗犯 国台办要求立即纠正错误，严惩嫌犯",
                       @"李克强与教授对谈\"清华简\"谈高等教育发展",
                       @"史玉柱要引入狼性文化 问题是头狼在哪",
                       @"日本熊本县7.3级已致41人遇难",
                       @"中国留学生亲历日本地震：连被子都能震掉",
                       @"人民日报详解养老金上调6.5%是如何确定的",
                       @"央视曝棉农生存困境:辛苦大半年一亩地赔400元",
                       @"北京市教委:非京籍学生入学仍审\"五证\"",
                       @"北京国安局\"猎狐高手\"3年铲除核心区10余内奸"];
    
    return array[arc4random() % array.count];
}

- (UIColor *)randomColor {
    
    return [UIColor colorWithRed:[self randomValue] green:[self randomValue] blue:[self randomValue] alpha:1];
}

- (CGFloat)randomValue {
    
    return arc4random() % 256 / 255.f;
}

- (void)buildTitleView {
    
    [super buildTitleView];
    
    [self.titleView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeFromSuperview];
    }];
    
    // Title label.
    UILabel *headlinelabel      = [UILabel new];
    headlinelabel.font          = [UIFont AvenirWithFontSize:20.f];
    headlinelabel.textAlignment = NSTextAlignmentCenter;
    headlinelabel.textColor     = [[UIColor whiteColor] colorWithAlphaComponent:0.75f];
    headlinelabel.text          = self.title;
    [headlinelabel sizeToFit];
    
    headlinelabel.center = self.titleView.middlePoint;
    
    // Line.
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, self.view.width, 0.5f)];
    line.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [self.titleView addSubview:line];
    [self.titleView addSubview:headlinelabel];
    
    // Back button.
    UIImage  *image      = [UIImage imageNamed:@"backIconVer2"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    backButton.center    = CGPointMake(20, self.titleView.middleY);
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    [backButton.imageView setContentMode:UIViewContentModeCenter];
    [self.titleView addSubview:backButton];
}

- (void)popSelf {
    
    [self popViewControllerAnimated:YES];
}

@end
