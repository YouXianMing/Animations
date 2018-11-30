//
//  DeepLinkModel.h
//  DeepLink
//
//  Created by YouXianMing on 2018/11/30.
//  Copyright © 2018 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
 ajmall://app/home?pager=item_detail&target_id=484515418854260736&source_scene=home_store&source_param=9
 
 scheme    : ajmall
 host      : ajmall://app/home
 paramsStr : pager=item_detail&target_id=484515418854260736&source_scene=home_store&source_param=9
 params    : @{@"pager"        : @"item_detail",
               @"target_id"    : @"484515418854260736",
               @"source_scene" : @"home_store",
               @"source_param" : @"9"};
 }
 
 */

@interface DeepLinkModel : NSObject

@property (nonatomic, readonly) NSString     *scheme;
@property (nonatomic, readonly) NSString     *host;
@property (nonatomic, readonly) NSString     *paramsStr;
@property (nonatomic, readonly) NSDictionary *params; // paramsStr转化过来的

+ (instancetype)deepLinkModelWithURLStr:(NSString *)urlString;

+ (instancetype)deepLinkModelWithURL:(NSURL *)url;

@end

