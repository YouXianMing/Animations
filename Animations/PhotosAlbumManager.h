//
//  PhotosAlbumManager.h
//  SaveImage
//
//  Created by YouXianMing on 16/7/13.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

/**
 *  PhotosAlbumManager did finish saving block.
 *
 *  @param image       The saved image.
 *  @param error       NSError.
 *  @param contextInfo An optional pointer to any context-specific data that you want passed to the completion selector.
 */
typedef void(^PhotosAlbumManagerDidFinishSavingBlock)(UIImage *image, NSError *error, void *contextInfo);

@interface PhotosAlbumManager : NSObject

/**
 *  The shared instance.
 *
 *  @return PhotosAlbumManager's shared instance.
 */
+ (PhotosAlbumManager *)manager;

/**
 *  Save image and get the saved result.
 *
 *  @param image The image you want to saved.
 *  @param block PhotosAlbumManager saving result block.
 */
- (void)saveImage:(UIImage *)image didFinishSavingBlock:(PhotosAlbumManagerDidFinishSavingBlock)block;

/**
 *  Requests the user’s permission, if needed, for accessing the Photos library.
 *
 *  @param handler A block Photos calls upon determining your app’s authorization to access the photo library.
 */
+ (void)requestAuthorization:(void(^)(PHAuthorizationStatus status))handler;

@end
