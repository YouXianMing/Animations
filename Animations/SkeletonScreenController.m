//
//  SkeletonScreenController.m
//  Animations
//
//  Created by YouXianMing on 2020/6/19.
//  Copyright © 2020 YouXianMing. All rights reserved.
//

#import "SkeletonScreenController.h"
#import "UIView+SetRect.h"
#import "DeviceInfo.h"
#import "HexColors.h"
#import "FBShimmeringViewCategoryHeaders.h"
#import "AttributedStringConfigHelper.h"
#import "ShimmeringView_1_Config.h"
#import "ShimmeringView_2_Config.h"
#import "UIView+AnimationProperty.h"

@interface SkeletonScreenController ()

@end

@implementation SkeletonScreenController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    static NSInteger count = 0;
    count++ % 2 ? [self skeletonScreen_1] : [self skeletonScreen_2];
}

- (void)skeletonScreen_1 {
    
    UIColor *color                = [[UIColor colorWithHexString:@"858585"] colorWithAlphaComponent:0.5f];
    UIView *shimmeringContentView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.contentView.width - 20, self.contentView.height - 20 - DeviceInfo.fringeScreenBottomSafeHeight)];
    
    CGFloat offsetY = 0.f;
    
    {
        UIView *view             = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, shimmeringContentView.width, 90)];
        view.backgroundColor     = color;
        view.layer.cornerRadius  = 5.f;
        view.layer.masksToBounds = YES;
        [shimmeringContentView addSubview:view];
        offsetY += view.height + 10.f;
    }
    
    {
        UIView *view         = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, shimmeringContentView.width, 20)];
        view.backgroundColor = color;
        [shimmeringContentView addSubview:view];
        offsetY += view.height + 10.f;
    }
    
    {
        UIView *view         = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, shimmeringContentView.width / 2.f - 5, 20)];
        view.backgroundColor = color;
        [shimmeringContentView addSubview:view];
    }
    
    {
        UIView *view         = [[UIView alloc] initWithFrame:CGRectMake(shimmeringContentView.width / 2.f + 5, offsetY, shimmeringContentView.width / 2.f - 5, 20)];
        view.backgroundColor = color;
        [shimmeringContentView addSubview:view];
        offsetY += view.height + 10.f;
    }
    
    {
        UIView *view         = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, shimmeringContentView.width, 20)];
        view.backgroundColor = color;
        [shimmeringContentView addSubview:view];
        offsetY += view.height + 10.f;
    }
    
    {
        UIView *view         = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, 80, 80)];
        view.backgroundColor = color;
        [shimmeringContentView addSubview:view];
    }
    
    {
        UIView *view         = [[UIView alloc] initWithFrame:CGRectMake(80 + 10, offsetY, shimmeringContentView.width - 90, 80)];
        view.backgroundColor = color;
        [shimmeringContentView addSubview:view];
        offsetY += view.height + 10.f;
    }
    
    {
        CGFloat itemWidth  = (shimmeringContentView.width - 10 * 2) / 3.f;
        CGFloat itemHeight = 120.f;
        
        {
            UIView *view             = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, itemWidth, itemHeight)];
            view.backgroundColor     = color;
            view.left                = 0.f;
            view.layer.cornerRadius  = 10.f;
            view.layer.masksToBounds = YES;
            [shimmeringContentView addSubview:view];
        }
        
        {
            UIView *view             = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, itemWidth, itemHeight)];
            view.backgroundColor     = color;
            view.centerX             = shimmeringContentView.middleX;
            view.layer.cornerRadius  = 10.f;
            view.layer.masksToBounds = YES;
            [shimmeringContentView addSubview:view];
        }
        
        {
            UIView *view             = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, itemWidth, itemHeight)];
            view.backgroundColor     = color;
            view.right               = shimmeringContentView.width;
            view.layer.cornerRadius  = 10.f;
            view.layer.masksToBounds = YES;
            [shimmeringContentView addSubview:view];
        }
        
        offsetY += itemHeight + 10.f;
    }
    
    {
        UIView *view             = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, shimmeringContentView.width, shimmeringContentView.height - offsetY)];
        view.backgroundColor     = color;
        view.layer.cornerRadius  = 10.f;
        view.layer.masksToBounds = YES;
        [shimmeringContentView addSubview:view];
    }
    
    [self.contentView addSubview:[[shimmeringContentView.addToFBShimmeringView useConfig:ShimmeringView_1_Config.new] startShimmering]];
}

- (void)skeletonScreen_2 {
    
    UIColor *color                = UIColor.blackColor;
    UIView *shimmeringContentView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.contentView.width - 20, self.contentView.height - 20 - DeviceInfo.fringeScreenBottomSafeHeight)];
    
    NSString        *name   = @"Animations      ";
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < 150; i++) {
        
        [string appendString:name];
    }
    
    UILabel *label       = [[UILabel alloc] init];
    label.width          = Width * 2;
    label.numberOfLines  = 0;
    label.attributedText = [NSMutableAttributedString mutableAttributedStringWithString:string config:^(NSString *string, NSMutableArray<AttributedStringConfig *> *configs) {
        
        NSMutableParagraphStyle *style = NSMutableParagraphStyle.new;
        style.lineSpacing              = 25.f;
        [configs addObject:[ParagraphAttributeConfig configWithParagraphStyle:style range:NSMakeRange(0, string.length)]];
        [configs addObject:[ForegroundColorAttributeConfig configWithColor:color range:NSMakeRange(0, string.length)]];
        [configs addObject:[FontAttributeConfig configWithFont:[UIFont systemFontOfSize:18 weight:UIFontWeightThin] range:NSMakeRange(0, string.length)]];
        
        NSInteger count = string.length / name.length;
        for (int i = 0; i < count; i++) {
            
            [configs addObject:[ForegroundColorAttributeConfig configWithColor:[UIColor colorWithRed:0.203 green:0.598 blue:0.859 alpha:1]
                                                                         range:NSMakeRange(i * name.length + 1, 1)]];
            
            [configs addObject:[FontAttributeConfig configWithFont:[UIFont systemFontOfSize:18 weight:UIFontWeightBold] range:NSMakeRange(i * name.length + 1, 1)]];
        }
    }];
    [label sizeToFit];
    label.angle = M_PI_4;
    
    UIView *labelContentView       = [[UIView alloc] initWithFrame:CGRectMake(0, 0, shimmeringContentView.width, shimmeringContentView.height)];
    labelContentView.clipsToBounds = YES;
    [labelContentView addSubview:label];
    label.center = labelContentView.middlePoint;
    
    [shimmeringContentView addSubview:labelContentView];
    [self.contentView addSubview:[[shimmeringContentView.addToFBShimmeringView useConfig:ShimmeringView_2_Config.new] startShimmering]];
}

@end
