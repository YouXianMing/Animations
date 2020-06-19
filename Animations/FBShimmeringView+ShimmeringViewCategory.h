//
//  FBShimmeringView+ShimmeringViewCategory.h
//  AjMall
//
//  Created by YouXianMing on 2020/6/17.
//  Copyright © 2020 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBShimmeringView.h"
#import "BaseFBShimmeringViewConfig.h"

@interface FBShimmeringView (ShimmeringViewCategory)

- (FBShimmeringView *)useConfig:(BaseFBShimmeringViewConfig *)config;

- (FBShimmeringView *)startShimmering;

- (FBShimmeringView *)stopShimmering;

@end
