//
//  LoadUrlDataCell.m
//  Animations
//
//  Created by YouXianMing on 16/2/3.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "LoadUrlDataCell.h"
#import "UIImageView+WebCache.h"
#import "PictureModel.h"
#import "UIView+AnimationProperty.h"
#import "DataModel.h"
#import "UIView+SetRect.h"
#import "UIFont+Fonts.h"

@interface LoadUrlDataCell ()

@property (nonatomic, strong) UIImageView  *iconImageView;
@property (nonatomic, strong) UILabel      *infoLabel;
@property (nonatomic, strong) UIView       *lineView;

@end

@implementation LoadUrlDataCell

- (void)setupCell {

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {

    self.iconImageView             = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.iconImageView];
    
    self.infoLabel               = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, Width - 80, 20)];
    self.infoLabel.numberOfLines = 0;
    self.infoLabel.font          = [UIFont HeitiSCWithFontSize:14.f];
    [self addSubview:self.infoLabel];
    
    self.lineView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0.5f)];
    self.lineView.backgroundColor = [UIColor grayColor];
    self.lineView.alpha           = 0.1f;
    [self addSubview:self.lineView];
}

- (void)loadContent {
    
    DataModel *model = self.dataAdapter.data;
    
    self.infoLabel.text  = model.user.infomation.text;
    self.infoLabel.width = Width - 80;
    [self.infoLabel sizeToFit];
    
    self.lineView.y = self.dataAdapter.cellHeight - 0.5f;

    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:model.user.avatar_image.url] options:SDWebImageAvoidAutoSetImage
                         progress:nil
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            
                            if (image) {
                                
                                if (model.haveAnimated.boolValue == NO) {
                                    
                                    model.haveAnimated       = @(YES);
                                    self.iconImageView.alpha = 0.f;
                                    self.iconImageView.image = image;
                                    self.iconImageView.scale = 0.8f;
                                    
                                    [UIView animateWithDuration:0.5f animations:^{
                                        
                                        self.iconImageView.alpha = 1.f;
                                        self.iconImageView.scale = 1.f;
                                    }];
                                    
                                } else {
                                    
                                    self.iconImageView.image = image;
                                    self.iconImageView.scale = 1.f;
                                }
                            }
                        }];
}

@end
