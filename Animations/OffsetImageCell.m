//
//  OffsetImageCell.m
//  Animations
//
//  Created by YouXianMing on 16/4/30.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "OffsetImageCell.h"
#import "UIView+SetRect.h"
#import "WanDouJiaModel.h"
#import "UIImageView+WebCache.h"
#import "LineBackgroundView.h"
#import "UIFont+Fonts.h"

@interface OffsetImageCell ()

@property (nonatomic, strong) UIImageView *pictureView;
@property (nonatomic, strong) UILabel     *infoLabel;

@end

@implementation OffsetImageCell

- (void)setupCell {
    
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor blackColor];
}

- (void)buildSubview {
    
    self.clipsToBounds           = YES;
    self.pictureView             = [[UIImageView alloc]initWithFrame:CGRectMake(0, -(Height / 1.7 - 250) / 2, Width, Height / 1.7)];
    self.pictureView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.pictureView];
    
    UIView *blackView         = [[UIView alloc] initWithFrame:CGRectMake(0, 250 - 30, Width, 30)];
    blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    [self addSubview:blackView];
    
    LineBackgroundView *lineBackgroundView = [LineBackgroundView createViewWithFrame:blackView.frame
                                                                           lineWidth:4 lineGap:4
                                                                           lineColor:[[UIColor blackColor] colorWithAlphaComponent:0.1f]];
    [self addSubview:lineBackgroundView];
    
    {
        UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0.5f)];
        lineView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5f];
        lineView.bottom          = lineBackgroundView.top;
        [self addSubview:lineView];
    }

    {
        UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0.5f)];
        lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        lineView.bottom          = lineBackgroundView.bottom;
        [self addSubview:lineView];
    }
    
    self.infoLabel               = [[UILabel alloc] initWithFrame:lineBackgroundView.frame];
    self.infoLabel.width        -= 10;
    self.infoLabel.textColor     = [UIColor whiteColor];
    self.infoLabel.textAlignment = NSTextAlignmentRight;
    self.infoLabel.font = [UIFont HeitiSCWithFontSize:13.f];
    [self addSubview:self.infoLabel];
}

- (void)loadContent {
    
    VideoListModel         *model = self.data;
    __weak OffsetImageCell *wself = self;
    
    self.infoLabel.text = model.title;
    
    [_pictureView sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail]
                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                               
                               if (cacheType == SDImageCacheTypeNone) {
                                   
                                   NSLog(@"[%ld][%ld] SDImageCacheTypeNone", (long)wself.indexPath.section, (long)wself.indexPath.row);
                                   
                               } else if (cacheType == SDImageCacheTypeDisk) {
                                   
                                   NSLog(@"[%ld][%ld] SDImageCacheTypeDisk", (long)wself.indexPath.section, (long)wself.indexPath.row);
                                   
                               } else if (cacheType == SDImageCacheTypeMemory) {
                                   
                                   NSLog(@"[%ld][%ld] SDImageCacheTypeMemory", (long)wself.indexPath.section, (long)wself.indexPath.row);
                                   
                               } else {
                                   
                                   NSLog(@"[%ld][%ld] Unknow", (long)wself.indexPath.section, (long)wself.indexPath.row);
                               }
                               
                               wself.pictureView.alpha = 0;
                               wself.pictureView.image = image;
                               
                               [UIView animateWithDuration:0.35f animations:^{
                                   
                                   wself.pictureView.alpha = 1.f;
                               }];
                           }];
}

- (void)cancelAnimation {
    
    [self.pictureView.layer removeAllAnimations];
}

- (CGFloat)cellOffset {
    
    CGRect  centerToWindow = [self convertRect:self.bounds toView:self.window];
    CGFloat centerY        = CGRectGetMidY(centerToWindow);
    CGPoint windowCenter   = self.superview.center;
    
    CGFloat cellOffsetY = centerY - windowCenter.y;
    
    CGFloat offsetDig =  cellOffsetY / self.superview.frame.size.height * 2;
    CGFloat offset    =  -offsetDig * (Height / 1.7 - 250) / 2;
    
    CGAffineTransform transY   = CGAffineTransformMakeTranslation(0, offset);
    self.pictureView.transform = transY;
    
    return offset;
}

@end
