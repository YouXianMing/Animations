//
//  CustomCollectionReusableView.h
//  AjMall
//
//  Created by YouXianMing on 2018/8/30.
//  Copyright © 2018年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionSectionData.h"
@class CustomCollectionReusableView;

@protocol CustomCollectionReusableViewDelegate <NSObject>

- (void)customCollectionReusableView:(CustomCollectionReusableView *)reusableView event:(id)event;

@end

@interface CustomCollectionReusableView : UICollectionReusableView

/**
 *  Delegate.
 */
@property (nonatomic, weak) id <CustomCollectionReusableViewDelegate> delegate;

/**
 *  SectionData.
 */
@property (nonatomic, strong) CollectionSectionData *sectionData;

/**
 *  IndexPath.
 */
@property (nonatomic, strong) NSIndexPath *indexPath;

#pragma mark - Method you should overwrite.

/**
 *  Setup cell, overwrite by subclass.
 */
- (void)setupReusableView;

/**
 *  Build subview, overwrite by subclass.
 */
- (void)buildSubview;

/**
 *  Load content, overwrite by subclass.
 */
- (void)loadContent;

/**
 *  The reference size.
 */
@property (class, nonatomic, readonly) CGSize referenceSize;

/**
 Get the referenceSize.

 @param data The data.
 @return The referenceSize.
 */
+ (CGSize)referenceSizeWithData:(id)data;

#pragma mark - Header related.

+ (CollectionSectionHeaderData *)headerDataWithReuseIdentifier:(NSString *)reuseIdentifier
                                                 referenceSize:(CGSize)referenceSize
                                                          data:(id)data
                                                          type:(NSInteger)type;

+ (CollectionSectionHeaderData *)headerDataWithReferenceSize:(CGSize)referenceSize
                                                        data:(id)data
                                                        type:(NSInteger)type;

#pragma mark - Footer related.

+ (CollectionSectionFooterData *)footerDataWithReuseIdentifier:(NSString *)reuseIdentifier
                                                 referenceSize:(CGSize)referenceSize
                                                          data:(id)data
                                                          type:(NSInteger)type;

+ (CollectionSectionFooterData *)footerDataWitReferenceSize:(CGSize)referenceSize
                                                       data:(id)data
                                                       type:(NSInteger)type;

#pragma mark - Regiter to CollectionView.

+ (void)headerRegisterToCollectionView:(UICollectionView *)collectionView reuseIdentifier:(NSString *)reuseIdentifier;
+ (void)headerRegisterToCollectionView:(UICollectionView *)collectionView;

+ (void)footerRegisterToCollectionView:(UICollectionView *)collectionView reuseIdentifier:(NSString *)reuseIdentifier;
+ (void)footerRegisterToCollectionView:(UICollectionView *)collectionView;

#pragma mark - Waterfall Related

+ (WaterfallCollectionSectionHeaderData *)waterfallHeaderDataWithReuseIdentifier:(NSString *)reuseIdentifier
                                                                            data:(id)data
                                                                   sectionInsets:(UIEdgeInsets)sectionInsets
                                                                   sectionHeight:(CGFloat)sectionHeight
                                                                            type:(NSInteger)type;

+ (WaterfallCollectionSectionFooterData *)waterfallfooterDataWithReuseIdentifier:(NSString *)reuseIdentifier
                                                                            data:(id)data
                                                                   sectionInsets:(UIEdgeInsets)sectionInsets
                                                                   sectionHeight:(CGFloat)sectionHeight
                                                                            type:(NSInteger)type;

+ (WaterfallCollectionSectionHeaderData *)waterfallHeaderDataWithData:(id)data sectionHeight:(CGFloat)sectionHeight;
+ (WaterfallCollectionSectionFooterData *)waterfallfooterDataWithData:(id)data sectionHeight:(CGFloat)sectionHeight;

+ (void)waterfallHeaderRegisterToCollectionView:(UICollectionView *)collectionView reuseIdentifier:(NSString *)reuseIdentifier;
+ (void)waterfallHeaderRegisterToCollectionView:(UICollectionView *)collectionView;

+ (void)waterfallFooterRegisterToCollectionView:(UICollectionView *)collectionView reuseIdentifier:(NSString *)reuseIdentifier;
+ (void)waterfallFooterRegisterToCollectionView:(UICollectionView *)collectionView;

@end
