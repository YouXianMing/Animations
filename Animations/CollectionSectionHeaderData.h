//
//  CollectionSectionHeaderData.h
//  AjMall
//
//  Created by YouXianMing on 2018/8/30.
//  Copyright © 2018年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionSectionHeaderData : NSObject

@property (nonatomic)         NSInteger type;
@property (nonatomic)         CGSize    referenceSize;
@property (nonatomic, strong) NSString *reuseIdentifier;
@property (nonatomic, strong) id        data;

@property (nonatomic, strong, readonly) NSString *elementKind;

@end
