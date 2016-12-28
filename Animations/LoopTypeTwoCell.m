//
//  LoopTypeTwoCell.m
//  Animations
//
//  Created by YouXianMing on 16/5/6.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "LoopTypeTwoCell.h"
#import "UIView+SetRect.h"
#import "UIImageView+WebCache.h"
#import "InfiniteLoopModel.h"
#import "PlaceholderImageView.h"
#import "UIFont+Fonts.h"

@interface LoopTypeTwoCell ()

@property (nonatomic, strong) PlaceholderImageView *imageView;
@property (nonatomic, strong) UILabel              *label;

@end

@implementation LoopTypeTwoCell

- (void)setupCollectionViewCell {
    
    self.layer.masksToBounds = YES;
}

- (void)buildSubView {
    
    self.imageView                     = [[PlaceholderImageView alloc] initWithFrame:self.bounds];
    self.imageView.layer.masksToBounds = YES;
    self.imageView.contentMode         = UIViewContentModeScaleAspectFill;
    [self addSubview:self.imageView];
    
    self.label           = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 0, 0)];
    self.label.font      = [UIFont fontWithName:@"GillSans-Italic" size:12.f];
    self.label.textColor = [UIColor redColor];
    [self addSubview:self.label];
}

- (void)loadContent {
    
    InfiniteLoopModel *model = (id)self.dataModel;
    self.label.text          = model.title;
    [self.label sizeToFit];
    
    self.imageView.urlString = [self.dataModel imageUrlString];
}

- (void)contentOffset:(CGPoint)offset {
    
    self.imageView.y = offset.y * 0.85f;
}

- (void)willDisplay {

    self.label.alpha = 0.f;
    [UIView animateWithDuration:1.f delay:0.5f options:0 animations:^{
        
        self.label.x     = 10;
        self.label.alpha = 1;
        
    } completion:nil];
}

- (void)didEndDisplay {

    [self.label.layer removeAllAnimations];
    self.label.x = 0;
    self.label.y = 10;
}

@end
