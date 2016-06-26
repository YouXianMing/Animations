//
//  TapPathDrawViewController.m
//  Animations
//
//  Created by YouXianMing on 16/6/26.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "TapPathDrawViewController.h"
#import "TapDrawImageView.h"
#import "UIView+SetRect.h"
#import "Math.h"

@interface TapPathDrawViewController () <TapDrawImageViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIView       *theContentView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic)         CGSize        imageSize;

@end

@implementation TapPathDrawViewController

- (void)setup {
    
    [super setup];
    
    self.theContentView                            = [self createContentView];
    self.scrollView                                = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
    self.scrollView.minimumZoomScale               = Width / self.imageSize.width;
    self.scrollView.maximumZoomScale               = [Math resetFromSize:self.imageSize withFixedHeight:Height].width / self.imageSize.width;
    self.scrollView.delegate                       = self;
    self.scrollView.contentSize                    = self.contentView.frame.size;
    self.scrollView.zoomScale                      = Width / self.imageSize.width;
    self.scrollView.showsVerticalScrollIndicator   = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.scrollView addSubview:self.theContentView];
    [self.contentView addSubview:self.scrollView];
}

- (TapDrawPathManager *)createWithType:(NSString *)type bezierPath:(UIBezierPath *)path {
    
    TapDrawPathManager *manager = [[TapDrawPathManager alloc] init];
    manager.path                = path;
    manager.currentDrawType     = type;
    
    {
        TapDrawObject *tapDraw = [TapDrawObject new];
        tapDraw.fillColor      = [[UIColor redColor]   colorWithAlphaComponent:0.5f];
        tapDraw.strokeColor    = [[UIColor blackColor] colorWithAlphaComponent:0.25f];
        tapDraw.lineWidth      = 1.f;
        [manager.colorsType setObject:tapDraw forKey:tapDrawImageViewNormalState];
    }
    
    {
        TapDrawObject *tapDraw = [TapDrawObject new];
        tapDraw.fillColor      = [[UIColor redColor]   colorWithAlphaComponent:0.1f];
        tapDraw.strokeColor    = [[UIColor blackColor] colorWithAlphaComponent:0.25f];
        tapDraw.lineWidth      = 1.f;
        [manager.colorsType setObject:tapDraw forKey:tapDrawImageViewHighlightState];
    }
    
    {
        TapDrawObject *tapDraw = [TapDrawObject new];
        tapDraw.fillColor      = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
        tapDraw.strokeColor    = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
        tapDraw.lineWidth      = 1.f;
        [manager.colorsType setObject:tapDraw forKey:tapDrawImageDisableState];
    }
    
    return manager;
}

- (UIView *)createContentView {
    
    UIImage     *image       = [UIImage imageNamed:@"hourceBG"];
    UIImageView *imageView   = [[UIImageView alloc] initWithImage:image];
    UIView      *contentView = [[UIView alloc] initWithFrame:imageView.bounds];
    self.imageSize           = contentView.frame.size;
    [contentView addSubview:imageView];
    
    TapDrawImageView *tapImageView = [[TapDrawImageView alloc] initWithFrame:imageView.bounds];
    tapImageView.delegate          = self;
    
    {
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(261, 54)];
        [bezierPath addLineToPoint: CGPointMake(384, 54)];
        [bezierPath addLineToPoint: CGPointMake(384, 104)];
        [bezierPath addLineToPoint: CGPointMake(428, 104)];
        [bezierPath addLineToPoint: CGPointMake(428, 288)];
        [bezierPath addLineToPoint: CGPointMake(308, 288)];
        [bezierPath addLineToPoint: CGPointMake(308, 138)];
        [bezierPath addLineToPoint: CGPointMake(164, 138)];
        [bezierPath addLineToPoint: CGPointMake(164, 116)];
        [bezierPath addLineToPoint: CGPointMake(261, 116)];
        [bezierPath addLineToPoint: CGPointMake(261, 54)];
        [bezierPath closePath];
        
        [tapImageView.pathManagers addObject:[self createWithType:tapDrawImageViewNormalState bezierPath:bezierPath]];
    }
    
    {
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(210.5, 299.5)];
        [bezierPath addLineToPoint: CGPointMake(210.5, 435.5)];
        [bezierPath addLineToPoint: CGPointMake(300.5, 435.5)];
        [bezierPath addLineToPoint: CGPointMake(300.5, 464.5)];
        [bezierPath addLineToPoint: CGPointMake(406.5, 464.5)];
        [bezierPath addLineToPoint: CGPointMake(406.5, 425.5)];
        [bezierPath addLineToPoint: CGPointMake(394.5, 425.5)];
        [bezierPath addLineToPoint: CGPointMake(394.5, 299.5)];
        [bezierPath addLineToPoint: CGPointMake(210.5, 299.5)];
        [bezierPath closePath];
        
        [tapImageView.pathManagers addObject:[self createWithType:tapDrawImageViewNormalState bezierPath:bezierPath]];
    }
    
    {
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(181.5, 536.5)];
        [bezierPath addLineToPoint: CGPointMake(335.5, 536.5)];
        [bezierPath addLineToPoint: CGPointMake(335.5, 687.5)];
        [bezierPath addLineToPoint: CGPointMake(170.5, 687.5)];
        [bezierPath addLineToPoint: CGPointMake(170.5, 633.5)];
        [bezierPath addLineToPoint: CGPointMake(149.5, 633.5)];
        [bezierPath addLineToPoint: CGPointMake(149.5, 567.5)];
        [bezierPath addLineToPoint: CGPointMake(160.5, 543.5)];
        [bezierPath addLineToPoint: CGPointMake(181.5, 536.5)];
        [bezierPath closePath];
        
        [tapImageView.pathManagers addObject:[self createWithType:tapDrawImageViewNormalState bezierPath:bezierPath]];
    }
    
    [tapImageView setNeedsDisplay];
    [contentView addSubview:tapImageView];
    
    return contentView;
}


- (void)tapDrawImageView:(TapDrawImageView *)tapImageView selectedPathManager:(TapDrawPathManager *)pathManager {
    
    NSLog(@"点击了:%@", pathManager);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return _theContentView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGFloat offsetX = MAX((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0);
    CGFloat offsetY = MAX((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0);
    
    _theContentView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                         scrollView.contentSize.height * 0.5 + offsetY);
}

@end
