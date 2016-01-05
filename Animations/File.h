//
//  File.h
//  FileManager
//
//  Created by YouXianMing on 15/11/19.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface File : NSObject

/**
 *  Type-A
 *  -------------------------------------
 *  'Hello world.mp3'
 *
 *  fileName           -- Hello world.mp3
 *  name               -- Hello world
 *  filenameExtension  -- mp3
 *
 *  Type-B
 *  -------------------------------------
 *  'configFile'
 *
 *  fileName           -- configFile
 *  name               -- configFile
 *  filenameExtension  -- nil
 */

/**
 *  Full file name.
 */
@property (nonatomic, strong) NSString  *fileName;

/**
 *  File name.
 */
@property (nonatomic, strong) NSString  *name;

/**
 *  File name extension.
 */
@property (nonatomic, strong) NSString  *filenameExtension;

/**
 *  Full file path.
 */
@property (nonatomic, strong) NSString  *filePath;

/**
 *  File url.
 */
@property (nonatomic, strong) NSURL     *fileUrl;

/**
 *  Is directory or not.
 */
@property (nonatomic) BOOL       isDirectory;

/**
 *  Is hiden file or not.
 */
@property (nonatomic) BOOL       isHiden;

/**
 *  File tree level.
 */
@property (nonatomic) NSInteger  level;

/**
 *  Attributes of the file.
 */
@property (nonatomic, strong) NSDictionary  *attributes;

/**
 *  Sub files.
 */
@property (nonatomic, strong) NSMutableArray  <File *>  *subFiles;

/**
 *  All sub files.
 *
 *  @return Sub files array.
 */
- (NSArray <File *> *)allFiles;

@end
