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
#import "FBShimmeringView.h"
#import "UIFont+Fonts.h"
#import "UIView+SetRect.h"
#import "DuitangPicModel.h"

@interface iCarouselViewController () <iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, strong) iCarousel                          *carousel;   // iCarousel
@property (nonatomic, strong) NSMutableArray <DuitangPicModel *> *dataSource;

@end

@implementation iCarouselViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    // https://github.com/nicklockwood/iCarousel
    
    self.contentView.layer.masksToBounds = YES;
    self.backgroundView.backgroundColor  = [UIColor blackColor];
    
    self.carousel            = [[iCarousel alloc] initWithFrame:self.contentView.bounds];
    self.carousel.type       = iCarouselTypeWheel;
    self.carousel.delegate   = self;
    self.carousel.dataSource = self;
    [self.contentView addSubview:_carousel];
    
    // 数据源
    self.dataSource = [NSMutableArray array];
    NSArray *duitangPics = [[NSData dataWithContentsOfFile:[FileManager bundleFileWithName:@"duitang.json"]] toListProperty];
    [duitangPics enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.dataSource addObject:[[DuitangPicModel alloc] initWithDictionary:obj]];
    }];
    
    [self.carousel reloadData];
}

#pragma mark - iCarousel's delegate.

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    
    return self.dataSource.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    
    if (view == nil) {
        
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 250, 400)];
    }
    
    UIImageView *pointView = (UIImageView *)view;
    pointView.contentMode  = UIViewContentModeScaleAspectFit;
    
    DuitangPicModel *model = self.dataSource[index];
    
    [pointView sd_setImageWithURL:[NSURL URLWithString:model.img]
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

- (void)setupSubViews {
    
    [super setupSubViews];
    
    // Title label.
    UILabel *titleLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Width, 64.f)];
    titleLabel.font          = [UIFont HeitiSCWithFontSize:20.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor     = [UIColor redColor];
    titleLabel.text          = self.title;
    
    FBShimmeringView *shimmeringView           = [[FBShimmeringView alloc] initWithFrame:titleLabel.bounds];
    shimmeringView.shimmering                  = YES;
    shimmeringView.shimmeringBeginFadeDuration = 0.3;
    shimmeringView.shimmeringOpacity           = 0.1f;
    shimmeringView.shimmeringAnimationOpacity  = 1.f;
    shimmeringView.bottom                      = self.titleView.height;
    shimmeringView.contentView                 = titleLabel;
    [self.titleView addSubview:shimmeringView];
    
    // Line.
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleView.height - 0.5, self.view.width, 0.5f)];
    line.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [self.titleView addSubview:line];
    
    // Back button.
    UIImage  *image      = [UIImage imageNamed:@"backIconVer2"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    backButton.center    = CGPointMake(20, shimmeringView.centerY);
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    [backButton.imageView setContentMode:UIViewContentModeCenter];
    [self.titleView addSubview:backButton];
}


- (void)popSelf {
    
    [self popViewControllerAnimated:YES];
}

@end
