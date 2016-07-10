//
//  QRCodeViewController.m
//  Animations
//
//  Created by YouXianMing on 16/7/8.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "QRCodeViewController.h"
#import "QRCodeView.h"
#import "UIView+SetRect.h"
#import "MessageAlertView.h"
#import "GCD.h"
#import "VideoDeviceAuthorization.h"
#import "CutOutClearView.h"

@interface QRCodeViewController () <QRCodeViewDelegate>

@property (nonatomic, strong) UIButton   *lightButton;
@property (nonatomic, strong) UIView     *blackView;
@property (nonatomic, strong) QRCodeView *codeView;

@end

@implementation QRCodeViewController

- (void)setup {

    [super setup];
    
    // Background view.
    self.blackView                 = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    [self.contentView addSubview:self.blackView];
    
    // ImageView.
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width - 90.f, Width - 90.f)];
    imageView.image        = [UIImage imageNamed:@"最外层"];
    imageView.center       = self.contentView.middlePoint;
    imageView.centerY     += StatusBarAndNavigationBarHeight / 2.f;
    [self.contentView addSubview:imageView];

    // Cutout mask view.
    CutOutClearView *maskView = [[CutOutClearView alloc] initWithFrame:self.contentView.bounds];
    maskView.fillColor        = [UIColor blackColor];
    maskView.paths            = @[[UIBezierPath bezierPathWithRect:imageView.frame]];
    
    // Code view.
    self.codeView                             = [[QRCodeView alloc] initWithFrame:self.contentView.bounds];
    self.codeView.alpha                       = 0.f;
    self.codeView.delegate                    = self;
    self.codeView.interestArea                = imageView.frame;
    self.codeView.contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    self.codeView.contentView.maskView        = maskView;
    [self.contentView addSubview:self.codeView];
    [self.contentView bringSubviewToFront:imageView];
}

- (void)QRCodeView:(QRCodeView *)codeView codeString:(NSString *)codeString {

    [GCDQueue executeInMainQueue:^{

        codeView.torchMode       = AVCaptureTorchModeOff;
        self.lightButton.enabled = NO;
        [self.lightButton setImage:[UIImage imageNamed:@"newbarcode_light_off"] forState:UIControlStateNormal];
        [codeView stop];
        
        AbsAlertMessageView *alertView   = [[MessageAlertView alloc] init];
        alertView.message                = codeString;
        alertView.contentView            = self.loadingView;
        alertView.autoHiden              = YES;
        alertView.delayAutoHidenDuration = 2.f;
        [alertView show];
    }];
    
    [GCDQueue executeInMainQueue:^{
        
        self.lightButton.enabled = YES;
        [codeView start];
        
    } afterDelaySecs:2.05f];
}

#pragma mark - Button event.

- (void)buttonEvent:(UIButton *)button {

    if (self.codeView.torchMode == AVCaptureTorchModeOff) {
        
        self.codeView.torchMode = AVCaptureTorchModeOn;
        [button setImage:[UIImage imageNamed:@"newbarcode_light_on"] forState:UIControlStateNormal];
        
    } else if (self.codeView.torchMode == AVCaptureTorchModeOn) {
    
        self.codeView.torchMode = AVCaptureTorchModeOff;
        [button setImage:[UIImage imageNamed:@"newbarcode_light_off"] forState:UIControlStateNormal];
    }
}

#pragma mark - System method.

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
    if (self.codeView.isRunning == NO) {
        
        if ([self.codeView start]) {
            
            [UIView animateWithDuration:1.f animations:^{
                
                self.codeView.alpha    = 1.f;
                self.lightButton.alpha = 1.f;
                self.blackView.alpha   = 0.f;
            }];
            
        } else {
        
            AbsAlertMessageView *alertView   = [[MessageAlertView alloc] init];
            alertView.message                = @"摄像头不可用";
            alertView.contentView            = self.loadingView;
            alertView.autoHiden              = YES;
            alertView.delayAutoHidenDuration = 2.f;
            [alertView show];
        }
    }
}

- (void)buildTitleView {

    [super buildTitleView];
    
    [[self.titleView subviews] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([view isKindOfClass:[UIVisualEffectView class]]) {
            
            UIVisualEffectView *effectiveView = (UIVisualEffectView *)view;
            [effectiveView.contentView.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj isKindOfClass:[UIVisualEffectView class]]) {
                    
                    UIVisualEffectView *subEffectiveView = (UIVisualEffectView *)obj;
                    
                    // lightButton.
                    UIImage  *image       = [UIImage imageNamed:@"newbarcode_light_off"];
                    UIButton *lightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
                    lightButton.center    = CGPointMake(Width - 20, self.titleView.middleY);
                    [lightButton setImage:image forState:UIControlStateNormal];
                    [lightButton addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
                    [lightButton.imageView setContentMode:UIViewContentModeCenter];
                    [subEffectiveView addSubview:lightButton];
                    
                    self.lightButton       = lightButton;
                    self.lightButton.alpha = 0.f;
                }
            }];
        }
    }];
}

@end
