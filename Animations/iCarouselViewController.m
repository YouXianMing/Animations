//
//  iCarouselViewController.m
//  Animations
//
//  Created by YouXianMing on 16/5/1.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "iCarouselViewController.h"
#import "iCarousel.h"
#import "UIImageView+WebCache.h"
#import "GCD.h"
#import "NSString+MD5.h"
#import "FileManager.h"
#import "NSData+JSONData.h"
#import "ResponseData.h"
#import "FBShimmeringView.h"
#import "UIFont+Fonts.h"
#import "UIView+SetRect.h"

@interface iCarouselViewController () <iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, strong) iCarousel      *carousel;   // iCarousel
@property (nonatomic, strong) ResponseData   *picturesData;

@end

@implementation iCarouselViewController

- (void)setup {

    [super setup];
    
    // https://github.com/nicklockwood/iCarousel
    
    self.contentView.layer.masksToBounds = YES;
    self.backgroundView.backgroundColor  = [UIColor blackColor];
    
    self.carousel            = [[iCarousel alloc] initWithFrame:self.contentView.bounds];
    self.carousel.type       = iCarouselTypeWheel;
    self.carousel.delegate   = self;
    self.carousel.dataSource = self;
    [self.contentView addSubview:_carousel];
    
    // 获取数据
    [GCDQueue executeInGlobalQueue:^{
        
        NSString *picturesSource = @"http://www.duitang.com/album/1733789/masn/p/0/50/";
        NSString *string         = [picturesSource lowerMD532BitString];
        NSString *realFilePath   = [FileManager theRealFilePath:[NSString stringWithFormat:@"~/Documents/%@", string]];
        NSData   *data           = nil;
        
        if ([FileManager fileExistWithRealFilePath:realFilePath] == NO) {
            
            data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:picturesSource]];
            [data writeToFile:realFilePath atomically:YES];
            
        } else {
            
            data = [NSData dataWithContentsOfFile:realFilePath];
        }
        
        NSDictionary *dataDic = [data toListProperty];
        
        [GCDQueue executeInMainQueue:^{
            
            self.picturesData = [[ResponseData alloc] initWithDictionary:dataDic];
            
            [self.carousel reloadData];
            self.carousel.currentItemIndex = 12;
        }];
    }];
}

#pragma mark - iCarousel's delegate.

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    
    return self.picturesData.data.blogs.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    
    if (view == nil) {
        
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 250, 400)];
    }
    
    UIImageView *pointView = (UIImageView *)view;
    pointView.contentMode  = UIViewContentModeScaleAspectFit;
    
    WaterfallPictureModel *model = self.picturesData.data.blogs[index];
    
    [pointView sd_setImageWithURL:[NSURL URLWithString:model.isrc]
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            
                            pointView.image = image;
                        }];
    
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    
    if (option == iCarouselOptionSpacing) {
        
        return value * 1.1;
    }
    
    return value;
}

#pragma mark - Overwrite some method.

- (void)buildTitleView {
    
    [super buildTitleView];
    
    // Title label.
    UILabel *headlinelabel      = [UILabel new];
    headlinelabel.font          = [UIFont HeitiSCWithFontSize:20.f];
    headlinelabel.textAlignment = NSTextAlignmentCenter;
    headlinelabel.textColor     = [UIColor redColor];
    headlinelabel.text          = self.title;
    [headlinelabel sizeToFit];
    
    headlinelabel.center = self.titleView.middlePoint;
    
    FBShimmeringView *shimmeringView           = [[FBShimmeringView alloc] initWithFrame:self.titleView.bounds];
    shimmeringView.shimmering                  = YES;
    shimmeringView.shimmeringBeginFadeDuration = 0.3;
    shimmeringView.shimmeringOpacity           = 0.1f;
    shimmeringView.shimmeringAnimationOpacity  = 1.f;
    [self.titleView addSubview:shimmeringView];
    
    shimmeringView.contentView = headlinelabel;
    
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
