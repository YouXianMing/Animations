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
#import "UIView+SetRect.h"
#import "UIView+AnimationProperty.h"
#import "UIImage+ImageEffects.h"
#import "GCD.h"

@interface PictureCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *blurIconImageView;

@end

@implementation PictureCell

- (void)setupCell {

    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor blackColor];
}

- (void)buildSubview {
    
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, Width)];
    [self addSubview:self.iconImageView];
    
    self.blurIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, Width)];
    [self addSubview:self.blurIconImageView];
}

- (void)loadContent {

    PictureModel       *model = self.dataAdapter.data;
    __weak PictureCell *wself = self;
    
    NSURL *blurImageURL = [NSURL URLWithString:[model.pictureUrlString stringByAppendingString:@"blur"]];
    
    [self.iconImageView sd_setImageWithURL:model.pictureUrl
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                     
                                     NSMutableString *logString = [NSMutableString string];
                                     [logString appendFormat:@"     [%ld][%ld] ", (long)wself.indexPath.section, (long)wself.indexPath.row];
                                     
                                     switch (cacheType) {
                                             
                                         case SDImageCacheTypeNone:
                                             [logString appendString:@"SDImageCacheTypeNone"];
                                             break;
                                             
                                         case SDImageCacheTypeDisk:
                                             [logString appendString:@"SDImageCacheTypeDisk"];
                                             break;
                                             
                                         case SDImageCacheTypeMemory:
                                             [logString appendString:@"SDImageCacheTypeMemory"];
                                             break;
                                             
                                         default:
                                             [logString appendString:@"Unknow"];
                                             break;
                                     }
                                     
                                     if (cacheType == SDImageCacheTypeNone || cacheType == SDImageCacheTypeDisk) {
                                         
                                         // Picture from downloading or disk.
                                         self.iconImageView.alpha = 0.f;
                                         [UIView animateWithDuration:0.15f animations:^{
                                             
                                             self.iconImageView.alpha = 1.f;
                                         }];
                                     }
                                     
                                     // Set blur image.
                                     if ([[SDWebImageManager sharedManager] cachedImageExistsForURL:blurImageURL] == NO &&
                                         [[SDWebImageManager sharedManager] diskImageExistsForURL:blurImageURL]   == NO) {
                                         
                                         [GCDQueue executeInGlobalQueue:^{
                                             
                                             UIImage *blurImage = [image blurImage];
                                             [[SDWebImageManager sharedManager] saveImageToCache:blurImage forURL:blurImageURL];
                                             
                                             [GCDQueue executeInMainQueue:^{
                                                 
                                                 [self blurImageShowWithURL:blurImageURL cell:wself];
                                             }];
                                         }];
                                         
                                     } else {
                                         
                                         [self blurImageShowWithURL:blurImageURL cell:wself];
                                     }
                                 }];
}

- (void)blurImageShowWithURL:(NSURL *)url cell:(PictureCell *)cell {
    
    [self.blurIconImageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        NSMutableString *logString = [NSMutableString string];
        [logString appendFormat:@"blur [%ld][%ld] ", (long)cell.indexPath.section, (long)cell.indexPath.row];
        
        switch (cacheType) {
                
            case SDImageCacheTypeNone:
                [logString appendString:@"SDImageCacheTypeNone"];
                break;
                
            case SDImageCacheTypeDisk:
                [logString appendString:@"SDImageCacheTypeDisk"];
                break;
                
            case SDImageCacheTypeMemory:
                [logString appendString:@"SDImageCacheTypeMemory"];
                break;
                
            default:
                [logString appendString:@"Unknow"];
                break;
        }
        
        if (cacheType == SDImageCacheTypeNone || cacheType == SDImageCacheTypeDisk) {
            
            // Picture from downloading or disk.
            self.blurIconImageView.alpha = 0.f;
        }
    }];
}

- (void)setDisplay:(BOOL)display {

    [super setDisplay:display];
    
    if (display) {
        
        [UIView animateWithDuration:1.f animations:^{
            
            self.blurIconImageView.alpha = 0.f;
        }];
        
    } else {
    
        [self.blurIconImageView.layer removeAllAnimations];
        self.blurIconImageView.alpha = 1.f;
        
        [self.iconImageView.layer removeAllAnimations];
    }
}

@end
