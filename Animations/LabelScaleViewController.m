//
//  LabelScaleViewController.m
//  Animations
//
//  Created by YouXianMing on 15/12/17.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "LabelScaleViewController.h"
#import "UIView+SetRect.h"
#import "ScaleLabel.h"
#import "UIFont+Fonts.h"
#import "GCD.h"

@interface LabelScaleViewController ()

@end

@implementation LabelScaleViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.backgroundView.backgroundColor = [UIColor blackColor];
    
    {
        ScaleLabel *label      = [[ScaleLabel alloc] initWithFrame:CGRectMake(0, 0, Width, 50)];
        label.text             = @"Metal Gear Solid V";
        label.startScale       = 0.3f;
        label.endScale         = 2.f;
        label.backedLabelColor = [UIColor whiteColor];
        label.colorLabelColor  = [UIColor cyanColor];
        label.font             = [UIFont AvenirLightWithFontSize:20.f];
        label.center           = self.contentView.middlePoint;
        label.centerY         -= 150;
        [self.contentView addSubview:label];
        
        [[GCDQueue mainQueue] execute:^{
            
            [label startAnimation];
            
        } afterDelay:NSEC_PER_SEC * 1];
    }
    
    {
        ScaleLabel *label      = [[ScaleLabel alloc] initWithFrame:CGRectMake(0, 0, Width, 50)];
        label.text             = @"Silent Hill";
        label.startScale       = 0.3f;
        label.endScale         = 2.f;
        label.backedLabelColor = [UIColor cyanColor];
        label.colorLabelColor  = [UIColor yellowColor];
        label.font             = [UIFont AvenirLightWithFontSize:20.f];
        label.center           = self.contentView.middlePoint;
        [self.contentView addSubview:label];
        
        [[GCDQueue mainQueue] execute:^{
            
            [label startAnimation];
            
        } afterDelay:NSEC_PER_SEC * 1];
    }
    
    {
        ScaleLabel *label      = [[ScaleLabel alloc] initWithFrame:CGRectMake(0, 0, Width, 50)];
        label.text             = @"YouXianMing";
        label.startScale       = 1.5f;
        label.endScale         = 2.f;
        label.backedLabelColor = [UIColor redColor];
        label.colorLabelColor  = [UIColor whiteColor];
        label.font             = [UIFont AvenirLightWithFontSize:20.f];
        label.center           = self.contentView.middlePoint;
        label.centerY         += 150;
        [self.contentView addSubview:label];
        
        [[GCDQueue mainQueue] execute:^{
            
            [label startAnimation];
            
        } afterDelay:NSEC_PER_SEC * 1];
    }
}

- (void)setupSubViews {
    
    // Title label.
    UILabel *titleLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Width, 64.f)];
    titleLabel.font          = [UIFont AvenirWithFontSize:20.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor     = [[UIColor whiteColor] colorWithAlphaComponent:0.75f];
    titleLabel.text          = self.title;
    titleLabel.bottom        = self.titleView.height;
    [self.titleView addSubview:titleLabel];
    
    // Line.
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleView.height - 0.5, self.view.width, 0.5f)];
    line.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [self.titleView addSubview:line];
    
    // Back button.
    UIImage  *image      = [UIImage imageNamed:@"backIconVer2"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    backButton.center    = CGPointMake(20, titleLabel.centerY);
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    [backButton.imageView setContentMode:UIViewContentModeCenter];
    [self.titleView addSubview:backButton];
}

- (void)popSelf {
    
    [self popViewControllerAnimated:YES];
}

@end
