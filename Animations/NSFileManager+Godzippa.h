// NSFileManager+Godzippa.h
//
// Copyright (c) 2012–2015 Mattt Thompson (http://mattt.me/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>

#import <zlib.h>

/**
 Godzippa provides a category on `NSFileManager` to inflate and deflate files using gzip compression.
 */
@interface NSFileManager (Godzippa)

///------------------
/// @name Compressing
///------------------

/**
 Compresses the specified file, writing data to a destination file.

 @param sourceFile The file to be compressed.
 @param destinationFile The destination of the compressed file.
 @param error The error that occurred while attempting to compress the source file, if any.

 @return Whether the compressed file contents were written successfully.
 */
- (BOOL)GZipCompressFile:(NSURL *)sourceFile
   writingContentsToFile:(NSURL *)destinationFile
                   error:(NSError * __autoreleasing *)error;

/**
 Compresses the specified file at a particular level, writing data to a destination file.

 @param sourceFile The file to be compressed.
 @param destinationFile The destination of the compressed file.
 @param level The compression level must be Z_DEFAULT_COMPRESSION, or between 0 and 9: 1 gives best speed, 9 gives best compression, 0 gives no compression at all (the input data is simply copied a block at a time). Z_DEFAULT_COMPRESSION requests a default compromise between speed and compression (currently equivalent to level 6).
 @param error The error that occurred while attempting to compress the source file, if any.

 @return Whether the compressed file contents were written successfully.
 */
- (BOOL)GZipCompressFile:(NSURL *)sourceFile
   writingContentsToFile:(NSURL *)destinationFile
                 atLevel:(int)level
                   error:(NSError *__autoreleasing *)error;

///--------------------
/// @name Decompressing
///--------------------

/**
 Decompresses the specified Gzip-compressed file, writing data to a destination file.

 @param sourceFile The compressed file.
 @param destinationFile The destination for the decompressed file.
 */
- (BOOL)GZipDecompressFile:(NSURL *)sourceFile
     writingContentsToFile:(NSURL *)destinationFile
                     error:(NSError * __autoreleasing *)error;

@end
