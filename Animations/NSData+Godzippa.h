// NSData+Godzippa.h
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
 Godzippa provides a category on `NSData` to inflate and deflate data using gzip compression.
 */
@interface NSData (Godzippa)

///------------------
/// @name Compressing
///------------------

/**
 Returns the deflated of the receiver using gzip compression.

 @param error The error that occurred while attempting to deflate the receiver.

 @return The compressed data.
 */
- (NSData *)dataByGZipCompressingWithError:(NSError * __autoreleasing *)error;

/**
 Returns the deflated of the receiver using gzip compression with the specified zlib values for compression level, window size, internal memory allocation, and strategy.

 @param level The compression level must be Z_DEFAULT_COMPRESSION, or between 0 and 9: 1 gives best speed, 9 gives best compression, 0 gives no compression at all (the input data is simply copied a block at a time). Z_DEFAULT_COMPRESSION requests a default compromise between speed and compression (currently equivalent to level 6).
 @param windowBits The base two logarithm of the window size (the size of the history buffer). Larger values of this parameter result in better compression at the expense of memory usage.
 @param memLevel Specifies how much memory should be allocated for the internal compression state. memLevel=1 uses minimum memory but is slow and reduces compression ratio; memLevel=9 uses maximum memory for optimal speed. The default value is 8. See zconf.h for total memory usage as a function of windowBits and memLevel.
 @param strategy Used to tune the compression algorithm. Use the value Z_DEFAULT_STRATEGY for normal data, Z_FILTERED for data produced by a filter (or predictor), Z_HUFFMAN_ONLY to force Huffman encoding only (no string match), or Z_RLE to limit match distances to one (run-length encoding). Filtered data consists mostly of small values with a somewhat random distribution. In this case, the compression algorithm is tuned to compress them better. The effect of Z_FILTERED is to force more Huffman coding and less string matching; it is somewhat intermediate between Z_DEFAULT_STRATEGY and Z_HUFFMAN_ONLY. Z_RLE is designed to be almost as fast as Z_HUFFMAN_ONLY, but give better compression for PNG image data. The strategy parameter only affects the compression ratio but not the correctness of the compressed output even if it is not set appropriately. Z_FIXED prevents the use of dynamic Huffman codes, allowing for a simpler decoder for special applications.
 @param error The error that occurred while attempting to deflate the receiver.

 @return The compressed data.
 */
- (NSData *)dataByGZipCompressingAtLevel:(int)level
                              windowSize:(int)windowBits
                             memoryLevel:(int)memLevel
                                strategy:(int)strategy
                                   error:(NSError * __autoreleasing *)error;

///--------------------
/// @name Decompressing
///--------------------

/**
 Returns the inflated of the receiver using gzip compression.

 @param error The error that occurred while attempting to inflate the receiver.

 @return The decompressed data.
 */
- (NSData *)dataByGZipDecompressingDataWithError:(NSError * __autoreleasing *)error;

/**
 Returns the inflated of the receiver using gzip compression with the specified zlib value for window size.

 @param windowBits The base two logarithm of the maximum window size (the size of the history buffer). Must be greater than or equal to the windowBits value provided to dataByGZipCompressingAtLevel:windowSize:memoryLevel:strategy:error: while compressing.
 @param error The error that occurred while attempting to inflate the receiver.

 @return The decompressed data.
 */
- (NSData *)dataByGZipDecompressingDataWithWindowSize:(int)windowBits
                                                error:(NSError * __autoreleasing *)error;

@end

///----------------
/// @name Constants
///----------------

/**
 ### Constants

 `GodzippaZlibErrorDomain`
 Godzippa errors. Error codes for `GodzippaZlibErrorDomain` correspond to status codes from zlib.
 */
extern NSString * const GodzippaZlibErrorDomain;
