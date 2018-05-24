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
 *  @param relativeFilePath Relative file path, "~" means sandbox root, "-" means bundle file root.
 *  @param maxTreeLevel     Scan level.
 *
 *  @return File.
 */
+ (File *)scanRelativeFilePath:(NSString *)relativeFilePath maxTreeLevel:(NSInteger)maxTreeLevel;

/**
 *  Transform related file path to real file path.
 *
 *  @param relativeFilePath Relative file path, "~" means sandbox root, "-" means bundle file root.
 *
 *  @return The real file path.
 */
+ (NSString *)absoluteFilePathFromRelativeFilePath:(NSString *)relativeFilePath;

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
 *  @param absoluteFilePath The real file path.
 *
 *  @return Exist or not.
 */
+ (BOOL)fileExistWithAbsoluteFilePath:(NSString *)absoluteFilePath;

@end

/**
 *  Transform related file path to real file path.
 *
 *  @param relativeFilePath Relative file path, "~" means sandbox root, "-" means bundle file root.
 *
 *  @return The real file path.
 */
NS_INLINE NSString *absoluteFilePathFrom(NSString * relativeFilePath) {
    
    return [FileManager absoluteFilePathFromRelativeFilePath:relativeFilePath];
}


