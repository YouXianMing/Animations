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

static int type    = 0;
static int viewTag = 0x11;

@interface ScrollImageViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray       *picturesArray;
@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, assign) CGFloat        k;
@property (nonatomic, assign) CGFloat        b;

@end

@implementation ScrollImageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)setup {
    
    [super setup];
    
    // Type.
    if (type % 4 == 0) {
     
        [self linearFunctionPointA:CGPointMake(0, -50) pointB:CGPointMake(self.view.width, 270 - 80)];
        
    } else if (type % 4 == 1) {
    
        [self linearFunctionPointA:CGPointMake(0, -50) pointB:CGPointMake(self.view.width, 270 - 20)];
        
    } else if (type % 4 == 2) {
        
        [self linearFunctionPointA:CGPointMake(0, -50) pointB:CGPointMake(self.view.width, 270 + 20)];
        
    } else if (type % 4 == 3) {
        
        [self linearFunctionPointA:CGPointMake(0, -50) pointB:CGPointMake(self.view.width, 270 + 80)];
    }
    
    type++;
    
    // Init pictures data.
    self.picturesArray = @[[UIImage imageNamed:@"1"],
                           [UIImage imageNamed:@"2"],
                           [UIImage imageNamed:@"3"],
                           [UIImage imageNamed:@"4"],
                           [UIImage imageNamed:@"5"]];
    
    // Init scrollView.
    CGFloat height = self.view.height;
    CGFloat width  = self.view.width;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.delegate        = self;
    _scrollView.pagingEnabled   = YES;
    _scrollView.bounces         = NO;
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView.contentSize     = CGSizeMake(self.picturesArray.count * width, height);
    [self.view addSubview:_scrollView];
    
    // Init moreInfoViews.
    for (int i = 0; i < self.picturesArray.count; i++) {
        
        MoreInfoView *show   = [[MoreInfoView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
        show.imageView.image = self.picturesArray[i];
        show.tag             = viewTag + i;
        
        [_scrollView addSubview:show];
    }
    
    [self bringTitleViewToFront];
    

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat X = scrollView.contentOffset.x;
    
    for (int i = 0; i < self.picturesArray.count; i++) {
        
        MoreInfoView *show = [scrollView viewWithTag:viewTag + i];
        show.imageView.x   = _k * (X - i * self.view.width) + _b;
    }
}

#pragma mark - Other method.
- (void)linearFunctionPointA:(CGPoint)pointA pointB:(CGPoint)pointB {
    
    CGFloat x1 = pointA.x; CGFloat y1 = pointA.y;
    CGFloat x2 = pointB.x; CGFloat y2 = pointB.y;
    
    _k = calculateFunctionSlope(x1, y1, x2, y2);
    _b = calculateFunctionConstant(x1, y1, x2, y2);
}

CGFloat calculateFunctionSlope(CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2) {
    
    return (y2 - y1) / (x2 - x1);
}

CGFloat calculateFunctionConstant(CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2) {
    
    return (y1*(x2 - x1) - x1*(y2 - y1)) / (x2 - x1);
}

@end
