//
//  PictureCell.m
//  SDWebImageLoadImageAnimation
//
//  Created by YouXianMing on 15/4/30.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "PictureCell.h"
#import "UIImageView+WebCache.h"
#import "PictureModel.h"
#import "UIView+AnimationProperty.h"

@interface PictureCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation PictureCell

- (void)setupCell {

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {

    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self addSubview:self.iconImageView];
}

- (void)loadContent {

    // 图片模型
    PictureModel *model = self.data;
    
    // 进行图片下载
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    // 加载图片(动画逻辑)
    [manager downloadImageWithURL:model.pictureUrl options:0 progress:nil
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            
                            if (image) {
                                
                                // 如果没有执行过动画
                                if (model.haveAnimated.boolValue == NO) {
                                    
                                    // 将动画设置成已经执行了
                                    model.haveAnimated = @(YES);
                                    
                                    self.iconImageView.alpha = 0.f;
                                    self.iconImageView.image = image;
                                    self.iconImageView.scale = 0.8f;
                                    
                                    // 执行动画
                                    [UIView animateWithDuration:0.5f animations:^{
                                        
                                        self.iconImageView.alpha = 1.f;
                                        self.iconImageView.scale = 1.f;
                                    }];
                                    
                                } else {
                                    
                                    // 直接设置
                                    self.iconImageView.image = image;
                                    self.iconImageView.scale = 1.f;
                                }
                            }
                        }];
}

@end
