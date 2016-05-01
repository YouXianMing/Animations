//
//  FastCoding.m
//
//  Version 3.2.1
//
//  Created by Nick Lockwood on 09/12/2013.
//  Copyright (c) 2013 Charcoal Design
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/nicklockwood/FastCoding
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

#import "FastCoder.h"
#import <objc/runtime.h>
#import <CoreGraphics/CoreGraphics.h>


#ifndef FC_DIAGNOSTIC_ENABLED
#define FC_DIAGNOSTIC_ENABLED 0
#endif


#import <Availability.h>
#if __has_feature(objc_arc)
#pragma clang diagnostic ignored "-Wpedantic"
#warning FastCoding runs slower under ARC. It is recommended that you disable it for this file
#endif


#pragma clang diagnostic ignored "-Wgnu"
#pragma clang diagnostic ignored "-Wpointer-arith"
#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wfour-char-constants"
#pragma clang diagnostic ignored "-Wobjc-missing-property-synthesis"
#pragma clang diagnostic ignored "-Wdirect-ivar-access"


NSString *const FastCodingException = @"FastCodingException";


static const uint32_t FCIdentifier = 'FAST';
static const uint16_t FCMajorVersion = 3;
static const uint16_t FCMinorVersion = 2;


typedef struct
{
    uint32_t identifier;
    uint16_t majorVersion;
    uint16_t minorVersion;
}
FCHeader;


typedef NS_ENUM(uint8_t, FCType)
{
    FCTypeNil = 0,
    FCTypeNull,
    FCTypeObjectAlias8,
    FCTypeObjectAlias16,
    FCTypeObjectAlias32,
    FCTypeStringAlias8,
    FCTypeStringAlias16,
    FCTypeStringAlias32,
    FCTypeString,
    FCTypeDictionary,
    FCTypeArray,
    FCTypeSet,
    FCTypeOrderedSet,
    FCTypeTrue,
    FCTypeFalse,
    FCTypeInt8,
    FCTypeInt16,
    FCTypeInt32,
    FCTypeInt64,
    FCTypeFloat32,
    FCTypeFloat64,
    FCTypeData,
    FCTypeDate,
    FCTypeMutableString,
    FCTypeMutableDictionary,
    FCTypeMutableArray,
    FCTypeMutableSet,
    FCTypeMutableOrderedSet,
    FCTypeMutableData,
    FCTypeClassDefinition,
    FCTypeObject8,
    FCTypeObject16,
    FCTypeObject32,
    FCTypeURL,
    FCTypePoint,
    FCTypeSize,
    FCTypeRect,
    FCTypeRange,
    FCTypeVector,
    FCTypeAffineTransform,
    FCType3DTransform,
    FCTypeMutableIndexSet,
    FCTypeIndexSet,
    FCTypeNSCodedObject,
    FCTypeDecimalNumber,
    FCTypeOne,
    FCTypeZero,
  
    FCTypeCount // sentinel value
};


#if !__has_feature(objc_arc)
#define FC_AUTORELEASE(x) [(x) autorelease]
#else
#define FC_AUTORELEASE(x) (x)
#endif


#import <TargetConditionals.h>
#if TARGET_OS_IPHONE
#define OR_IF_MAC(x)
#else
#define OR_IF_MAC(x) || (x)
#endif


#define FC_ASSERT_FITS(length, offset, total) { if ((NSUInteger)((offset) + (length)) > (total)) \
[NSException raise:FastCodingException format:@"Unexpected EOF when parsing object starting at %i", (int32_t)(offset)]; }

#define FC_READ_VALUE(type, offset, input, total) type value; { \
FC_ASSERT_FITS (sizeof(type), offset, total); \
value = *(type *)(input + offset); \
offset += sizeof(value); }

#define FC_ALIGN_INPUT(type, offset) { \
unsigned long align = offset % sizeof(type); \
if (align) offset += sizeof(type) - align; }

#define FC_ALIGN_OUTPUT(type, output) { \
unsigned long align = [output length] % sizeof(type); \
if (align) [output increaseLengthBy:sizeof(type) - align]; }


@interface FCNSCoder : NSCoder

@end


@interface FCNSCoder ()
{
    
@public
    __unsafe_unretained id _rootObject;
    __unsafe_unretained NSMutableData *_output;
    __unsafe_unretained NSMutableDictionary *_objectCache;
    __unsafe_unretained NSMutableDictionary *_classCache;
    __unsafe_unretained NSMutableDictionary *_stringCache;
    __unsafe_unretained NSMutableDictionary *_classesByName;
}

@end


@interface FCNSDecoder : NSCoder

@end


typedef id FCTypeConstructor(FCNSDecoder *);


@interface FCNSDecoder ()
{
    
@public
    NSUInteger *_offset;
    const void *_input;
    NSUInteger _total;
    FCTypeConstructor **_constructors;
    __unsafe_unretained NSData *_objectCache;
    __unsafe_unretained NSData *_classCache;
    __unsafe_unretained NSData *_stringCache;
    __unsafe_unretained NSMutableArray *_propertyDictionaryPool;
    __unsafe_unretained NSMutableDictionary *_properties;
}

@end


@interface FCClassDefinition : NSObject

@end


@interface FCClassDefinition ()
{
    
@public
    __unsafe_unretained NSString *_className;
    __unsafe_unretained NSArray *_propertyKeys;
}

@end


@interface NSObject (FastCoding_Private)

- (void)FC_encodeWithCoder:(__unsafe_unretained FCNSCoder *)coder;

@end


static Boolean FCEqualityCallback(const void *value1, const void *value2)
{
    return (Boolean)[(id)value1 isEqual:(id)value2];
}

static CFHashCode	FCHashCallback(const void *value)
{
    return [(id)value hash];
}

static inline NSUInteger FCCacheParsedObject(__unsafe_unretained id object, __unsafe_unretained NSData *cache)
{
    NSUInteger offset = (NSUInteger)CFDataGetLength((CFMutableDataRef)cache);
    
#if FC_DIAGNOSTIC_ENABLED
    
    if (![@[[NSURL class], [NSString class]] containsObject:[object classForCoder]]) {
        printf("%tu: %s\n", offset / sizeof(id), [[[object classForCoder] description] UTF8String]);
    }
    
#endif
    
    CFDataAppendBytes((CFMutableDataRef)cache, (void *)&object, sizeof(id));
    return offset;
}

static inline void FCReplaceCachedObject(NSUInteger offset, __unsafe_unretained id object, __unsafe_unretained NSData *cache)
{
    CFDataReplaceBytes((CFMutableDataRef)cache, CFRangeMake((CFIndex)offset, sizeof(id)), (void *)&object, sizeof(id));
}

static inline id FCCachedObjectAtIndex(NSUInteger index, __unsafe_unretained NSData *cache)
{
    NSUInteger count = (NSUInteger)CFDataGetLength((CFMutableDataRef)cache) / (NSUInteger)sizeof(id);
    if (index >= count)
    {
        [NSException raise:FastCodingException format:@"Attempted to read cache object at index %tu, but cache object count is %tu", index, count];
        return [NSNull null];
    }
    return ((__unsafe_unretained id *)(void *)CFDataGetBytePtr((CFMutableDataRef)cache))[index];
}


static id FCReadObject(__unsafe_unretained FCNSDecoder *decoder);
static id FCReadObject_2_3(__unsafe_unretained FCNSDecoder *decoder);

static inline uint8_t FCReadType(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_READ_VALUE(uint8_t, *decoder->_offset, decoder->_input, decoder->_total);
    return value;
}

static inline uint8_t FCReadRawUInt8(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_READ_VALUE(uint8_t, *decoder->_offset, decoder->_input, decoder->_total);
    return value;
}

static inline uint16_t FCReadRawUInt16(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_READ_VALUE(uint16_t, *decoder->_offset, decoder->_input, decoder->_total);
    return value;
}

static inline uint32_t FCReadRawUInt32(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_READ_VALUE(uint32_t, *decoder->_offset, decoder->_input, decoder->_total);
    return value;
}

static inline double FCReadRawDouble(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_READ_VALUE(Float64, *decoder->_offset, decoder->_input, decoder->_total);
    return value;
}

static id FCReadRawString(__unsafe_unretained FCNSDecoder *decoder)
{
    __autoreleasing NSString *string = nil;
    NSUInteger length = strlen(decoder->_input + *decoder->_offset) + 1;
    FC_ASSERT_FITS(length, *decoder->_offset, decoder->_total);
    if (length > 1)
    {
        string = CFBridgingRelease(CFStringCreateWithBytes(NULL, decoder->_input + *decoder->_offset,
                                                           (CFIndex)length - 1, kCFStringEncodingUTF8, false));
    }
    else
    {
        string = @"";
    }
    *decoder->_offset += length;
    return string;
}

static id FCReadNil(__unused __unsafe_unretained FCNSDecoder *decoder)
{
    return nil;
}

static id FCReadNull(__unused __unsafe_unretained FCNSDecoder *decoder)
{
    return [NSNull null];
}

static id FCReadAlias8(__unsafe_unretained FCNSDecoder *decoder)
{
    return FCCachedObjectAtIndex(FCReadRawUInt8(decoder), decoder->_objectCache);
}

static id FCReadAlias16(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(uint16_t, *decoder->_offset);
    return FCCachedObjectAtIndex(FCReadRawUInt16(decoder), decoder->_objectCache);
}

static id FCReadAlias32(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(uint32_t, *decoder->_offset);
    return FCCachedObjectAtIndex(FCReadRawUInt32(decoder), decoder->_objectCache);
}

static id FCReadStringAlias8(__unsafe_unretained FCNSDecoder *decoder)
{
    return FCCachedObjectAtIndex(FCReadRawUInt8(decoder), decoder->_stringCache);
}

static id FCReadStringAlias16(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(uint16_t, *decoder->_offset);
    return FCCachedObjectAtIndex(FCReadRawUInt16(decoder), decoder->_stringCache);
}

static id FCReadStringAlias32(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(uint32_t, *decoder->_offset);
    return FCCachedObjectAtIndex(FCReadRawUInt32(decoder), decoder->_stringCache);
}

static id FCReadString(__unsafe_unretained FCNSDecoder *decoder)
{
    NSString *string = FCReadRawString(decoder);
    FCCacheParsedObject(string, decoder->_stringCache);
    return string;
}

static id FCReadMutableString(__unsafe_unretained FCNSDecoder *decoder)
{
    __autoreleasing NSMutableString *string = nil;
    NSUInteger length = strlen(decoder->_input + *decoder->_offset) + 1;
    FC_ASSERT_FITS(length, *decoder->_offset, decoder->_total);
    if (length > 1)
    {
        string = FC_AUTORELEASE([[NSMutableString alloc] initWithBytes:decoder->_input + *decoder->_offset length:length - 1 encoding:NSUTF8StringEncoding]);
    }
    else
    {
        string = [NSMutableString string];
    }
    *decoder->_offset += length;
    FCCacheParsedObject(string, decoder->_objectCache);
    return string;
}

static id FCReadDictionary(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(uint32_t, *decoder->_offset);
    uint32_t count = FCReadRawUInt32(decoder);
    __autoreleasing NSDictionary *dict = nil;
    if (count)
    {
        __autoreleasing id *keys = (__autoreleasing id *)malloc(count * sizeof(id));
        __autoreleasing id *objects = (__autoreleasing id *)malloc(count * sizeof(id));
        for (uint32_t i = 0; i < count; i++)
        {
            objects[i] = FCReadObject(decoder);
            keys[i] = FCReadObject(decoder);
        }
        
        dict = [NSDictionary dictionaryWithObjects:objects forKeys:keys count:count];
        free(objects);
        free(keys);
    }
    else
    {
        dict = @{};
    }
    FCCacheParsedObject(dict, decoder->_objectCache);
    return dict;
}

static id FCReadMutableDictionary(__unsafe_unretained FCNSDecoder *decoder)
{
    const CFDictionaryKeyCallBacks keyCallbacks =
    {
        kCFTypeDictionaryKeyCallBacks.version,
        kCFTypeDictionaryKeyCallBacks.retain,
        kCFTypeDictionaryKeyCallBacks.release,
        kCFTypeDictionaryKeyCallBacks.copyDescription,
        &FCEqualityCallback,
        &FCHashCallback
    };
  
    const CFDictionaryValueCallBacks valueCallbacks =
    {
        kCFTypeDictionaryKeyCallBacks.version,
        kCFTypeDictionaryKeyCallBacks.retain,
        kCFTypeDictionaryKeyCallBacks.release,
        kCFTypeDictionaryKeyCallBacks.copyDescription,
        &FCEqualityCallback,
    };
  
    FC_ALIGN_INPUT(uint32_t, *decoder->_offset);
    uint32_t count = FCReadRawUInt32(decoder);
    __autoreleasing NSMutableDictionary *dict = CFBridgingRelease(CFDictionaryCreateMutable(NULL, (CFIndex)count, &keyCallbacks, &valueCallbacks));
    FCCacheParsedObject(dict, decoder->_objectCache);
    for (uint32_t i = 0; i < count; i++)
    {
        __autoreleasing id object = FCReadObject(decoder);
        __autoreleasing id key = FCReadObject(decoder);
        CFDictionarySetValue((CFMutableDictionaryRef)dict, (const void *)key, (const void *)object);
    }
    return dict;
}

static id FCReadArray(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(uint32_t, *decoder->_offset);
    uint32_t count = FCReadRawUInt32(decoder);
    __autoreleasing NSArray *array = nil;
    if (count)
    {
        __autoreleasing id *objects = (__autoreleasing id *)malloc(count * sizeof(id));
        for (uint32_t i = 0; i < count; i++)
        {
            objects[i] = FCReadObject(decoder);
        }
        array = [NSArray arrayWithObjects:objects count:count];
        free(objects);
    }
    else
    {
        array = @[];
    }
    FCCacheParsedObject(array, decoder->_objectCache);
    return array;
}

static id FCReadMutableArray(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(uint32_t, *decoder->_offset);
    uint32_t count = FCReadRawUInt32(decoder);
    __autoreleasing NSMutableArray *array = [NSMutableArray arrayWithCapacity:count];
    FCCacheParsedObject(array, decoder->_objectCache);
    for (uint32_t i = 0; i < count; i++)
    {
        CFArrayAppendValue((CFMutableArrayRef)array, (void *)FCReadObject(decoder));
    }
    return array;
}

static id FCReadSet(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(uint32_t, *decoder->_offset);
    uint32_t count = FCReadRawUInt32(decoder);
    __autoreleasing NSSet *set = nil;
    if (count)
    {
        __autoreleasing id *objects = (__autoreleasing id *)malloc(count * sizeof(id));
        for (uint32_t i = 0; i < count; i++)
        {
            objects[i] = FCReadObject(decoder);
        }
        set = [NSSet setWithObjects:objects count:count];
        free(objects);
    }
    else
    {
        set = [NSSet set];
    }
    FCCacheParsedObject(set, decoder->_objectCache);
    return set;
}

static id FCReadMutableSet(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(uint32_t, *decoder->_offset);
    uint32_t count = FCReadRawUInt32(decoder);
    __autoreleasing NSMutableSet *set = [NSMutableSet setWithCapacity:count];
    FCCacheParsedObject(set, decoder->_objectCache);
    for (uint32_t i = 0; i < count; i++)
    {
        [set addObject:FCReadObject(decoder)];
    }
    return set;
}

static id FCReadOrderedSet(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(uint32_t, *decoder->_offset);
    uint32_t count = FCReadRawUInt32(decoder);
    __autoreleasing NSOrderedSet *set = nil;
    if (count)
    {
        __autoreleasing id *objects = (__autoreleasing id *)malloc(count * sizeof(id));
        for (uint32_t i = 0; i < count; i++)
        {
            objects[i] = FCReadObject(decoder);
        }
        set = [NSOrderedSet orderedSetWithObjects:objects count:count];
        free(objects);
    }
    else
    {
        set = [NSOrderedSet orderedSet];
    }
    FCCacheParsedObject(set, decoder->_objectCache);
    return set;
}

static id FCReadMutableOrderedSet(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(uint32_t, *decoder->_offset);
    uint32_t count = FCReadRawUInt32(decoder);
    __autoreleasing NSMutableOrderedSet *set = [NSMutableOrderedSet orderedSetWithCapacity:count];
    FCCacheParsedObject(set, decoder->_objectCache);
    for (uint32_t i = 0; i < count; i++)
    {
        [set addObject:FCReadObject(decoder)];
    }
    return set;
}

static id FCReadTrue(__unused __unsafe_unretained FCNSDecoder *decoder)
{
    return @YES;
}

static id FCReadFalse(__unused __unsafe_unretained FCNSDecoder *decoder)
{
    return @NO;
}

static id FCReadOne(__unused __unsafe_unretained FCNSDecoder *decoder)
{
    return @1;
}

static id FCReadZero(__unused __unsafe_unretained FCNSDecoder *decoder)
{
    return @0;
}

static id FCReadInt8(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_READ_VALUE(int8_t, *decoder->_offset, decoder->_input, decoder->_total);
    __autoreleasing NSNumber *number = @(value);
    return number;
}

static id FCReadInt16(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(int16_t, *decoder->_offset);
    FC_READ_VALUE(int16_t, *decoder->_offset, decoder->_input, decoder->_total);
    __autoreleasing NSNumber *number = @(value);
    return number;
}

static id FCReadInt32(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(int32_t, *decoder->_offset);
    FC_READ_VALUE(int32_t, *decoder->_offset, decoder->_input, decoder->_total);
    __autoreleasing NSNumber *number = @(value);
    return number;
}

static id FCReadInt64(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(int64_t, *decoder->_offset);
    FC_READ_VALUE(int64_t, *decoder->_offset, decoder->_input, decoder->_total);
    __autoreleasing NSNumber *number = @(value);
    return number;
}

static id FCReadFloat32(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(Float32, *decoder->_offset);
    FC_READ_VALUE(Float32, *decoder->_offset, decoder->_input, decoder->_total);
    __autoreleasing NSNumber *number = @(value);
    return number;
}

static id FCReadFloat64(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(Float64, *decoder->_offset);
    FC_READ_VALUE(Float64, *decoder->_offset, decoder->_input, decoder->_total);
    __autoreleasing NSNumber *number = @(value);
    return number;
}

static id FCReadData(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(uint32_t, *decoder->_offset);
    uint32_t length = FCReadRawUInt32(decoder);
    NSUInteger paddedLength = length + (4 - ((length % 4) ?: 4));
    FC_ASSERT_FITS(paddedLength, *decoder->_offset, decoder->_total);
    __autoreleasing NSData *data = [NSData dataWithBytes:(decoder->_input + *decoder->_offset) length:length];
    *decoder->_offset += paddedLength;
    FCCacheParsedObject(data, decoder->_objectCache);
    return data;
}

static id FCReadMutableData(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(uint32_t, *decoder->_offset);
    uint32_t length = FCReadRawUInt32(decoder);
    NSUInteger paddedLength = length + (4 - ((length % 4) ?: 4));
    FC_ASSERT_FITS(paddedLength, *decoder->_offset, decoder->_total);
    __autoreleasing NSMutableData *data = [NSMutableData dataWithBytes:(decoder->_input + *decoder->_offset) length:length];
    *decoder->_offset += paddedLength;
    FCCacheParsedObject(data, decoder->_objectCache);
    return data;
}

static id FCReadDate(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(NSTimeInterval, *decoder->_offset);
    FC_READ_VALUE(NSTimeInterval, *decoder->_offset, decoder->_input, decoder->_total);
    __autoreleasing NSDate *date = [NSDate dateWithTimeIntervalSince1970:value];
    FCCacheParsedObject(date, decoder->_objectCache);
    return date;
}

static id FCReadClassDefinition(__unsafe_unretained FCNSDecoder *decoder)
{
    __autoreleasing FCClassDefinition *definition = FC_AUTORELEASE([[FCClassDefinition alloc] init]);
    FCCacheParsedObject(definition, decoder->_classCache);
    definition->_className = FCReadRawString(decoder);
    FC_ALIGN_INPUT(uint32_t, *decoder->_offset);
    uint32_t count = FCReadRawUInt32(decoder);
    if (count)
    {
        __autoreleasing id *objects = (__autoreleasing id *)malloc(count * sizeof(id));
        for (uint32_t i = 0; i < count; i++)
        {
            objects[i] = FCReadRawString(decoder);
        }
        __autoreleasing NSArray *propertyKeys = [NSArray arrayWithObjects:objects count:count];
        definition->_propertyKeys = propertyKeys;
        free(objects);
    }
    
    //now return the actual object instance
    return FCReadObject(decoder);
}

static id FCReadObjectInstance(__unsafe_unretained FCNSDecoder *decoder, NSUInteger classIndex)
{
    __autoreleasing FCClassDefinition *definition = FCCachedObjectAtIndex(classIndex, decoder->_classCache);
    __autoreleasing Class objectClass = NSClassFromString(definition->_className);
    __autoreleasing id object = nil;
    if (objectClass)
    {
        object = FC_AUTORELEASE([[objectClass alloc] init]);
    }
    else if (definition->_className)
    {
        object = [NSMutableDictionary dictionaryWithObject:definition->_className forKey:@"$class"];
    }
    else if (object)
    {
        object = [NSMutableDictionary dictionary];
    }
    NSUInteger cacheIndex = FCCacheParsedObject(object, decoder->_objectCache);
    for (__unsafe_unretained NSString *key in definition->_propertyKeys)
    {
        [object setValue:FCReadObject(decoder) forKey:key];
    }
    id newObject = [object awakeAfterFastCoding];
    if (newObject != object)
    {
        //TODO: this is only a partial solution, as any objects that referenced
        //this object between when it was created and now will have received incorrect instance
        FCReplaceCachedObject(cacheIndex, newObject, decoder->_objectCache);
    }
    return newObject;
}

static id FCReadObject8(__unsafe_unretained FCNSDecoder *decoder)
{
    return FCReadObjectInstance(decoder, FCReadRawUInt8(decoder));
}

static id FCReadObject16(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(uint16_t, *decoder->_offset);
    return FCReadObjectInstance(decoder, FCReadRawUInt16(decoder));
}

static id FCReadObject32(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(uint32_t, *decoder->_offset);
    return FCReadObjectInstance(decoder, FCReadRawUInt32(decoder));
}

static id FCReadURL(__unsafe_unretained FCNSDecoder *decoder)
{
    __autoreleasing NSURL *URL = [NSURL URLWithString:FCReadObject(decoder) relativeToURL:FCReadObject(decoder)];
    FCCacheParsedObject(URL, decoder->_stringCache);
    return URL;
}

static id FCReadPoint(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(Float64, *decoder->_offset);
    CGPoint point = {(CGFloat)FCReadRawDouble(decoder), (CGFloat)FCReadRawDouble(decoder)};
    NSValue *value = [NSValue valueWithBytes:&point objCType:@encode(CGPoint)];
    return value;
}

static id FCReadSize(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(Float64, *decoder->_offset);
    CGSize size = {(CGFloat)FCReadRawDouble(decoder), (CGFloat)FCReadRawDouble(decoder)};
    NSValue *value = [NSValue valueWithBytes:&size objCType:@encode(CGSize)];
    return value;
}

static id FCReadRect(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(Float64, *decoder->_offset);
    CGRect rect =
    {
        {(CGFloat)FCReadRawDouble(decoder), (CGFloat)FCReadRawDouble(decoder)},
        {(CGFloat)FCReadRawDouble(decoder), (CGFloat)FCReadRawDouble(decoder)}
    };
    NSValue *value = [NSValue valueWithBytes:&rect objCType:@encode(CGRect)];
    return value;
}

static id FCReadRange(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(uint32_t, *decoder->_offset);
    NSRange range = {FCReadRawUInt32(decoder), FCReadRawUInt32(decoder)};
    NSValue *value = [NSValue valueWithBytes:&range objCType:@encode(NSRange)];
    return value;
}

static id FCReadVector(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(Float64, *decoder->_offset);
    CGVector point = {(CGFloat)FCReadRawDouble(decoder), (CGFloat)FCReadRawDouble(decoder)};
    NSValue *value = [NSValue valueWithBytes:&point objCType:@encode(CGVector)];
    return value;
}

static id FCReadAffineTransform(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(Float64, *decoder->_offset);
    CGAffineTransform transform =
    {
        (CGFloat)FCReadRawDouble(decoder), (CGFloat)FCReadRawDouble(decoder),
        (CGFloat)FCReadRawDouble(decoder), (CGFloat)FCReadRawDouble(decoder),
        (CGFloat)FCReadRawDouble(decoder), (CGFloat)FCReadRawDouble(decoder)
    };
    NSValue *value = [NSValue valueWithBytes:&transform objCType:@encode(CGAffineTransform)];
    return value;
}

static id FCRead3DTransform(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(Float64, *decoder->_offset);
    CGFloat transform[] =
    {
        (CGFloat)FCReadRawDouble(decoder), (CGFloat)FCReadRawDouble(decoder),
        (CGFloat)FCReadRawDouble(decoder), (CGFloat)FCReadRawDouble(decoder),
        (CGFloat)FCReadRawDouble(decoder), (CGFloat)FCReadRawDouble(decoder),
        (CGFloat)FCReadRawDouble(decoder), (CGFloat)FCReadRawDouble(decoder),
        (CGFloat)FCReadRawDouble(decoder), (CGFloat)FCReadRawDouble(decoder),
        (CGFloat)FCReadRawDouble(decoder), (CGFloat)FCReadRawDouble(decoder),
        (CGFloat)FCReadRawDouble(decoder), (CGFloat)FCReadRawDouble(decoder),
        (CGFloat)FCReadRawDouble(decoder), (CGFloat)FCReadRawDouble(decoder)
    };
    NSValue *value = [NSValue valueWithBytes:&transform objCType:@encode(CGFloat[16])];
    return value;
}

static id FCReadMutableIndexSet(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(uint32_t, *decoder->_offset);
    uint32_t rangeCount = FCReadRawUInt32(decoder);
    __autoreleasing NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    FCCacheParsedObject(indexSet, decoder->_objectCache);
    for (uint32_t i = 0; i < rangeCount; i++)
    {
        NSRange range = {FCReadRawUInt32(decoder), FCReadRawUInt32(decoder)};
        [indexSet addIndexesInRange:range];
    }
    return indexSet;
}

static id FCReadIndexSet(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(uint32_t, *decoder->_offset);
    uint32_t rangeCount = FCReadRawUInt32(decoder);
    __autoreleasing NSIndexSet *indexSet;
    if (rangeCount == 1)
    {
        //common case optimisation
        NSRange range = {FCReadRawUInt32(decoder), FCReadRawUInt32(decoder)};
        indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
    }
    else
    {
        indexSet = [NSMutableIndexSet indexSet];
        for (uint32_t i = 0; i < rangeCount; i++)
        {
            NSRange range = {FCReadRawUInt32(decoder), FCReadRawUInt32(decoder)};
            [(NSMutableIndexSet *)indexSet addIndexesInRange:range];
        }
        indexSet = [indexSet copy];
        
    }
    FCCacheParsedObject(indexSet, decoder->_objectCache);
    return indexSet;
}

static id FCReadNSCodedObject(__unsafe_unretained FCNSDecoder *decoder)
{
    NSString *className = FCReadObject(decoder);
    NSMutableDictionary *oldProperties = decoder->_properties;
    if ([decoder->_propertyDictionaryPool count])
    {
        decoder->_properties = [decoder->_propertyDictionaryPool lastObject];
        [decoder->_propertyDictionaryPool removeLastObject];
        [decoder->_properties removeAllObjects];
    }
    else
    {
        const CFDictionaryKeyCallBacks stringKeyCallbacks =
        {
            0,
            NULL,
            NULL,
            NULL,
            FCEqualityCallback,
            FCHashCallback
        };
        
        __autoreleasing id properties = CFBridgingRelease(CFDictionaryCreateMutable(NULL, 0, &stringKeyCallbacks, NULL));
        decoder->_properties = properties;
    }
    while (true)
    {
        id object = FCReadObject(decoder);
        if (!object) break;
        NSString *key = FCReadObject(decoder);
        decoder->_properties[key] = object;
    }
    id object = FC_AUTORELEASE([[NSClassFromString(className) alloc] initWithCoder:decoder]);
    [decoder->_propertyDictionaryPool addObject:decoder->_properties];
    decoder->_properties = oldProperties;
    FCCacheParsedObject(object, decoder->_objectCache);
    return object;
}

static id FCReadDecimalNumber(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_ALIGN_INPUT(NSDecimal, *decoder->_offset);
    FC_READ_VALUE(NSDecimal, *decoder->_offset, decoder->_input, decoder->_total);
    return [NSDecimalNumber decimalNumberWithDecimal:value];
}

static id FCReadObject(__unsafe_unretained FCNSDecoder *decoder)
{
    FCType type = FCReadType(decoder);
    FCTypeConstructor *constructor = NULL;
    if (type < FCTypeCount)
    {
        constructor = decoder->_constructors[type];
    }
    if (!constructor)
    {
        [NSException raise:FastCodingException format:@"FastCoding cannot decode object of type: %i", type];
        return nil;
    }
    return constructor(decoder);
}

id FCParseData(NSData *data, FCTypeConstructor *constructors[])
{
    NSUInteger length = [data length];
    if (length < sizeof(FCHeader))
    {
        //not a valid FastArchive
        return nil;
    }
    
    //read header
    FCHeader header;
    const void *input = data.bytes;
    memcpy(&header, input, sizeof(header));
    if (header.identifier != FCIdentifier)
    {
        //not a FastArchive
        return nil;
    }
    if (header.majorVersion < 2 || header.majorVersion > FCMajorVersion)
    {
        //not compatible
        NSLog(@"This version of the FastCoding library doesn't support FastCoding version %i.%i files", header.majorVersion, header.minorVersion);
        return nil;
    }
    
    //create decoder
    NSUInteger offset = sizeof(header);
    FCNSDecoder *decoder = FC_AUTORELEASE([[FCNSDecoder alloc] init]);
    decoder->_constructors = constructors;
    decoder->_input = input;
    decoder->_offset = &offset;
    decoder->_total = length;
    
    //read data
    __autoreleasing NSMutableData *objectCache = [NSMutableData dataWithCapacity:FCReadRawUInt32(decoder) * sizeof(id)];
    decoder->_objectCache = objectCache;
    if (header.majorVersion < 3)
    {
        return FCReadObject_2_3(decoder);
    }
    else
    {
        __autoreleasing NSMutableData *classCache = [NSMutableData dataWithCapacity:FCReadRawUInt32(decoder) * sizeof(id)];
        __autoreleasing NSMutableData *stringCache = [NSMutableData dataWithCapacity:FCReadRawUInt32(decoder) * sizeof(id)];
        __autoreleasing NSMutableArray *propertyDictionaryPool = CFBridgingRelease(CFArrayCreateMutable(NULL, 0, NULL));
        
        decoder->_classCache = classCache;
        decoder->_stringCache = stringCache;
        decoder->_propertyDictionaryPool = propertyDictionaryPool;
        
#if FC_DIAGNOSTIC_ENABLED
        
        printf("Input cache:\n");
        
#endif
        
        @try
        {
            return FCReadObject(decoder);
        }
        @catch (NSException *exception)
        {
            NSLog(@"%@", [exception reason]);
            return nil;
        }
    }
}

static inline NSUInteger FCCacheWrittenObject(__unsafe_unretained id object, __unsafe_unretained NSMutableDictionary *cache)
{
    NSUInteger count = (NSUInteger)CFDictionaryGetCount((CFMutableDictionaryRef)cache);
    CFDictionarySetValue((CFMutableDictionaryRef)cache, (const void *)(object), (const void *)(count + 1));
    return count;
}

static inline NSUInteger FCIndexOfCachedObject(__unsafe_unretained id object, __unsafe_unretained NSMutableDictionary *cache)
{
    const void *index = CFDictionaryGetValue((CFMutableDictionaryRef)cache, (const void *)object);
    if (index)
    {
        return ((NSUInteger)index) - 1;
    }
    return NSNotFound;
}

static inline void FCWriteType(FCType value, __unsafe_unretained NSMutableData *output)
{
    [output appendBytes:&value length:sizeof(value)];
}

static inline void FCWriteUInt8(uint8_t value, __unsafe_unretained NSMutableData *output)
{
    [output appendBytes:&value length:sizeof(value)];
}

static inline void FCWriteUInt16(uint16_t value, __unsafe_unretained NSMutableData *output)
{
    [output appendBytes:&value length:sizeof(value)];
}

static inline void FCWriteUInt32(uint32_t value, __unsafe_unretained NSMutableData *output)
{
    [output appendBytes:&value length:sizeof(value)];
}

static inline void FCWriteDouble(Float64 value, __unsafe_unretained NSMutableData *output)
{
    [output appendBytes:&value length:sizeof(value)];
}

static inline void FCWriteString(__unsafe_unretained NSString *string, __unsafe_unretained NSMutableData *output)
{
    const char *utf8 = [string UTF8String];
    NSUInteger length = strlen(utf8) + 1;
    [output appendBytes:utf8 length:length];
}

static inline BOOL FCWriteObjectAlias(__unsafe_unretained id object, __unsafe_unretained FCNSCoder *coder)
{
    NSUInteger index = FCIndexOfCachedObject(object, coder->_objectCache);
    if (index <= UINT8_MAX)
    {
        FCWriteType(FCTypeObjectAlias8, coder->_output);
        FCWriteUInt8((uint8_t)index, coder->_output);
        return YES;
    }
    else if (index <= UINT16_MAX)
    {
        FCWriteType(FCTypeObjectAlias16, coder->_output);
        FC_ALIGN_OUTPUT(uint16_t, coder->_output);
        FCWriteUInt16((uint16_t)index, coder->_output);
        return YES;
    }
    else if (index != NSNotFound)
    {
        FCWriteType(FCTypeObjectAlias32, coder->_output);
        FC_ALIGN_OUTPUT(uint32_t, coder->_output);
        FCWriteUInt32((uint32_t)index, coder->_output);
        return YES;
    }
    else
    {
        return NO;
    }
}

static inline BOOL FCWriteStringAlias(__unsafe_unretained id object, __unsafe_unretained FCNSCoder *coder)
{
    NSUInteger index = FCIndexOfCachedObject(object, coder->_stringCache);
    if (index <= UINT8_MAX)
    {
        FCWriteType(FCTypeStringAlias8, coder->_output);
        FCWriteUInt8((uint8_t)index, coder->_output);
        return YES;
    }
    else if (index <= UINT16_MAX)
    {
        FCWriteType(FCTypeStringAlias16, coder->_output);
        FC_ALIGN_OUTPUT(uint16_t, coder->_output);
        FCWriteUInt16((uint16_t)index, coder->_output);
        return YES;
    }
    else if (index != NSNotFound)
    {
        FCWriteType(FCTypeStringAlias32, coder->_output);
        FC_ALIGN_OUTPUT(uint32_t, coder->_output);
        FCWriteUInt32((uint32_t)index, coder->_output);
        return YES;
    }
    else
    {
        return NO;
    }
}

static void FCWriteObject(__unsafe_unretained id object, __unsafe_unretained FCNSCoder *coder)
{
    if (object)
    {
        [object FC_encodeWithCoder:coder];
    }
    else
    {
        FCWriteType(FCTypeNil, coder->_output);
    }
}


@implementation FastCoder

+ (id)objectWithData:(NSData *)data
{
    static FCTypeConstructor *constructors[] =
    {
        FCReadNil,
        FCReadNull,
        FCReadAlias8,
        FCReadAlias16,
        FCReadAlias32,
        FCReadStringAlias8,
        FCReadStringAlias16,
        FCReadStringAlias32,
        FCReadString,
        FCReadDictionary,
        FCReadArray,
        FCReadSet,
        FCReadOrderedSet,
        FCReadTrue,
        FCReadFalse,
        FCReadInt8,
        FCReadInt16,
        FCReadInt32,
        FCReadInt64,
        FCReadFloat32,
        FCReadFloat64,
        FCReadData,
        FCReadDate,
        FCReadMutableString,
        FCReadMutableDictionary,
        FCReadMutableArray,
        FCReadMutableSet,
        FCReadMutableOrderedSet,
        FCReadMutableData,
        FCReadClassDefinition,
        FCReadObject8,
        FCReadObject16,
        FCReadObject32,
        FCReadURL,
        FCReadPoint,
        FCReadSize,
        FCReadRect,
        FCReadRange,
        FCReadVector,
        FCReadAffineTransform,
        FCRead3DTransform,
        FCReadMutableIndexSet,
        FCReadIndexSet,
        FCReadNSCodedObject,
        FCReadDecimalNumber,
        FCReadOne,
        FCReadZero
    };
    
    return FCParseData(data, constructors);
}

+ (id)propertyListWithData:(NSData *)data
{
    static FCTypeConstructor *constructors[] =
    {
        NULL,
        FCReadNull,
        FCReadAlias8,
        FCReadAlias16,
        FCReadAlias32,
        FCReadStringAlias8,
        FCReadStringAlias16,
        FCReadStringAlias32,
        FCReadString,
        FCReadDictionary,
        FCReadArray,
        FCReadSet,
        FCReadOrderedSet,
        FCReadTrue,
        FCReadFalse,
        FCReadInt8,
        FCReadInt16,
        FCReadInt32,
        FCReadInt64,
        FCReadFloat32,
        FCReadFloat64,
        FCReadData,
        FCReadDate,
        FCReadMutableString,
        FCReadMutableDictionary,
        FCReadMutableArray,
        FCReadMutableSet,
        FCReadMutableOrderedSet,
        FCReadMutableData,
        NULL,
        NULL,
        NULL,
        NULL,
        FCReadURL,
        FCReadPoint,
        FCReadSize,
        FCReadRect,
        FCReadRange,
        FCReadVector,
        FCReadAffineTransform,
        FCRead3DTransform,
        FCReadMutableIndexSet,
        FCReadIndexSet,
        NULL,
        FCReadDecimalNumber,
        FCReadOne,
        FCReadZero
    };
  
    return FCParseData(data, constructors);
}

+ (NSData *)dataWithRootObject:(id)object
{
    if (object)
    {
        //write header
        FCHeader header = {FCIdentifier, FCMajorVersion, FCMinorVersion};
        NSMutableData *output = [NSMutableData dataWithLength:sizeof(header)];
        memcpy(output.mutableBytes, &header, sizeof(header));
        
        //object count placeholders
        FCWriteUInt32(0, output);
        FCWriteUInt32(0, output);
        FCWriteUInt32(0, output);

        @autoreleasepool
        {
            __autoreleasing id objectCache = CFBridgingRelease(CFDictionaryCreateMutable(NULL, 0, NULL, NULL));
            __autoreleasing id classCache = CFBridgingRelease(CFDictionaryCreateMutable(NULL, 0, NULL, NULL));
            __autoreleasing id stringCache = CFBridgingRelease(CFDictionaryCreateMutable(NULL, 0, &kCFCopyStringDictionaryKeyCallBacks, NULL));
            __autoreleasing id classesByName = CFBridgingRelease(CFDictionaryCreateMutable(NULL, 0, &kCFCopyStringDictionaryKeyCallBacks, NULL));
            
            //create coder
            FCNSCoder *coder = FC_AUTORELEASE([[FCNSCoder alloc] init]);
            coder->_rootObject = object;
            coder->_output = output;
            coder->_objectCache = objectCache;
            coder->_classCache = classCache;
            coder->_stringCache = stringCache;
            coder->_classesByName = classesByName;
            
            //write object
            FCWriteObject(object, coder);
            
#if FC_DIAGNOSTIC_ENABLED
            
            NSUInteger count = [objectCache count];
            const void **keys = (const void **)malloc(count * sizeof(id));
            const NSUInteger *values = (const NSUInteger *)malloc(count * sizeof(NSUInteger));
            CFDictionaryGetKeysAndValues((CFDictionaryRef)objectCache, keys, (const void **)values);
            NSMutableDictionary *cache = [NSMutableDictionary dictionary];
            for (NSUInteger i = 0; i < count; i++)
            {
                cache[@(values[i])] = (id)keys[i];
            }
            printf("Output cache:\n");
            for (NSUInteger i = 0; i < count; i++)
            {
                printf("%tu: %s\n", i, [[[cache[@(i + 1)] classForCoder] description] UTF8String]);
            }
            printf("\n");
            free(keys);
            free((void **)values);
            
#endif
            
            //set object count
            uint32_t objectCount = (uint32_t)[objectCache count];
            [output replaceBytesInRange:NSMakeRange(sizeof(header), sizeof(uint32_t)) withBytes:&objectCount];
            
            //set class count
            uint32_t classCount = (uint32_t)[classCache count];
            [output replaceBytesInRange:NSMakeRange(sizeof(header) + sizeof(uint32_t), sizeof(uint32_t)) withBytes:&classCount];
            
            //set string count
            uint32_t stringCount = (uint32_t)[stringCache count];
            [output replaceBytesInRange:NSMakeRange(sizeof(header) + sizeof(uint32_t) * 2, sizeof(uint32_t)) withBytes:&stringCount];
            
            return output;
        }
    }
    return nil;
}

@end


@implementation FCNSCoder

- (BOOL)allowsKeyedCoding
{
    return YES;
}

- (void)encodeObject:(__unsafe_unretained id)objv forKey:(__unsafe_unretained NSString *)key
{
    FCWriteObject(objv, self);
    FCWriteObject(key, self);
}

- (void)encodeConditionalObject:(id)objv forKey:(__unsafe_unretained NSString *)key
{
    if (FCIndexOfCachedObject(objv, _objectCache) != NSNotFound)
    {
        FCWriteObject(objv, self);
        FCWriteObject(key, self);
    }
}

- (void)encodeBool:(BOOL)boolv forKey:(__unsafe_unretained NSString *)key
{
    FCWriteObject(@(boolv), self);
    FCWriteObject(key, self);
}

- (void)encodeInt:(int)intv forKey:(__unsafe_unretained NSString *)key
{
    FCWriteObject(@(intv), self);
    FCWriteObject(key, self);
}

- (void)encodeInteger:(NSInteger)intv forKey:(__unsafe_unretained NSString *)key
{
    FCWriteObject(@(intv), self);
    FCWriteObject(key, self);
}

- (void)encodeInt32:(int32_t)intv forKey:(__unsafe_unretained NSString *)key
{
    FCWriteObject(@(intv), self);
    FCWriteObject(key, self);
}

- (void)encodeInt64:(int64_t)intv forKey:(__unsafe_unretained NSString *)key
{
    FCWriteObject(@(intv), self);
    FCWriteObject(key, self);
}

- (void)encodeFloat:(float)realv forKey:(__unsafe_unretained NSString *)key
{
    FCWriteObject(@(realv), self);
    FCWriteObject(key, self);
}

- (void)encodeDouble:(double)realv forKey:(__unsafe_unretained NSString *)key
{
    FCWriteObject(@(realv), self);
    FCWriteObject(key, self);
}

- (void)encodeBytes:(const uint8_t *)bytesp length:(NSUInteger)lenv forKey:(__unsafe_unretained NSString *)key
{
    FCWriteObject([NSData dataWithBytes:bytesp length:lenv], self);
    FCWriteObject(key, self);
}

@end


@implementation FCNSDecoder

- (BOOL)allowsKeyedCoding
{
    return YES;
}

- (BOOL)containsValueForKey:(NSString *)key
{
    return _properties[key] != nil;
}

- (id)decodeObjectForKey:(__unsafe_unretained NSString *)key
{
    return _properties[key];
}

- (BOOL)decodeBoolForKey:(__unsafe_unretained NSString *)key
{
    return [_properties[key] boolValue];
}

- (int)decodeIntForKey:(__unsafe_unretained NSString *)key
{
    return [_properties[key] intValue];
}

- (NSInteger)decodeIntegerForKey:(__unsafe_unretained NSString *)key
{
    return [_properties[key] integerValue];
}

- (int32_t)decodeInt32ForKey:(__unsafe_unretained NSString *)key
{
    return (int32_t)[_properties[key] longValue];
}

- (int64_t)decodeInt64ForKey:(__unsafe_unretained NSString *)key
{
    return [_properties[key] longLongValue];
}

- (float)decodeFloatForKey:(__unsafe_unretained NSString *)key
{
    return [_properties[key] floatValue];
}

- (double)decodeDoubleForKey:(__unsafe_unretained NSString *)key
{
    return [_properties[key] doubleValue];
}

- (const uint8_t *)decodeBytesForKey:(__unsafe_unretained NSString *)key returnedLength:(NSUInteger *)lengthp
{
    __autoreleasing NSData *data = _properties[key];
    *lengthp = [data length];
    return data.bytes;
}

@end


@implementation FCClassDefinition : NSObject

//no encoding implementation needed

@end


@implementation NSObject (FastCoding)

+ (NSArray *)fastCodingKeys
{
    __autoreleasing NSMutableArray *codableKeys = [NSMutableArray array];
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList(self, &propertyCount);
    for (unsigned int i = 0; i < propertyCount; i++)
    {
        //get property
        objc_property_t property = properties[i];
        const char *propertyName = property_getName(property);
        NSString *key = @(propertyName);
        
        //see if there is a backing ivar
        char *ivar = property_copyAttributeValue(property, "V");
        if (ivar)
        {
            //check if ivar has KVC-compliant name
            NSString *ivarName = @(ivar);
            if ([ivarName isEqualToString:key] || [ivarName isEqualToString:[@"_" stringByAppendingString:key]])
            {
                //setValue:forKey: will work
                [codableKeys addObject:key];
            }
            free(ivar);
        }
    }
    free(properties);
    return codableKeys;
}

+ (NSArray *)FC_aggregatePropertyKeys
{
    __autoreleasing NSArray *codableKeys = nil;
    codableKeys = objc_getAssociatedObject(self, _cmd);
    if (codableKeys == nil)
    {
        codableKeys = [NSMutableArray array];
        Class subclass = [self class];
        while (subclass != [NSObject class])
        {
            [(NSMutableArray *)codableKeys addObjectsFromArray:[subclass fastCodingKeys]];
            subclass = [subclass superclass];
        }
        codableKeys = [NSArray arrayWithArray:codableKeys];
        
        //make the association atomically so that we don't need to bother with an @synchronize
        objc_setAssociatedObject(self, _cmd, codableKeys, OBJC_ASSOCIATION_RETAIN);
    }
    return codableKeys;
}

- (id)awakeAfterFastCoding
{
    return self;
}

- (Class)classForFastCoding
{
    return [self classForCoder];
}

- (BOOL)preferFastCoding
{
    return NO;
}

- (void)FC_encodeWithCoder:(__unsafe_unretained FCNSCoder *)coder
{
    if (FCWriteObjectAlias(self, coder)) return;
    
    //handle NSCoding
    if (![self preferFastCoding] && [self conformsToProtocol:@protocol(NSCoding)])
    {
        //write object
        FCWriteType(FCTypeNSCodedObject, coder->_output);
        FCWriteObject(NSStringFromClass([self classForCoder]), coder);
        [(id <NSCoding>)self encodeWithCoder:coder];
        FCWriteType(FCTypeNil, coder->_output);
        FCCacheWrittenObject(self, coder->_objectCache);
        return;
    }
    
    //write class definition
    Class objectClass = [self classForFastCoding];
    NSUInteger classIndex = FCIndexOfCachedObject(objectClass, coder->_classCache);
    __autoreleasing NSArray *propertyKeys = [objectClass FC_aggregatePropertyKeys];
    if (classIndex == NSNotFound)
    {
        classIndex = FCCacheWrittenObject(objectClass, coder->_classCache);
        FCWriteType(FCTypeClassDefinition, coder->_output);
        FCWriteString(NSStringFromClass(objectClass), coder->_output);
        FC_ALIGN_OUTPUT(uint32_t, coder->_output);
        FCWriteUInt32((uint32_t)[propertyKeys count], coder->_output);
        for (__unsafe_unretained id value in propertyKeys)
        {
            FCWriteString(value, coder->_output);
        }
    }
    
    //write object
    FCCacheWrittenObject(self, coder->_objectCache);
    if (classIndex <= UINT8_MAX)
    {
        FCWriteType(FCTypeObject8, coder->_output);
        FCWriteUInt8((uint8_t)classIndex, coder->_output);
    }
    else if (classIndex <= UINT16_MAX)
    {
        FCWriteType(FCTypeObject16, coder->_output);
        FC_ALIGN_OUTPUT(uint16_t, coder->_output);
        FCWriteUInt16((uint16_t)classIndex, coder->_output);
    }
    else
    {
        FCWriteType(FCTypeObject32, coder->_output);
        FC_ALIGN_OUTPUT(uint32_t, coder->_output);
        FCWriteUInt32((uint32_t)classIndex, coder->_output);
    }
    for (__unsafe_unretained NSString *key in propertyKeys)
    {
        FCWriteObject([self valueForKey:key], coder);
    }
}

@end


@implementation NSString (FastCoding)

- (void)FC_encodeWithCoder:(__unsafe_unretained FCNSCoder *)coder
{
    if ([self classForCoder] == [NSMutableString class])
    {
        if (FCWriteObjectAlias(self, coder)) return;
        FCCacheWrittenObject(self, coder->_objectCache);
        FCWriteType(FCTypeMutableString, coder->_output);
    }
    else
    {
        if (FCWriteStringAlias(self, coder)) return;
        FCCacheWrittenObject(self, coder->_stringCache);
        FCWriteType(FCTypeString, coder->_output);
    }
    FCWriteString(self, coder->_output);
}

@end


@implementation NSNumber (FastCoding)

- (void)FC_encodeWithCoder:(__unsafe_unretained FCNSCoder *)coder
{
    switch (CFNumberGetType((CFNumberRef)self))
    {
        case kCFNumberFloat32Type:
        case kCFNumberFloatType:
        {
            FCWriteType(FCTypeFloat32, coder->_output);
            Float32 value = [self floatValue];
            FC_ALIGN_OUTPUT(Float32, coder->_output);
            [coder->_output appendBytes:&value length:sizeof(value)];
            break;
        }
        case kCFNumberFloat64Type:
        case kCFNumberDoubleType:
        case kCFNumberCGFloatType:
        {
            FCWriteType(FCTypeFloat64, coder->_output);
            Float64 value = [self doubleValue];
            FC_ALIGN_OUTPUT(Float64, coder->_output);
            [coder->_output appendBytes:&value length:sizeof(value)];
            break;
        }
        case kCFNumberSInt64Type:
        case kCFNumberLongLongType:
        case kCFNumberNSIntegerType:
        {
            int64_t value = [self longLongValue];
            if (value > (int64_t)INT32_MAX || value < (int64_t)INT32_MIN)
            {
                FCWriteType(FCTypeInt64, coder->_output);
                FC_ALIGN_OUTPUT(int64_t, coder->_output);
                [coder->_output appendBytes:&value length:sizeof(value)];
                break;
            }
            //otherwise treat as 32-bit
        }
        case kCFNumberSInt32Type:
        case kCFNumberIntType:
        case kCFNumberLongType:
        case kCFNumberCFIndexType:
        {
            int32_t value = (int32_t)[self intValue];
            if (value > (int32_t)INT16_MAX || value < (int32_t)INT16_MIN)
            {
                FCWriteType(FCTypeInt32, coder->_output);
                FC_ALIGN_OUTPUT(int32_t, coder->_output);
                [coder->_output appendBytes:&value length:sizeof(value)];
                break;
            }
            //otherwise treat as 16-bit
        }
        case kCFNumberSInt16Type:
        case kCFNumberShortType:
        {
            int16_t value = (int16_t)[self intValue];
            if (value > (int16_t)INT8_MAX || value < (int16_t)INT8_MIN)
            {
                FCWriteType(FCTypeInt16, coder->_output);
                FC_ALIGN_OUTPUT(int16_t, coder->_output);
                [coder->_output appendBytes:&value length:sizeof(value)];
                break;
            }
            //otherwise treat as 8-bit
        }
        case kCFNumberSInt8Type:
        case kCFNumberCharType:
        {
            int8_t value = (int8_t)[self intValue];
            if (value == 1)
            {
                FCWriteType((self == (id)kCFBooleanTrue)? FCTypeTrue: FCTypeOne, coder->_output);
            }
            else if (value == 0)
            {
                FCWriteType((self == (id)kCFBooleanFalse)? FCTypeFalse: FCTypeZero, coder->_output);
            }
            else
            {
                FCWriteType(FCTypeInt8, coder->_output);
                [coder->_output appendBytes:&value length:sizeof(value)];
            }
        }
    }
}

@end


@implementation NSDecimalNumber (FastCoding)

- (void)FC_encodeWithCoder:(__unsafe_unretained FCNSCoder *)coder
{
    FCWriteType(FCTypeDecimalNumber, coder->_output);
    NSDecimal decimal = [self decimalValue];
    FC_ALIGN_OUTPUT(NSDecimal, coder->_output);
    [coder->_output appendBytes:&decimal length:sizeof(decimal)];
}

@end


@implementation NSDate (FastCoding)

- (void)FC_encodeWithCoder:(__unsafe_unretained FCNSCoder *)coder
{
    if (FCWriteObjectAlias(self, coder)) return;
    FCCacheWrittenObject(self, coder->_objectCache);
    FCWriteType(FCTypeDate, coder->_output);
    NSTimeInterval value = [self timeIntervalSince1970];
    FC_ALIGN_OUTPUT(NSTimeInterval, coder->_output);
    [coder->_output appendBytes:&value length:sizeof(value)];
}

@end


@implementation NSData (FastCoding)

- (void)FC_encodeWithCoder:(__unsafe_unretained FCNSCoder *)coder
{
    if (FCWriteObjectAlias(self, coder)) return;
    FCCacheWrittenObject(self, coder->_objectCache);
    FCWriteType(([self classForCoder] == [NSMutableData class])? FCTypeMutableData: FCTypeData, coder->_output);
    uint32_t length = (uint32_t)[self length];
    FC_ALIGN_OUTPUT(uint32_t, coder->_output);
    FCWriteUInt32(length, coder->_output);
    [coder->_output appendData:self];
    coder->_output.length += (4 - ((length % 4) ?: 4));
}

@end


@implementation NSNull (FastCoding)

- (void)FC_encodeWithCoder:(__unsafe_unretained FCNSCoder *)coder
{
    FCWriteType(FCTypeNull, coder->_output);
}

@end


@implementation NSDictionary (FastCoding)

- (void)FC_encodeWithCoder:(__unsafe_unretained FCNSCoder *)coder
{
    if (FCWriteObjectAlias(self, coder)) return;
    
    //alias keypath
    __autoreleasing NSString *aliasKeypath = self[@"$alias"];
    if ([self count] == 1 && aliasKeypath)
    {
        __autoreleasing id node = coder->_rootObject;
        NSArray *parts = [aliasKeypath componentsSeparatedByString:@"."];
        for (__unsafe_unretained NSString *key in parts)
        {
            if ([node isKindOfClass:[NSArray class]])
            {
                node = ((NSArray *)node)[(NSUInteger)[key integerValue]];
            }
            else
            {
                node = [node valueForKey:key];
            }
        }
        FCWriteObject(node, coder);
        return;
    }
    
    //object bootstrapping
    __autoreleasing NSString *className = self[@"$class"];
    if (className)
    {
        //get class definition
        __autoreleasing NSArray *propertyKeys = [[self allKeys] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self != '$class'"]];
        __autoreleasing FCClassDefinition *definition = coder->_classesByName[className];
        if (definition)
        {
            //check that existing class definition contains all keys
            __autoreleasing NSMutableArray *keys = nil;
            for (__unsafe_unretained id key in propertyKeys)
            {
                if (![definition->_propertyKeys containsObject:key])
                {
                    keys = keys ?: [NSMutableArray array];
                    [keys addObject:key];
                }
            }
            propertyKeys = definition->_propertyKeys;
            if (keys)
            {
                //we need to create a new class definition that includes extra keys
                propertyKeys = [propertyKeys arrayByAddingObjectsFromArray:keys];
                definition = nil;
            }
        }
        if (!definition)
        {
            //create class definition
            definition = FC_AUTORELEASE([[FCClassDefinition alloc] init]);
            definition->_className = className;
            definition->_propertyKeys = propertyKeys;
            coder->_classesByName[className] = definition;
        }
        
        //write class definition
        NSUInteger classIndex = FCIndexOfCachedObject(definition, coder->_classCache);
        if (classIndex == NSNotFound)
        {
            classIndex = FCCacheWrittenObject(definition, coder->_classCache);
            FCWriteType(FCTypeClassDefinition, coder->_output);
            FCWriteString(definition->_className, coder->_output);
            FC_ALIGN_OUTPUT(uint32_t, coder->_output);
            FCWriteUInt32((uint32_t)[propertyKeys count], coder->_output);
            for (__unsafe_unretained id key in propertyKeys)
            {
                //convert each to a string using -description, just in case
                FCWriteString([key description], coder->_output);
            }
        }
        
        //write object
        FCCacheWrittenObject(self, coder->_objectCache);
        if (classIndex <= UINT8_MAX)
        {
            FCWriteType(FCTypeObject8, coder->_output);
            FCWriteUInt8((uint8_t)classIndex, coder->_output);
        }
        else if (classIndex <= UINT16_MAX)
        {
            FCWriteType(FCTypeObject16, coder->_output);
            FC_ALIGN_OUTPUT(uint16_t, coder->_output);
            FCWriteUInt16((uint16_t)classIndex, coder->_output);
        }
        else
        {
            FCWriteType(FCTypeObject32, coder->_output);
            FC_ALIGN_OUTPUT(uint32_t, coder->_output);
            FCWriteUInt32((uint32_t)classIndex, coder->_output);
        }
        for (__unsafe_unretained NSString *key in propertyKeys)
        {
            FCWriteObject(self[key], coder);
        }
        return;
    }
    
    //ordinary dictionary
    BOOL mutable = ([self classForCoder] == [NSMutableDictionary class]);
    if (mutable) FCCacheWrittenObject(self, coder->_objectCache);
    FCWriteType(mutable? FCTypeMutableDictionary: FCTypeDictionary, coder->_output);
    FC_ALIGN_OUTPUT(uint32_t, coder->_output);
    FCWriteUInt32((uint32_t)[self count], coder->_output);
    __autoreleasing NSArray *values = [self allValues];
    __autoreleasing NSArray *keys = [self allKeys];
    NSUInteger index = 0;
    for (__unsafe_unretained id value in values)
    {
        FCWriteObject(value, coder);
        FCWriteObject(keys[index++], coder);
    }
    if (!mutable) FCCacheWrittenObject(self, coder->_objectCache);
}

@end


@implementation NSArray (FastCoding)

- (void)FC_encodeWithCoder:(__unsafe_unretained FCNSCoder *)coder
{
    if (FCWriteObjectAlias(self, coder)) return;
    BOOL mutable = ([self classForCoder] == [NSMutableArray class]);
    if (mutable) FCCacheWrittenObject(self, coder->_objectCache);
    FCWriteType(mutable? FCTypeMutableArray: FCTypeArray, coder->_output);
    FC_ALIGN_OUTPUT(uint32_t, coder->_output);
    FCWriteUInt32((uint32_t)[self count], coder->_output);
    for (__unsafe_unretained id value in self)
    {
        FCWriteObject(value, coder);
    }
    if (!mutable) FCCacheWrittenObject(self, coder->_objectCache);
}

@end



@implementation NSSet (FastCoding)

- (void)FC_encodeWithCoder:(__unsafe_unretained FCNSCoder *)coder
{
    if (FCWriteObjectAlias(self, coder)) return;
    BOOL mutable = ([self classForCoder] == [NSMutableSet class]);
    if (mutable) FCCacheWrittenObject(self, coder->_objectCache);
    FCWriteType(mutable? FCTypeMutableSet: FCTypeSet, coder->_output);
    FC_ALIGN_OUTPUT(uint32_t, coder->_output);
    FCWriteUInt32((uint32_t)[self count], coder->_output);
    for (__unsafe_unretained id value in self)
    {
        FCWriteObject(value, coder);
    }
    if (!mutable) FCCacheWrittenObject(self, coder->_objectCache);
}

@end


@implementation NSOrderedSet (FastCoding)

- (void)FC_encodeWithCoder:(__unsafe_unretained FCNSCoder *)coder
{
    if (FCWriteObjectAlias(self, coder)) return;
    BOOL mutable = ([self classForCoder] == [NSMutableOrderedSet class]);
    if (mutable) FCCacheWrittenObject(self, coder->_objectCache);
    FCWriteType(mutable? FCTypeMutableOrderedSet: FCTypeOrderedSet, coder->_output);
    FC_ALIGN_OUTPUT(uint32_t, coder->_output);
    FCWriteUInt32((uint32_t)[self count], coder->_output);
    for (__unsafe_unretained id value in self)
    {
        FCWriteObject(value, coder);
    }
    if (!mutable) FCCacheWrittenObject(self, coder->_objectCache);
}

@end


@implementation NSIndexSet (FastCoding)

- (void)FC_encodeWithCoder:(__unsafe_unretained FCNSCoder *)coder
{
    if (FCWriteObjectAlias(self, coder)) return;
    
    BOOL mutable = ([self classForCoder] == [NSMutableIndexSet class]);
    if (mutable) FCCacheWrittenObject(self, coder->_objectCache);
    
    uint32_t __block rangeCount = 0; // wish we could get this directly from NSIndexSet...
    [self enumerateRangesUsingBlock:^(__unused NSRange range, __unused BOOL *stop) {
        rangeCount ++;
    }];
    
    FCWriteType(mutable? FCTypeMutableIndexSet: FCTypeIndexSet, coder->_output);
    FC_ALIGN_OUTPUT(uint32_t, coder->_output);
    FCWriteUInt32(rangeCount, coder->_output);
    [self enumerateRangesUsingBlock:^(NSRange range, __unused BOOL *stop) {
        FCWriteUInt32((uint32_t)range.location, coder->_output);
        FCWriteUInt32((uint32_t)range.length, coder->_output);
    }];
    
    if (!mutable) FCCacheWrittenObject(self, coder->_objectCache);
}

@end


@implementation NSURL (FastCoding)

- (void)FC_encodeWithCoder:(__unsafe_unretained FCNSCoder *)coder
{
    if (FCWriteStringAlias(self, coder)) return;
    FCWriteType(FCTypeURL, coder->_output);
    FCWriteObject(self.relativeString, coder);
    FCWriteObject(self.baseURL, coder);
    FCCacheWrittenObject(self, coder->_stringCache);
}

@end


@implementation NSValue (FastCoding)

- (void)FC_encodeWithCoder:(__unsafe_unretained FCNSCoder *)coder
{
    FCCacheWrittenObject(self, coder->_objectCache);
    const char *type = [self objCType];
    if (strcmp(type, @encode(CGPoint)) == 0 OR_IF_MAC(strcmp(type, @encode(NSPoint)) == 0))
    {
        CGFloat point[2];
        [self getValue:&point];
        FCWriteType(FCTypePoint, coder->_output);
        FC_ALIGN_OUTPUT(Float64, coder->_output);
        FCWriteDouble((Float64)point[0], coder->_output);
        FCWriteDouble((Float64)point[1], coder->_output);
    }
    else if (strcmp(type, @encode(CGSize)) == 0 OR_IF_MAC(strcmp(type, @encode(NSSize)) == 0))
    {
        CGFloat size[2];
        [self getValue:&size];
        FCWriteType(FCTypeSize, coder->_output);
        FC_ALIGN_OUTPUT(Float64, coder->_output);
        FCWriteDouble((Float64)size[0], coder->_output);
        FCWriteDouble((Float64)size[1], coder->_output);
    }
    else if (strcmp(type, @encode(CGRect)) == 0 OR_IF_MAC(strcmp(type, @encode(NSRect)) == 0))
    {
        CGFloat rect[4];
        [self getValue:&rect];
        FCWriteType(FCTypeRect, coder->_output);
        FC_ALIGN_OUTPUT(Float64, coder->_output);
        FCWriteDouble((Float64)rect[0], coder->_output);
        FCWriteDouble((Float64)rect[1], coder->_output);
        FCWriteDouble((Float64)rect[2], coder->_output);
        FCWriteDouble((Float64)rect[3], coder->_output);
    }
    else if (strcmp(type, @encode(NSRange)) == 0)
    {
        NSUInteger range[2];
        [self getValue:&range];
        FCWriteType(FCTypeRange, coder->_output);
        FC_ALIGN_OUTPUT(uint32_t, coder->_output);
        FCWriteUInt32((uint32_t)range[0], coder->_output);
        FCWriteUInt32((uint32_t)range[1], coder->_output);
    }
    else if (strcmp(type, @encode(CGVector)) == 0)
    {
        CGFloat vector[2];
        [self getValue:&vector];
        FCWriteType(FCTypeVector, coder->_output);
        FC_ALIGN_OUTPUT(Float64, coder->_output);
        FCWriteDouble((Float64)vector[0], coder->_output);
        FCWriteDouble((Float64)vector[1], coder->_output);
    }
    else if (strcmp(type, @encode(CGAffineTransform)) == 0)
    {
        CGFloat transform[6];
        [self getValue:&transform];
        FCWriteType(FCTypeAffineTransform, coder->_output);
        for (NSUInteger i = 0; i < 6; i++)
        {
            FCWriteDouble((Float64)transform[i], coder->_output);
        }
    }
    else if ([@(type) hasPrefix:@"{CATransform3D"])
    {
        CGFloat transform[16];
        [self getValue:&transform];
        FCWriteType(FCType3DTransform, coder->_output);
        FC_ALIGN_OUTPUT(Float64, coder->_output);
        for (NSUInteger i = 0; i < 16; i++)
        {
            FCWriteDouble((Float64)transform[i], coder->_output);
        }
    }
    else
    {
        [NSException raise:FastCodingException format:@"Unable to encode NSValue data of type %s", type];
    }
}

@end


#pragma mark -
#pragma mark legacy decoding


static inline uint32_t FCReadRawUInt32_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_READ_VALUE(uint32_t, *decoder->_offset, decoder->_input, decoder->_total);
    return value;
}

static inline double FCReadRawDouble_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_READ_VALUE(Float64, *decoder->_offset, decoder->_input, decoder->_total);
    return value;
}

static id FCReadRawString_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    __autoreleasing NSString *string = nil;
    NSUInteger length = strlen(decoder->_input + *decoder->_offset) + 1;
    NSUInteger paddedLength = length + (4 - ((length % 4) ?: 4));
    FC_ASSERT_FITS(paddedLength, *decoder->_offset, decoder->_total);
    if (length > 1)
    {
        string = CFBridgingRelease(CFStringCreateWithBytes(NULL, decoder->_input + *decoder->_offset,
                                                           (CFIndex)length - 1, kCFStringEncodingUTF8, false));
    }
    else
    {
        string = @"";
    }
    *decoder->_offset += paddedLength;
    return string;
}

static id FCReadNull_2_3(__unused __unsafe_unretained FCNSDecoder *decoder)
{
    return [NSNull null];
}

static id FCReadAlias_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    return FCCachedObjectAtIndex(FCReadRawUInt32_2_3(decoder), decoder->_objectCache);
}

static id FCReadString_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    NSString *string = FCReadRawString_2_3(decoder);
    FCCacheParsedObject(string, decoder->_objectCache);
    return string;
}

static id FCReadMutableString_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    __autoreleasing NSMutableString *string = nil;
    NSUInteger length = strlen(decoder->_input + *decoder->_offset) + 1;
    NSUInteger paddedLength = length + (4 - ((length % 4) ?: 4));
    FC_ASSERT_FITS(paddedLength, *decoder->_offset, decoder->_total);
    if (length > 1)
    {
        string = FC_AUTORELEASE([[NSMutableString alloc] initWithBytes:decoder->_input + *decoder->_offset length:length - 1 encoding:NSUTF8StringEncoding]);
    }
    else
    {
        string = [NSMutableString string];
    }
    *decoder->_offset += paddedLength;
    FCCacheParsedObject(string, decoder->_objectCache);
    return string;
}

static id FCReadDictionary_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    uint32_t count = FCReadRawUInt32_2_3(decoder);
    __autoreleasing NSDictionary *dict = nil;
    if (count)
    {
        __autoreleasing id *keys = (__autoreleasing id *)malloc(count * sizeof(id));
        __autoreleasing id *objects = (__autoreleasing id *)malloc(count * sizeof(id));
        for (uint32_t i = 0; i < count; i++)
        {
            objects[i] = FCReadObject_2_3(decoder);
            keys[i] = FCReadObject_2_3(decoder);
        }
        
        dict = [NSDictionary dictionaryWithObjects:objects forKeys:keys count:count];
        free(objects);
        free(keys);
    }
    else
    {
        dict = @{};
    }
    FCCacheParsedObject(dict, decoder->_objectCache);
    return dict;
}

static id FCReadMutableDictionary_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    uint32_t count = FCReadRawUInt32_2_3(decoder);
    __autoreleasing NSMutableDictionary *dict = CFBridgingRelease(CFDictionaryCreateMutable(NULL, (CFIndex)count, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks));
    FCCacheParsedObject(dict, decoder->_objectCache);
    for (uint32_t i = 0; i < count; i++)
    {
        __autoreleasing id object = FCReadObject_2_3(decoder);
        __autoreleasing id key = FCReadObject_2_3(decoder);
        CFDictionarySetValue((CFMutableDictionaryRef)dict, (const void *)key, (const void *)object);
    }
    return dict;
}

static id FCReadArray_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    uint32_t count = FCReadRawUInt32_2_3(decoder);
    __autoreleasing NSArray *array = nil;
    if (count)
    {
        __autoreleasing id *objects = (__autoreleasing id *)malloc(count * sizeof(id));
        for (uint32_t i = 0; i < count; i++)
        {
            objects[i] = FCReadObject_2_3(decoder);
        }
        array = [NSArray arrayWithObjects:objects count:count];
        free(objects);
    }
    else
    {
        array = @[];
    }
    FCCacheParsedObject(array, decoder->_objectCache);
    return array;
}

static id FCReadMutableArray_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    uint32_t count = FCReadRawUInt32_2_3(decoder);
    __autoreleasing NSMutableArray *array = [NSMutableArray arrayWithCapacity:count];
    FCCacheParsedObject(array, decoder->_objectCache);
    for (uint32_t i = 0; i < count; i++)
    {
        CFArrayAppendValue((CFMutableArrayRef)array, (void *)FCReadObject_2_3(decoder));
    }
    return array;
}

static id FCReadSet_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    uint32_t count = FCReadRawUInt32_2_3(decoder);
    __autoreleasing NSSet *set = nil;
    if (count)
    {
        __autoreleasing id *objects = (__autoreleasing id *)malloc(count * sizeof(id));
        for (uint32_t i = 0; i < count; i++)
        {
            objects[i] = FCReadObject_2_3(decoder);
        }
        set = [NSSet setWithObjects:objects count:count];
        free(objects);
    }
    else
    {
        set = [NSSet set];
    }
    FCCacheParsedObject(set, decoder->_objectCache);
    return set;
}

static id FCReadMutableSet_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    uint32_t count = FCReadRawUInt32_2_3(decoder);
    __autoreleasing NSMutableSet *set = [NSMutableSet setWithCapacity:count];
    FCCacheParsedObject(set, decoder->_objectCache);
    for (uint32_t i = 0; i < count; i++)
    {
        [set addObject:FCReadObject_2_3(decoder)];
    }
    return set;
}

static id FCReadOrderedSet_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    uint32_t count = FCReadRawUInt32_2_3(decoder);
    __autoreleasing NSOrderedSet *set = nil;
    if (count)
    {
        __autoreleasing id *objects = (__autoreleasing id *)malloc(count * sizeof(id));
        for (uint32_t i = 0; i < count; i++)
        {
            objects[i] = FCReadObject_2_3(decoder);
        }
        set = [NSOrderedSet orderedSetWithObjects:objects count:count];
        free(objects);
    }
    else
    {
        set = [NSOrderedSet orderedSet];
    }
    FCCacheParsedObject(set, decoder->_objectCache);
    return set;
}

static id FCReadMutableOrderedSet_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    uint32_t count = FCReadRawUInt32_2_3(decoder);
    __autoreleasing NSMutableOrderedSet *set = [NSMutableOrderedSet orderedSetWithCapacity:count];
    FCCacheParsedObject(set, decoder->_objectCache);
    for (uint32_t i = 0; i < count; i++)
    {
        [set addObject:FCReadObject_2_3(decoder)];
    }
    return set;
}

static id FCReadTrue_2_3(__unused __unsafe_unretained FCNSDecoder *decoder)
{
    return @YES;
}

static id FCReadFalse_2_3(__unused __unsafe_unretained FCNSDecoder *decoder)
{
    return @NO;
}

static id FCReadInt32_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_READ_VALUE(int32_t, *decoder->_offset, decoder->_input, decoder->_total);
    __autoreleasing NSNumber *number = @(value);
    FCCacheParsedObject(number, decoder->_objectCache);
    return number;
}

static id FCReadInt64_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_READ_VALUE(int64_t, *decoder->_offset, decoder->_input, decoder->_total);
    __autoreleasing NSNumber *number = @(value);
    FCCacheParsedObject(number, decoder->_objectCache);
    return number;
}

static id FCReadFloat32_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_READ_VALUE(Float32, *decoder->_offset, decoder->_input, decoder->_total);
    __autoreleasing NSNumber *number = @(value);
    FCCacheParsedObject(number, decoder->_objectCache);
    return number;
}

static id FCReadFloat64_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_READ_VALUE(Float64, *decoder->_offset, decoder->_input, decoder->_total);
    __autoreleasing NSNumber *number = @(value);
    FCCacheParsedObject(number, decoder->_objectCache);
    return number;
}

static id FCReadData_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    uint32_t length = FCReadRawUInt32_2_3(decoder);
    NSUInteger paddedLength = length + (4 - ((length % 4) ?: 4));
    FC_ASSERT_FITS(paddedLength, *decoder->_offset, decoder->_total);
    __autoreleasing NSData *data = [NSData dataWithBytes:(decoder->_input + *decoder->_offset) length:length];
    *decoder->_offset += paddedLength;
    FCCacheParsedObject(data, decoder->_objectCache);
    return data;
}

static id FCReadMutableData_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    uint32_t length = FCReadRawUInt32_2_3(decoder);
    NSUInteger paddedLength = length + (4 - ((length % 4) ?: 4));
    FC_ASSERT_FITS(paddedLength, *decoder->_offset, decoder->_total);
    __autoreleasing NSMutableData *data = [NSMutableData dataWithBytes:(decoder->_input + *decoder->_offset) length:length];
    *decoder->_offset += paddedLength;
    FCCacheParsedObject(data, decoder->_objectCache);
    return data;
}

static id FCReadDate_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    FC_READ_VALUE(NSTimeInterval, *decoder->_offset, decoder->_input, decoder->_total);
    __autoreleasing NSDate *date = [NSDate dateWithTimeIntervalSince1970:value];
    FCCacheParsedObject(date, decoder->_objectCache);
    return date;
}

static id FCReadClassDefinition_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    __autoreleasing FCClassDefinition *definition = FC_AUTORELEASE([[FCClassDefinition alloc] init]);
    FCCacheParsedObject(definition, decoder->_objectCache);
    definition->_className = FCReadRawString_2_3(decoder);
    uint32_t count = FCReadRawUInt32_2_3(decoder);
    if (count)
    {
        __autoreleasing id *objects = (__autoreleasing id *)malloc(count * sizeof(id));
        for (uint32_t i = 0; i < count; i++)
        {
            objects[i] = FCReadRawString_2_3(decoder);
        }
        __autoreleasing NSArray *propertyKeys = [NSArray arrayWithObjects:objects count:count];
        definition->_propertyKeys = propertyKeys;
        free(objects);
    }
    
    //now return the actual object instance
    return FCReadObject_2_3(decoder);
}

static id FCReadObjectInstance_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    __autoreleasing FCClassDefinition *definition = FCCachedObjectAtIndex(FCReadRawUInt32_2_3(decoder), decoder->_objectCache);
    __autoreleasing Class objectClass = NSClassFromString(definition->_className);
    __autoreleasing id object = nil;
    if (objectClass)
    {
        object = FC_AUTORELEASE([[objectClass alloc] init]);
    }
    else if (definition->_className)
    {
        object = [NSMutableDictionary dictionaryWithObject:definition->_className forKey:@"$class"];
    }
    else if (object)
    {
        object = [NSMutableDictionary dictionary];
    }
    NSUInteger cacheIndex = FCCacheParsedObject(object, decoder->_objectCache);
    for (__unsafe_unretained NSString *key in definition->_propertyKeys)
    {
        [object setValue:FCReadObject_2_3(decoder) forKey:key];
    }
    id newObject = [object awakeAfterFastCoding];
    if (newObject != object)
    {
        //TODO: this is only a partial solution, as any objects that referenced
        //this object between when it was created and now will have received incorrect instance
        FCReplaceCachedObject(cacheIndex, newObject, decoder->_objectCache);
    }
    return newObject;
}

static id FCReadNil_2_3(__unused __unsafe_unretained FCNSDecoder *decoder)
{
    return nil;
}

static id FCReadURL_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    __autoreleasing NSURL *URL = [NSURL URLWithString:FCReadObject_2_3(decoder) relativeToURL:FCReadObject_2_3(decoder)];
    FCCacheParsedObject(URL, decoder->_objectCache);
    return URL;
}

static id FCReadPoint_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    CGPoint point = {(CGFloat)FCReadRawDouble_2_3(decoder), (CGFloat)FCReadRawDouble_2_3(decoder)};
    NSValue *value = [NSValue valueWithBytes:&point objCType:@encode(CGPoint)];
    FCCacheParsedObject(value, decoder->_objectCache);
    return value;
}

static id FCReadSize_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    CGSize size = {(CGFloat)FCReadRawDouble_2_3(decoder), (CGFloat)FCReadRawDouble_2_3(decoder)};
    NSValue *value = [NSValue valueWithBytes:&size objCType:@encode(CGSize)];
    FCCacheParsedObject(value, decoder->_objectCache);
    return value;
}

static id FCReadRect_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    CGRect rect =
    {
        {(CGFloat)FCReadRawDouble_2_3(decoder), (CGFloat)FCReadRawDouble_2_3(decoder)},
        {(CGFloat)FCReadRawDouble_2_3(decoder), (CGFloat)FCReadRawDouble_2_3(decoder)}
    };
    NSValue *value = [NSValue valueWithBytes:&rect objCType:@encode(CGRect)];
    FCCacheParsedObject(value, decoder->_objectCache);
    return value;
}

static id FCReadRange_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    NSRange range = {FCReadRawUInt32_2_3(decoder), FCReadRawUInt32_2_3(decoder)};
    NSValue *value = [NSValue valueWithBytes:&range objCType:@encode(NSRange)];
    FCCacheParsedObject(value, decoder->_objectCache);
    return value;
}

static id FCReadAffineTransform_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    CGAffineTransform transform =
    {
        (CGFloat)FCReadRawDouble_2_3(decoder), (CGFloat)FCReadRawDouble_2_3(decoder),
        (CGFloat)FCReadRawDouble_2_3(decoder), (CGFloat)FCReadRawDouble_2_3(decoder),
        (CGFloat)FCReadRawDouble_2_3(decoder), (CGFloat)FCReadRawDouble_2_3(decoder)
    };
    NSValue *value = [NSValue valueWithBytes:&transform objCType:@encode(CGAffineTransform)];
    FCCacheParsedObject(value, decoder->_objectCache);
    return value;
}

static id FCRead3DTransform_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    CGFloat transform[] =
    {
        (CGFloat)FCReadRawDouble_2_3(decoder), (CGFloat)FCReadRawDouble_2_3(decoder),
        (CGFloat)FCReadRawDouble_2_3(decoder), (CGFloat)FCReadRawDouble_2_3(decoder),
        (CGFloat)FCReadRawDouble_2_3(decoder), (CGFloat)FCReadRawDouble_2_3(decoder),
        (CGFloat)FCReadRawDouble_2_3(decoder), (CGFloat)FCReadRawDouble_2_3(decoder),
        (CGFloat)FCReadRawDouble_2_3(decoder), (CGFloat)FCReadRawDouble_2_3(decoder),
        (CGFloat)FCReadRawDouble_2_3(decoder), (CGFloat)FCReadRawDouble_2_3(decoder),
        (CGFloat)FCReadRawDouble_2_3(decoder), (CGFloat)FCReadRawDouble_2_3(decoder),
        (CGFloat)FCReadRawDouble_2_3(decoder), (CGFloat)FCReadRawDouble_2_3(decoder)
    };
    NSValue *value = [NSValue valueWithBytes:&transform objCType:@encode(CGFloat[16])];
    FCCacheParsedObject(value, decoder->_objectCache);
    return value;
}

static id FCReadMutableIndexSet_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    uint32_t rangeCount = FCReadRawUInt32_2_3(decoder);
    __autoreleasing NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    FCCacheParsedObject(indexSet, decoder->_objectCache);
    for (uint32_t i = 0; i < rangeCount; i++)
    {
        NSRange range = {FCReadRawUInt32_2_3(decoder), FCReadRawUInt32_2_3(decoder)};
        [indexSet addIndexesInRange:range];
    }
    return indexSet;
}

static id FCReadIndexSet_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    __autoreleasing NSIndexSet *indexSet;
    uint32_t rangeCount = FCReadRawUInt32_2_3(decoder);
    if (rangeCount == 1)
    {
        //common case optimisation
        NSRange range = {FCReadRawUInt32_2_3(decoder), FCReadRawUInt32_2_3(decoder)};
        indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
    }
    else
    {
        indexSet = [NSMutableIndexSet indexSet];
        for (uint32_t i = 0; i < rangeCount; i++)
        {
            NSRange range = {FCReadRawUInt32_2_3(decoder), FCReadRawUInt32_2_3(decoder)};
            [(NSMutableIndexSet *)indexSet addIndexesInRange:range];
        }
        indexSet = [indexSet copy];
        
    }
    FCCacheParsedObject(indexSet, decoder->_objectCache);
    return indexSet;
}

static id FCReadNSCodedObject_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    NSString *className = FCReadObject_2_3(decoder);
    NSMutableDictionary *oldProperties = decoder->_properties;
    decoder->_properties = CFBridgingRelease(CFDictionaryCreateMutable(NULL, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks));
    while (true)
    {
        id object = FCReadObject_2_3(decoder);
        if (!object) break;
        NSString *key = FCReadObject_2_3(decoder);
        decoder->_properties[key] = object;
    }
    id object = FC_AUTORELEASE([[NSClassFromString(className) alloc] initWithCoder:decoder]);
    decoder->_properties = oldProperties;
    FCCacheParsedObject(object, decoder->_objectCache);
    return object;
}

static id FCReadObject_2_3(__unsafe_unretained FCNSDecoder *decoder)
{
    static FCTypeConstructor *constructors[] =
    {
        FCReadNull_2_3,
        FCReadAlias_2_3,
        FCReadString_2_3,
        FCReadDictionary_2_3,
        FCReadArray_2_3,
        FCReadSet_2_3,
        FCReadOrderedSet_2_3,
        FCReadTrue_2_3,
        FCReadFalse_2_3,
        FCReadInt32_2_3,
        FCReadInt64_2_3,
        FCReadFloat32_2_3,
        FCReadFloat64_2_3,
        FCReadData_2_3,
        FCReadDate_2_3,
        FCReadMutableString_2_3,
        FCReadMutableDictionary_2_3,
        FCReadMutableArray_2_3,
        FCReadMutableSet_2_3,
        FCReadMutableOrderedSet_2_3,
        FCReadMutableData_2_3,
        FCReadClassDefinition_2_3,
        FCReadObjectInstance_2_3,
        FCReadNil_2_3,
        FCReadURL_2_3,
        FCReadPoint_2_3,
        FCReadSize_2_3,
        FCReadRect_2_3,
        FCReadRange_2_3,
        FCReadAffineTransform_2_3,
        FCRead3DTransform_2_3,
        FCReadMutableIndexSet_2_3,
        FCReadIndexSet_2_3,
        FCReadNSCodedObject_2_3
    };
    
    uint32_t type = FCReadRawUInt32_2_3(decoder);
    if (type > sizeof(constructors))
    {
        [NSException raise:FastCodingException format:@"FastCoding cannot decode object of type: %i", type];
        return nil;
    }
    return constructors[type](decoder);
}
