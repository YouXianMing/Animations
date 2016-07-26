//
//  MixedColorProgressViewController.m
//  Animations
//
//  Created by YouXianMing on 16/1/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "MixedColorProgressViewController.h"
#import "UIView+SetRect.h"
#import "GCD.h"

@interface MixedColorProgressViewController ()

@property (nonatomic, strong)  UIView   *upView;
@property (nonatomic, strong)  UILabel  *upLabel;
@property (nonatomic, strong)  UIView   *downView;
@property (nonatomic, strong)  UILabel  *downLabel;

@property (nonatomic, strong)  GCDTimer *timer;

@end

@implementation MixedColorProgressViewController

- (void)setup {

    [super setup];
    
    /*
     给upView的frame值做动画才是label能够混色显示的核心
     
     upView(红色背景)   ===>  upLabel(白色底字)
     |                       |
     |                       |
     |                       |
     |                       |
     downView(白色背景) ===> downLabel(红色底字)
     
     */
    
    // 上面一层
    {
        // 红色背景
        _upView                     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 220, 17)];
        _upView.center              = self.contentView.middlePoint;
        _upView.layer.cornerRadius  = 2.f;
        _upView.backgroundColor     = [UIColor redColor];
        _upView.layer.masksToBounds = YES; // 核心(不让subview显示超出范围)
        [self.contentView addSubview:_upView];
        
        // 白色底字
        _upLabel                    = [[UILabel alloc] initWithFrame:_upView.bounds];
        _upLabel.font               = [UIFont fontWithName:@"HelveticaNeue-Thin" size:13];
        _upLabel.text               = @"YouXianMing - iOS Programmer";
        _upLabel.textColor          = [UIColor whiteColor];
        _upLabel.textAlignment      = NSTextAlignmentCenter;
        [_upView addSubview:_upLabel];
    }
    
    // 下面一层
    {
        // 白色背景
        _downView                     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 220, 17)];
        _downView.center              = self.contentView.middlePoint;
        _downView.layer.cornerRadius  = 2.f;
        _downView.backgroundColor     = [UIColor whiteColor];
        [self.contentView addSubview:_downView];
        
        // 红色底字
        _downLabel                    = [[UILabel alloc] initWithFrame:_downView.bounds];
        _downLabel.textColor          = [UIColor redColor];
        _downLabel.font               = [UIFont fontWithName:@"HelveticaNeue-Thin" size:13];
        _downLabel.text               = @"YouXianMing - iOS Programmer";
        _downLabel.textAlignment = NSTextAlignmentCenter;
        [_downView addSubview:_downLabel];
        
        _downView.layer.borderWidth = 0.5f;
        _downView.layer.borderColor = [UIColor redColor].CGColor;
    }
    
    // 显示上面一层
    [self.contentView bringSubviewToFront:_upView];
    
    // 给上面一层的frame值做动画
    _md_get_weakSelf();
    _timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    [_timer event:^{
        
        [UIView animateWithDuration:0.5f delay:0.f usingSpringWithDamping:3.f initialSpringVelocity:0 options:0 animations:^{
            
            weakSelf.upView.width = arc4random() % 220;
            
        } completion:nil];
        
    } timeInterval:NSEC_PER_SEC];
    [_timer start];
}

@end
