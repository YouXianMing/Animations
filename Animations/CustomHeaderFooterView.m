//
//  CustomHeaderFooterView.m
//  Animations
//
//  Created by YouXianMing on 15/11/30.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "CustomHeaderFooterView.h"

@implementation CustomHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self setupHeaderFooterView];
        
        [self buildSubview];
    }
    
    return self;
}

- (void)setupHeaderFooterView {
    
}

- (void)buildSubview {

}

- (void)loadContent {

}

@end
