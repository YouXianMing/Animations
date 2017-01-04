//
//  LinearCarouselView.m
//  iCarouselExample
//
//  Created by YouXianMing on 2016/12/28.
//  Copyright © 2016年 TechCode. All rights reserved.
//

#import "LinearCarouselView.h"
#import "LinearCarouseItemView.h"

@implementation LinearCarouselView

- (void)configTheiCarousel:(iCarousel *)iCarousel {
    
    iCarousel.type           = iCarouselTypeLinear;
    iCarousel.bounces        = NO;
    iCarousel.scrollEnabled  = YES;
}

- (__kindof iCarouselAbsItemView *)viewForItemAtIndex:(NSInteger)index adapter:(iCarouselAdapter *)adapter reusingView:(__kindof iCarouselAbsItemView *)view {
    
    if (view == nil) {
        
        view = [[LinearCarouseItemView alloc] initWithFrame:CGRectMake(0, 0, [LinearCarouseItemView itemWidth], self.frame.size.height)];
    }
    
    view.adpter = adapter;
    view.data   = adapter.data;
    view.index  = index;
    [view loadContent];
    
    return view;
}

- (CGFloat)valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    
    switch (option) {
            
        case iCarouselOptionWrap:
            value = YES;
            break;
            
        case iCarouselOptionSpacing:
            value = value * 1.08f;
            break;
            
        default:
            break;
    }
    
    return value;
}

- (void)reloadData {

    [super reloadData];
    
    [self carouselDidScroll:self.carousel];
}

- (void)carouselDidScroll:(iCarousel *)carousel {
    
    [carousel.visibleItemViews enumerateObjectsUsingBlock:^(iCarouselAbsItemView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGRect rect = [obj convertRect:obj.bounds fromView:carousel];
        [obj offsetX:rect.origin.x];
    }];
}

- (void)setAdapters:(NSArray<iCarouselAdapter *> *)adapters {
    
    if (adapters.count >= 1 && adapters.count <= 2) {
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (int i = 0; i < 3; i++) {
            
            [adapters enumerateObjectsUsingBlock:^(iCarouselAdapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [array addObject:obj];
            }];
        }
        
        [super setAdapters:array];
        
    } else {
        
        [super setAdapters:adapters];
    }
}

@end
