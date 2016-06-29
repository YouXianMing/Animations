//
//  ScrollImageViewController.m
//  Animations
//
//  Created by YouXianMing on 15/11/24.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "ScrollImageViewController.h"
#import "MoreInfoView.h"
#import "UIView+SetRect.h"
#import "Math.h"

static int type    = 0;
static int viewTag = 0x11;

@interface ScrollImageViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray       *picturesArray;
@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) Math          *onceLinearEquation;

@end

@implementation ScrollImageViewController

- (void)setup {
    
    [super setup];
    
    MATHPoint pointA;
    MATHPoint pointB;
    
    // Type.
    if (type % 4 == 0) {
        
        pointA = MATHPointMake(0, -50);
        pointB = MATHPointMake(self.contentView.width, 270 - 80);
        
    } else if (type % 4 == 1) {
        
        pointA = MATHPointMake(0, -50);
        pointB = MATHPointMake(self.contentView.width, 270 - 20);
        
    } else if (type % 4 == 2) {
        
        pointA = MATHPointMake(0, -50);
        pointB = MATHPointMake(self.contentView.width, 270 + 20);
        
    } else if (type % 4 == 3) {
        
        pointA = MATHPointMake(0, -50);
        pointB = MATHPointMake(self.contentView.width, 270 + 80);
    }
    
    self.onceLinearEquation = [Math mathOnceLinearEquationWithPointA:pointA PointB:pointB];
    
    type++;
    
    // Init pictures data.
    self.picturesArray = @[[UIImage imageNamed:@"1"],
                           [UIImage imageNamed:@"2"],
                           [UIImage imageNamed:@"3"],
                           [UIImage imageNamed:@"4"],
                           [UIImage imageNamed:@"5"]];
    
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
        
        MoreInfoView *show   = [[MoreInfoView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
        show.imageView.image = self.picturesArray[i];
        show.tag             = viewTag + i;
        
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
