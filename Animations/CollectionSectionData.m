//
//  CollectionSectionData.m
//  AjMall
//
//  Created by YouXianMing on 2018/8/30.
//  Copyright © 2018年 YouXianMing. All rights reserved.
//

#import "CollectionSectionData.h"

@implementation CollectionSectionData

- (instancetype)init {
    
    if (self = [super init]) {
    
        self.minimumInteritemSpacing = 0.f;
        self.minimumLineSpacing      = 0.f;
        self.sectionInsets           = UIEdgeInsetsMake(0, 0, 0, 0);
        self.headerData              = nil;
        self.adapters                = [NSMutableArray array];
        self.footerData              = nil;
        
        self.columnCountForSection = 1;
    }
    
    return self;
}

+ (CollectionSectionData *)findSectionDataFromSectionDatasArray:(NSArray <CollectionSectionData *> *)datasArray withMark:(NSString *)mark {
    
    __block CollectionSectionData *sectionData = nil;
    
    [datasArray enumerateObjectsUsingBlock:^(CollectionSectionData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ([obj.mark isEqualToString:mark]) {
            
            sectionData = obj;
            *stop       = YES;
        }
    }];
    
    return sectionData;
}

@end
