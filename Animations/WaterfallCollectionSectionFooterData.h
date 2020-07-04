//
//  WaterfallCollectionSectionFooterData.h
//  AjMall
//
//  Created by YouXianMing on 2020/3/16.
//  Copyright © 2020 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WaterfallCollectionSectionFooterData : NSObject

@property (nonatomic) UIEdgeInsets sectionInsets;
@property (nonatomic) CGFloat      sectionHeight;

@property (nonatomic)         NSInteger type;
@property (nonatomic, strong) NSString *reuseIdentifier;
@property (nonatomic, strong) id        data;

@property (nonatomic, strong, readonly) NSString *elementKind;

@end
