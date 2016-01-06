//
//  ScrollBlurImageViewController.m
//  Animations
//
//  Created by YouXianMing on 15/11/25.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "ScrollBlurImageViewController.h"
#import "MoreInfoView.h"
#import "UIView+SetRect.h"
#import "Math.h"
#import "UIImage+ImageEffects.h"

static int viewTag = 0x11;

@interface ScrollBlurImageViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray       *picturesArray;
@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) Math          *onceLinearEquation;

@end

@implementation ScrollBlurImageViewController

- (void)setup {
    
    [super setup];
    
    MATHPoint pointA = MATHPointMake(0, -50);
    MATHPoint pointB = MATHPointMake(self.view.width, self.view.width - 50);;

    self.onceLinearEquation = [Math mathOnceLinearEquationWithPointA:pointA PointB:pointB];
    
    // Init pictures data.
    self.picturesArray = @[[UIImage imageNamed:@"beauty"],
                           [[UIImage imageNamed:@"beauty"] blurImage],
                           [[UIImage imageNamed:@"beauty"] grayScale]];
    
    // Init scrollView.
    CGFloat height = self.height;
    CGFloat width  = self.width;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
    _scrollView.delegate                       = self;
    _scrollView.pagingEnabled                  = YES;
    _scrollView.backgroundColor                = [UIColor blackColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces                        = NO;
    _scrollView.contentSize                    = CGSizeMake(self.picturesArray.count * width, height);
    [self.contentView addSubview:_scrollView];
    
    // Init moreInfoViews.
    for (int i = 0; i < self.picturesArray.count; i++) {
        
        MoreInfoView *show     = [[MoreInfoView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
        show.imageView.image   = self.picturesArray[i];
        show.layer.borderWidth = 0.25f;
        show.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f].CGColor;
        show.tag               = viewTag + i;
        
        [_scrollView addSubview:show];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat X = scrollView.contentOffset.x;
    
    for (int i = 0; i < self.picturesArray.count; i++) {
        
        MoreInfoView *show = [scrollView viewWithTag:viewTag + i];
        show.imageView.x   = _onceLinearEquation.k * (X - i * self.contentView.width) + _onceLinearEquation.b;
    }
}

@end
