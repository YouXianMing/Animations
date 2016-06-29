//
//  LiveImageViewController.m
//  Animations
//
//  Created by YouXianMing on 15/12/27.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "LiveImageViewController.h"
#import "UIView+SetRect.h"
#import "LiveImageView.h"
#import "GCD.h"
#import "UIFont+Fonts.h"

@interface LiveImageViewController ()

@property (nonatomic, strong) GCDTimer  *timer;
@property (nonatomic)         NSInteger  count;

@end

@implementation LiveImageViewController

- (void)setup {
    
    [super setup];
    
    self.backgroundView.backgroundColor = [UIColor blackColor];
    
    UIImage       *image            = [UIImage imageNamed:@"pic_1"];
    LiveImageView *liveImageView    = [[LiveImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    liveImageView.center            = self.contentView.middlePoint;
    liveImageView.layer.borderWidth = 3.f;
    liveImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    liveImageView.duration = 0.5;
    [self.contentView addSubview:liveImageView];
    
    NSArray *pictureArray = @[[UIImage imageNamed:@"pic_1"],
                              [UIImage imageNamed:@"pic_2"],
                              [UIImage imageNamed:@"pic_3"],
                              [UIImage imageNamed:@"pic_4"]];
    
    __weak typeof(self) weakSelf = self;
    _timer                       = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    [_timer event:^{
        
        liveImageView.image    = pictureArray[weakSelf.count++ % pictureArray.count];
        [UIView animateWithDuration:0.5 animations:^{
            
            CGRect tmpRect         = liveImageView.bounds;
            tmpRect.size           = liveImageView.image.size;
            liveImageView.bounds   = tmpRect;
            liveImageView.center   = weakSelf.view.center;
        }];
        
    } timeInterval:NSEC_PER_SEC * 1];
    
    [_timer start];
}

- (void)buildTitleView {
    
    [super buildTitleView];
    
    // Title label.
    UILabel *headlinelabel      = [UILabel new];
    headlinelabel.font          = [UIFont HeitiSCWithFontSize:20.f];
    headlinelabel.textAlignment = NSTextAlignmentCenter;
    headlinelabel.textColor     = [UIColor whiteColor];
    headlinelabel.text          = self.title;
    
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
