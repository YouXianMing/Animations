//
//  FileManager.h
//  FileManager
//
//  Created by YouXianMing on 15/12/5.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "File.h"

@interface FileManager : NSObject

/**
 *  Get the file at the related file path.
 *
 *  @param relatedFilePath Related file path, "~" means sandbox root, "-" means bundle file root.
 *  @param maxTreeLevel    Scan level.
 *
 *  @return File.
 */
+ (File *)scanRelatedFilePath:(NSString *)relatedFilePath
                 maxTreeLevel:(NSInteger)maxTreeLevel;

/**
 *  Transform related file path to real file path.
 *
 *  @param relatedFilePath Related file path, "~" means sandbox root, "-" means bundle file root.
 *
 *  @return The real file path.
 */
+ (NSString *)theRealFilePath:(NSString *)relatedFilePath;

/**
 *  Get the bundle file path by the bundle file name.
 *
 *  @param name Bundle file name.
 *
 *  @return Bundle file path.
 */
+ (NSString *)bundleFileWithName:(NSString *)name;

/**
 *  To check the file at the given file path exist or not.
 *
 *  @param theRealFilePath The real file path.
 *
 *  @return Exist or not.
 */
+ (BOOL)fileExistWithRealFilePath:(NSString *)theRealFilePath;

@end

/**
 *  Transform related file path to real file path.
 *
 *  @param relatedFilePath Related file path, "~" means sandbox root, "-" means bundle file root.
 *
 *  @return The real file path.
 */
NS_INLINE NSString *filePath(NSString * relatedFilePath) {
    
    return [FileManager theRealFilePath:relatedFilePath];
}

/**
 *  To check the file at the given file path exist or not.
 *
 *  @param theRealFilePath The real file path.
 *
 *  @return Exist or not.
 */
NS_INLINE BOOL fileExistWithRealFilePath(NSString * theRealFilePath) {
    
    return [FileManager fileExistWithRealFilePath:theRealFilePath];
}

