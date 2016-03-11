// NSFileManager+Godzippa.m
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

#import "NSFileManager+Godzippa.h"

static const int kGodzippaChunkSize = 4096;

@implementation NSFileManager (Godzippa)

#pragma mark - Compressing

- (BOOL)GZipCompressFile:(NSURL *)sourceFile
   writingContentsToFile:(NSURL *)destinationFile
                   error:(NSError * __autoreleasing *)error
{
    return [self GZipCompressFile:sourceFile writingContentsToFile:destinationFile atLevel:Z_DEFAULT_COMPRESSION error:error];
}

- (BOOL)GZipCompressFile:(NSURL *)sourceFile
   writingContentsToFile:(NSURL *)destinationFile
                 atLevel:(int)level
                   error:(NSError *__autoreleasing *)error
{
    NSParameterAssert(sourceFile);
    NSParameterAssert(destinationFile);

    NSDictionary *sourceAttributes = [self attributesOfItemAtPath:sourceFile.path error:error];
    if (!sourceAttributes || [sourceAttributes[NSFileSize] unsignedIntegerValue] == 0) {
        return NO;
    }

    const char *mode = NULL;
    if (level == Z_DEFAULT_COMPRESSION) {
        mode = "w";
    } else {
        mode = [[NSString stringWithFormat:@"w%d", level] UTF8String];
    }

    NSFileHandle *sourceFileHandle = [NSFileHandle fileHandleForReadingFromURL:sourceFile error:error];
    {
        gzFile output = gzopen([destinationFile.path UTF8String], mode);
        {
            int numberOfBytesWritten = 0;

            do {
                @autoreleasepool {
                    NSData *data = [sourceFileHandle readDataOfLength:kGodzippaChunkSize];
                    numberOfBytesWritten = gzwrite(output, data.bytes, (unsigned) data.length);
                }
            } while (numberOfBytesWritten == kGodzippaChunkSize);
        }
        gzclose(output);
    }
    [sourceFileHandle closeFile];

    return YES;
}


#pragma mark - Decompressing

- (BOOL)GZipDecompressFile:(NSURL *)sourceFile
     writingContentsToFile:(NSURL *)destinationFile
                     error:(NSError * __autoreleasing *)error
{
    NSParameterAssert(sourceFile);
    NSParameterAssert(destinationFile);

    NSDictionary *sourceAttributes = [self attributesOfItemAtPath:sourceFile.path error:error];
    if (!sourceAttributes || [sourceAttributes[NSFileSize] unsignedIntegerValue] == 0) {
        return NO;
    }

    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationFile.path]) {
        if (![[NSFileManager defaultManager] createFileAtPath:destinationFile.path contents:nil attributes:nil]) {
            return NO;
        }
    }

    NSFileHandle *destinationFileHandle = [NSFileHandle fileHandleForWritingAtPath:destinationFile.path];
    {
        gzFile input = gzopen([sourceFile.path UTF8String], "r");
        {
            int numberOfBytesRead = 0;

            do {
                @autoreleasepool {
                    NSMutableData *mutableData = [NSMutableData dataWithLength:kGodzippaChunkSize];
                    numberOfBytesRead = gzread(input, mutableData.mutableBytes, kGodzippaChunkSize);
                    [destinationFileHandle writeData:[mutableData subdataWithRange:NSMakeRange(0, (NSUInteger)numberOfBytesRead)]];
                }
            } while (numberOfBytesRead == kGodzippaChunkSize);
        }
        gzclose(input);
    }
    [destinationFileHandle synchronizeFile];
    [destinationFileHandle closeFile];

    return YES;
}

@end
