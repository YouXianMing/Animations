//
//  IrregularPictureGridCell.m
//  Animations
//
//  Created by YouXianMing on 2016/11/11.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "IrregularPictureGridCell.h"
#import "UIView+SetRect.h"
#import "UIView+AnimationProperty.h"

@interface IrregularPictureGridCell ()

@property (nonatomic, strong) UIImageView *showImageView;

@end

@implementation IrregularPictureGridCell

- (void)setupCell {
    
    self.showImageView                     = [[UIImageView alloc] initWithFrame:self.bounds];
    self.showImageView.layer.cornerRadius  = 4.f;
    self.showImageView.layer.masksToBounds = YES;
    [self addSubview:self.showImageView];
}

- (void)loadContent {
    
    self.showImageView.width = self.dataAdapter.itemWidth;
    self.showImageView.image = self.data;
}

- (void)willDisplay {

    self.showImageView.alpha = 0.f;
    self.showImageView.scale = 0.975f;
    [UIView animateWithDuration:0.75f animations:^{
       
        self.showImageView.alpha = 1.f;
        self.showImageView.scale = 1.f;
    }];
}

- (void)didEndDisplay {

    [self.showImageView.layer removeAllAnimations];
}

@end
