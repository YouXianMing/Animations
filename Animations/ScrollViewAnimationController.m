//
//  ScrollViewAnimationController.m
//  Animations
//
//  Created by YouXianMing on 16/3/13.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ScrollViewAnimationController.h"
#import "UIView+SetRect.h"
#import "ScrollComputingValue.h"
#import "ScrollTitleView.h"

typedef enum : NSUInteger {
    
    kTitleViewTag = 1000,
    kPictureTag   = 2000,
    
} EScrollViewAnimationControllerValue;

@interface ScrollViewAnimationController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView         *scrollView;
@property (nonatomic, strong) UIView               *redView;
@property (nonatomic, strong) UIView               *titlesContentView;

@property (nonatomic, strong) NSMutableArray       *computingValuesArray;
@property (nonatomic, strong) NSArray              *titles;
@property (nonatomic, strong) NSArray              *pictures;

@end

@implementation ScrollViewAnimationController

- (void)setup {

    [super setup];
    
    self.scrollView                                = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
    self.scrollView.contentSize                    = CGSizeMake(self.contentView.width * 3, self.contentView.height);
    self.scrollView.pagingEnabled                  = YES;
    self.scrollView.bounces                        = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate                       = self;
    [self.contentView addSubview:self.scrollView];
    
    self.titlesContentView                        = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, TabbarHeight)];
    self.titlesContentView.backgroundColor        = [[UIColor blackColor] colorWithAlphaComponent:0.65f];
    self.titlesContentView.userInteractionEnabled = NO;
    self.titlesContentView.bottom                 = self.contentView.height;
    [self.contentView addSubview:self.titlesContentView];
    
    self.redView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width / 3.f, 1.f)];
    self.redView.backgroundColor = [UIColor redColor];
    [self.titlesContentView addSubview:self.redView];
    
    self.computingValuesArray = [NSMutableArray array];
    self.titles               = @[@"Google", @"DeepMind", @"AlphaGo"];
    self.pictures             = @[@"1", @"2", @"3"];
    for (int i = 0; i < self.titles.count; i++) {
        
        // Setup pictures.
        UIImageView *imageView        = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height)];
        imageView.image               = [UIImage imageNamed:_pictures[i]];
        imageView.contentMode         = UIViewContentModeScaleAspectFill;
        imageView.tag                 = kPictureTag + i;
        imageView.layer.masksToBounds = YES;
        [self.contentView addSubview:imageView];
        
        // Setup TitleViews.
        ScrollTitleView *titleView = [[ScrollTitleView alloc] initWithFrame:CGRectMake(i * Width / 3.f, 0, Width / 3.f, self.titlesContentView.height)];
        titleView.title            = self.titles[i];
        titleView.tag              = kTitleViewTag + i;
        [titleView buildSubViews];
        [self.titlesContentView addSubview:titleView];
        
        // Init values.
        if (i == 0) {
            
            titleView.inputValue = 1.f;
            imageView.alpha      = 1.f;
            
        } else {
        
            titleView.inputValue = 0.f;
            imageView.alpha      = 0.f;
        }
        
        // Setup ScrollComputingValues.
        ScrollComputingValue *value = [ScrollComputingValue new];
        value.startValue            = -Width + i * Width;
        value.midValue              = 0      + i * Width;
        value.endValue              = +Width + i * Width;
        [value makeTheSetupEffective];
        [self.computingValuesArray addObject:value];
    }
    
    [self.contentView bringSubviewToFront:self.titlesContentView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat offsetX = scrollView.contentOffset.x;
    _redView.x      = offsetX / 3.f;
    
    for (int i = 0; i < _titles.count; i++) {
        
        ScrollTitleView      *titleView = [_titlesContentView viewWithTag:kTitleViewTag + i];
        UIImageView          *imageView = [self.contentView viewWithTag:kPictureTag + i];
        ScrollComputingValue *value     = _computingValuesArray[i];
        
        value.inputValue     = offsetX;
        titleView.inputValue = value.outputValue;
        imageView.alpha      = value.outputValue;
    }
}

@end
