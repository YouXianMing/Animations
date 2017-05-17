//
//  ScrollCarouselViewController.m
//  Animations
//
//  Created by YouXianMing on 2017/1/4.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "ScrollCarouselViewController.h"
#import "UIView+SetRect.h"
#import "LinearCarouselView.h"
#import "ScrollCarouselView.h"

@interface ScrollCarouselViewController () <iCarouselViewDelegate> {
    
    LinearCarouselView *_lineCarouseView;
    ScrollCarouselView *_scrollCarouseView;
}

@end

@implementation ScrollCarouselViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    _lineCarouseView          = [[LinearCarouselView alloc] initWithFrame:CGRectMake(0, 0, Width, self.contentView.height / 2.f - 40.f)];
    _lineCarouseView.delegate = self;
    _lineCarouseView.alpha    = 0.f;
    _lineCarouseView.adapters = @[[self iCarouselAdapterWithImageName:@"1"],
                                  [self iCarouselAdapterWithImageName:@"2"],
                                  [self iCarouselAdapterWithImageName:@"3"],
                                  [self iCarouselAdapterWithImageName:@"4"],
                                  [self iCarouselAdapterWithImageName:@"5"]];
    _lineCarouseView.centerY  = self.contentView.height * 0.25 + 6;
    [self.contentView addSubview:_lineCarouseView];
    
    _scrollCarouseView          = [[ScrollCarouselView alloc] initWithFrame:CGRectMake(0, self.contentView.height / 2.f, Width, self.contentView.height / 2.f - 40.f)];
    _scrollCarouseView.delegate = self;
    _scrollCarouseView.alpha    = 0.f;
    _scrollCarouseView.adapters = @[[self iCarouselAdapterWithImageName:@"1"],
                                    [self iCarouselAdapterWithImageName:@"2"],
                                    [self iCarouselAdapterWithImageName:@"3"],
                                    [self iCarouselAdapterWithImageName:@"4"],
                                    [self iCarouselAdapterWithImageName:@"5"]];
    _scrollCarouseView.centerY  = self.contentView.height * 0.75 - 6;
    [self.contentView addSubview:_scrollCarouseView];

}

- (iCarouselAdapter *)iCarouselAdapterWithImageName:(NSString *)name {
    
    iCarouselAdapter *adapter = [iCarouselAdapter new];
    adapter.data              = name;
    
    return adapter;
}

- (void)iCarouselView:(iCarouselView *)iCarouselView didSelectCarouselAbsItemView:(iCarouselAbsItemView *)itemView adapter:(iCarouselAdapter *)adapter {
    
    NSLog(@"%@", itemView);
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [_lineCarouseView reloadData];
    [_scrollCarouseView reloadData];
    [UIView animateWithDuration:0.5f animations:^{
        
        _lineCarouseView.alpha   = 1.f;
        _scrollCarouseView.alpha = 1.f;
    }];
}

@end
