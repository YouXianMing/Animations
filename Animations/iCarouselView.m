//
//  iCarouselView.m
//  iCarouselExample
//
//  Created by YouXianMing on 2016/12/28.
//  Copyright © 2016年 TechCode. All rights reserved.
//

#import "iCarouselView.h"

@interface iCarouselView () <iCarouselDelegate, iCarouselDataSource>

@property (nonatomic, strong) iCarousel *carousel;

@end

@implementation iCarouselView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.adapters            = [NSMutableArray array];
        
        self.carousel            = [[iCarousel alloc] initWithFrame:self.bounds];
        self.carousel.dataSource = self;
        self.carousel.delegate   = self;
        [self addSubview:self.carousel];

        [self configTheiCarousel:self.carousel];
    }
    
    return self;
}

- (void)reloadData {

    [self.carousel reloadData];
}

- (void)configTheiCarousel:(iCarousel *)iCarousel {

}

- (__kindof iCarouselAbsItemView *)viewForItemAtIndex:(NSInteger)index adapter:(iCarouselAdapter *)adapter reusingView:(__kindof iCarouselAbsItemView *)view {
    
    return view;
}

- (CGFloat)valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    
    return value;
}

#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {

    return self.adapters.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {

    return [self viewForItemAtIndex:index adapter:_adapters[index] reusingView:(iCarouselAbsItemView *)view];
}

#pragma mark - iCarouselDelegate

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    
    return [self valueForOption:option withDefault:value];
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(iCarouselView:didSelectCarouselAbsItemView:adapter:)] && carousel.currentItemIndex == index) {
        
        __block iCarouselAbsItemView *tapedView = nil;
        [carousel.visibleItemViews enumerateObjectsUsingBlock:^(__kindof iCarouselAbsItemView *view, NSUInteger idx, BOOL * _Nonnull stop) {
            
            view.index == index ? (void)(tapedView = view), *stop = YES : 0;
        }];
        
        [self.delegate iCarouselView:self didSelectCarouselAbsItemView:tapedView adapter:_adapters[index]];
    }
}

@end
