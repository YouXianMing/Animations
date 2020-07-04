//
//  CustomCollectionReusableView.m
//  AjMall
//
//  Created by YouXianMing on 2018/8/30.
//  Copyright © 2018年 YouXianMing. All rights reserved.
//

#import "CustomCollectionReusableView.h"
#import "CHTCollectionViewWaterfallLayout.h"

@implementation CustomCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupReusableView];
        [self buildSubview];
    }
    
    return self;
}

- (void)setupReusableView {
    
}

- (void)buildSubview {
    
}

- (void)loadContent {
    
}

+ (CGSize)referenceSize {
    
    return CGSizeZero;
}

+ (CGSize)referenceSizeWithData:(id)data {
    
    return CGSizeZero;
}

+ (CollectionSectionHeaderData *)headerDataWithReuseIdentifier:(NSString *)reuseIdentifier
                                                 referenceSize:(CGSize)referenceSize
                                                          data:(id)data
                                                          type:(NSInteger)type {
    
    CollectionSectionHeaderData *sectionData = [CollectionSectionHeaderData new];
    sectionData.reuseIdentifier              = reuseIdentifier;
    sectionData.referenceSize                = referenceSize;
    sectionData.data                         = data;
    sectionData.type                         = type;
    
    return sectionData;
}

+ (CollectionSectionHeaderData *)headerDataWithReferenceSize:(CGSize)referenceSize
                                                        data:(id)data
                                                        type:(NSInteger)type {
    
    CollectionSectionHeaderData *sectionData = [CollectionSectionHeaderData new];
    sectionData.reuseIdentifier              = NSStringFromClass(self.class);
    sectionData.referenceSize                = referenceSize;
    sectionData.data                         = data;
    sectionData.type                         = type;
    
    return sectionData;
}

+ (CollectionSectionFooterData *)footerDataWithReuseIdentifier:(NSString *)reuseIdentifier
                                                 referenceSize:(CGSize)referenceSize
                                                          data:(id)data
                                                          type:(NSInteger)type {
    
    CollectionSectionFooterData *sectionData = [CollectionSectionFooterData new];
    sectionData.reuseIdentifier              = reuseIdentifier;
    sectionData.referenceSize                = referenceSize;
    sectionData.data                         = data;
    sectionData.type                         = type;
    
    return sectionData;
}

+ (CollectionSectionFooterData *)footerDataWitReferenceSize:(CGSize)referenceSize
                                                       data:(id)data
                                                       type:(NSInteger)type {
    
    CollectionSectionFooterData *sectionData = [CollectionSectionFooterData new];
    sectionData.reuseIdentifier              = NSStringFromClass(self.class);
    sectionData.referenceSize                = referenceSize;
    sectionData.data                         = data;
    sectionData.type                         = type;
    
    return sectionData;
}

+ (WaterfallCollectionSectionHeaderData *)waterfallHeaderDataWithReuseIdentifier:(NSString *)reuseIdentifier
                                                                            data:(id)data
                                                                   sectionInsets:(UIEdgeInsets)sectionInsets
                                                                   sectionHeight:(CGFloat)sectionHeight
                                                                            type:(NSInteger)type {
    
    WaterfallCollectionSectionHeaderData *sectionData = [WaterfallCollectionSectionHeaderData new];
    sectionData.reuseIdentifier                       = reuseIdentifier.length ? reuseIdentifier : NSStringFromClass([self class]);
    sectionData.sectionInsets                         = sectionInsets;
    sectionData.sectionHeight                         = sectionHeight;
    sectionData.data                                  = data;
    sectionData.type                                  = type;
    
    return sectionData;
}

+ (WaterfallCollectionSectionHeaderData *)waterfallHeaderDataWithData:(id)data sectionHeight:(CGFloat)sectionHeight {
    
    WaterfallCollectionSectionHeaderData *sectionData = [WaterfallCollectionSectionHeaderData new];
    sectionData.reuseIdentifier                       = NSStringFromClass([self class]);
    sectionData.sectionHeight                         = sectionHeight;
    sectionData.data                                  = data;
    
    return sectionData;
}

+ (WaterfallCollectionSectionFooterData *)waterfallfooterDataWithReuseIdentifier:(NSString *)reuseIdentifier
                                                                            data:(id)data
                                                                   sectionInsets:(UIEdgeInsets)sectionInsets
                                                                   sectionHeight:(CGFloat)sectionHeight
                                                                            type:(NSInteger)type {
    
    WaterfallCollectionSectionFooterData *sectionData = [WaterfallCollectionSectionFooterData new];
    sectionData.reuseIdentifier                       = reuseIdentifier.length ? reuseIdentifier : NSStringFromClass([self class]);
    sectionData.sectionInsets                         = sectionInsets;
    sectionData.sectionHeight                         = sectionHeight;
    sectionData.data                                  = data;
    sectionData.type                                  = type;
    
    return sectionData;
}

+ (WaterfallCollectionSectionFooterData *)waterfallfooterDataWithData:(id)data sectionHeight:(CGFloat)sectionHeight {
    
    WaterfallCollectionSectionFooterData *sectionData = [WaterfallCollectionSectionFooterData new];
    sectionData.reuseIdentifier                       =  NSStringFromClass([self class]);
    sectionData.sectionHeight                         = sectionHeight;
    sectionData.data                                  = data;
    
    return sectionData;
}

+ (void)headerRegisterToCollectionView:(UICollectionView *)collectionView reuseIdentifier:(NSString *)reuseIdentifier {
    
    [collectionView registerClass:self.class
       forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
              withReuseIdentifier:reuseIdentifier.length <= 0 ? NSStringFromClass(self.class) : reuseIdentifier];
}

+ (void)headerRegisterToCollectionView:(UICollectionView *)collectionView {
    
    [collectionView registerClass:self.class
       forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
              withReuseIdentifier:NSStringFromClass(self.class)];
}

+ (void)footerRegisterToCollectionView:(UICollectionView *)collectionView reuseIdentifier:(NSString *)reuseIdentifier {
    
    [collectionView registerClass:self.class
       forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
              withReuseIdentifier:reuseIdentifier.length <= 0 ? NSStringFromClass(self.class) : reuseIdentifier];
}

+ (void)footerRegisterToCollectionView:(UICollectionView *)collectionView {
    
    [collectionView registerClass:self.class
       forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
              withReuseIdentifier:NSStringFromClass(self.class)];
}

#pragma mark - Waterfall Related

+ (void)waterfallHeaderRegisterToCollectionView:(UICollectionView *)collectionView reuseIdentifier:(NSString *)reuseIdentifier {
    
    [collectionView registerClass:self.class
       forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
              withReuseIdentifier:reuseIdentifier.length <= 0 ? NSStringFromClass(self.class) : reuseIdentifier];
}

+ (void)waterfallHeaderRegisterToCollectionView:(UICollectionView *)collectionView {
    
    [collectionView registerClass:self.class
       forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
              withReuseIdentifier:NSStringFromClass(self.class)];
}

+ (void)waterfallFooterRegisterToCollectionView:(UICollectionView *)collectionView reuseIdentifier:(NSString *)reuseIdentifier {
    
    [collectionView registerClass:self.class
       forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
              withReuseIdentifier:reuseIdentifier.length <= 0 ? NSStringFromClass(self.class) : reuseIdentifier];
}

+ (void)waterfallFooterRegisterToCollectionView:(UICollectionView *)collectionView {
    
    [collectionView registerClass:self.class
       forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
              withReuseIdentifier:NSStringFromClass(self.class)];
}

@end
