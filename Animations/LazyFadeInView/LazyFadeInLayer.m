//
//  LazyFadeInLayer.m
//  LazyFadeInView
//
//  Created by Tu You on 14-4-20.
//  Copyright (c) 2014年 Tu You. All rights reserved.
//

#import "LazyFadeInLayer.h"
#import <CoreText/CoreText.h>
#import "NSString+LFEmoji.h"

#define LAYER_UPDATE_ANIMATION_MUTATOR(mutator,ctype,propertyName)  \
- (void)mutator (ctype)propertyName \
{ \
if (_##propertyName != propertyName) { \
_##propertyName = propertyName; \
[self _updateAnimation]; \
} \
}

@interface LazyFadeInLayer () {
    BOOL _isAnimating;
}

@property (strong, nonatomic) CADisplayLink *displayLink;
@property (strong, nonatomic) NSMutableArray *alphaArray;
@property (strong, nonatomic) NSMutableAttributedString *attributedString;
@property (strong, nonatomic) NSMutableAttributedString *animatingAttributedString;

@property (strong, nonatomic) NSMutableArray *tmpArray;

@property (assign, nonatomic) NSUInteger frameCount;

@end

@implementation LazyFadeInLayer

@synthesize numberOfLayers = _numberOfLayers;
@synthesize interval = _interval;
@synthesize textColor = _textColor, textFont = _textFont;
@synthesize text = _text, attributes = _attributes;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _numberOfLayers = 6;
        _interval = 0.03;
        _alphaArray = [NSMutableArray array];
        _tmpArray = [NSMutableArray array];
        _textFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
        _textColor = [UIColor colorWithRed:0.24 green:0.48 blue:0.82 alpha:1];
        
        self.contentsScale = [[UIScreen mainScreen] scale];
        self.wrapped = YES;
    }
    return self;
}

LAYER_UPDATE_ANIMATION_MUTATOR(setNumberOfLayers:, NSUInteger, numberOfLayers)
LAYER_UPDATE_ANIMATION_MUTATOR(setText:, NSString *, text)
LAYER_UPDATE_ANIMATION_MUTATOR(setTextColor:, UIColor *, textColor)
LAYER_UPDATE_ANIMATION_MUTATOR(setInterval:, CFTimeInterval, interval)
LAYER_UPDATE_ANIMATION_MUTATOR(setTextFont:, UIFont *, textFont)
LAYER_UPDATE_ANIMATION_MUTATOR(setAttributes:, NSDictionary *, attributes)

- (BOOL)isAnimating
{
    return _isAnimating;
}

- (void)_updateAnimation
{
    if (_text && _text.length != 0) {
        if (self.isAnimating) {
            [self _stopAnimating];
        }
        [self _startAnimating];
    } else {
        if (self.isAnimating) {
            [self _stopAnimating];
        }
    }
}

- (void)_handleParagraphStyle
{
    id style = [_attributes objectForKey:(NSString *)kCTParagraphStyleAttributeName];
    CTParagraphStyleRef paragraphStyle = (__bridge CTParagraphStyleRef)(style);
    if (paragraphStyle) {
        CTTextAlignment textAlignment = kCTTextAlignmentNatural;
        CTParagraphStyleGetValueForSpecifier(paragraphStyle, kCTParagraphStyleSpecifierAlignment, sizeof(textAlignment), &textAlignment);
        if (textAlignment == kCTTextAlignmentLeft) {
            self.alignmentMode = kCAAlignmentLeft;
        } else if (textAlignment == kCTTextAlignmentRight) {
            self.alignmentMode = kCAAlignmentRight;
        } else if (textAlignment == kCTTextAlignmentCenter) {
            self.alignmentMode = kCAAlignmentCenter;
        } else if (textAlignment == kCTTextAlignmentJustified) {
            self.alignmentMode = kCAAlignmentJustified;
        } else if (textAlignment == kCTTextAlignmentNatural) {
            self.alignmentMode = kCAAlignmentNatural;
        }
    } else {
        self.alignmentMode = kCAAlignmentNatural;
    }
}

- (void)_startAnimating
{
    if (_text.length == 0) {
        return;
    }
    
    [self _setupAlphaArray];
    
    self.attributedString = [[NSMutableAttributedString alloc] initWithString:_text attributes:_attributes];
    [self.attributedString removeAttribute:(NSString *)kCTFontAttributeName range:NSMakeRange(0, _text.length)];
    [self.attributedString removeAttribute:(NSString *)kCTForegroundColorAttributeName range:NSMakeRange(0, _text.length)];
    
    //CATextLaye does not support NSParagraphStyleAttributeName or kCTParagraphStyleAttributeName
    [self _handleParagraphStyle];
    
    CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)_textFont.fontName, _textFont.pointSize, NULL);
    [_attributedString addAttribute:(NSString *)kCTFontAttributeName
                              value:(__bridge id)fontRef
                              range:NSMakeRange(0, _text.length)];
    [_attributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(__bridge id)_textColor.CGColor range:NSMakeRange(0, _text.length)];
    CFRelease(fontRef);
    
    _frameCount = 0;
    _animatingAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:_attributedString];
    
    _isAnimating = YES;
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(_frameUpdate:)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)_stopAnimating
{
    _isAnimating = NO;
    self.string = _attributedString;
    [_displayLink invalidate];
    self.displayLink = nil;
    
    // notify the caller the animation has completed
    SEL animationDidEndSelector = NSSelectorFromString(@"lazyFadeInLayerAnimationDidEnd");
    [self.sourceView performSelector:animationDidEndSelector withObject:nil afterDelay:0];
}

- (void)_frameUpdate:(id)sender
{
    _frameCount++;
    
    BOOL isFinished = YES;
    
    CGFloat toColorAlpha = 0.0f;
    CGFloat toColorR = 0.0f;
    CGFloat toColorG = 0.0f;
    CGFloat toColorB = 0.0f;
    
    [_textColor getRed:&toColorR green:&toColorG blue:&toColorB alpha:&toColorAlpha];
    
    for (int i = 0; i < _text.length; ++i) {
        CGFloat currentColorAlpha = [_alphaArray[i] floatValue] + _frameCount * _interval;
        if (isFinished && currentColorAlpha < toColorAlpha) {
            isFinished = NO;
        }
        UIColor *currentColor = [UIColor colorWithRed:toColorR green:toColorG blue:toColorB alpha:currentColorAlpha];
        [_animatingAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName
                                           value:(id)currentColor.CGColor
                                           range:NSMakeRange(i, 1)];
    }
    
    if (isFinished) {
        [self _stopAnimating];
        return;
    }
    
    self.string = (id)_animatingAttributedString;
}

- (void)_setupAlphaArray
{
    if (!_text.length) {
        return;
    }
    
    if (_alphaArray.count) {
        if (_text.length != _alphaArray.count) {
            [self _resetAlphaArray];
        }
    } else {
        [self _resetAlphaArray];
    }
}

- (void)_resetAlphaArray
{
    [_alphaArray removeAllObjects];
    self.alphaArray = [NSMutableArray arrayWithCapacity:_text.length];
    for (int i = 0; i < _text.length; ++i) {
        [_alphaArray addObject:@(MAXFLOAT)];
    }
    
    [self _randomAlphaArray];
}

- (void)_randomAlphaArray
{
    if (!_text.length && _numberOfLayers <= 0) {
        return;
    }
    
    NSUInteger totalCount = _text.length;
    
    NSUInteger tTotalCount = totalCount + 1;
    [_tmpArray removeAllObjects];
    _tmpArray = [NSMutableArray arrayWithCapacity:_numberOfLayers];
    
    for (int i = 0; i < _numberOfLayers - 1; ++i) {
        int k = arc4random() % tTotalCount;
        [_tmpArray addObject:@(k)];
        tTotalCount -= k;
    }
    [_tmpArray addObject:@(tTotalCount - 1)];
    
    for (int i = 0; i < _tmpArray.count; ++i) {
        int count = [_tmpArray[i] intValue];
        CGFloat alpha = -(i * 0.25);
        while (count) {
            int k = arc4random() % totalCount;
            if ([_alphaArray[k] floatValue] > 1) {
                if ([self charIsInEmojAtIndex:k]) {
                    _alphaArray[k] = @(1);
                } else {
                    _alphaArray[k] = @(alpha);
                }
                count--;
            }
        }
    }
}

- (BOOL)charIsInEmojAtIndex:(NSUInteger)index
{
    NSArray *array = [self.text lf_emojiRanges];
    __block BOOL isIn = NO;
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSRange range = ((NSValue *)obj).rangeValue;
        if (index >= range.location && index < range.location + range.length) {
            isIn = YES;
            *stop = YES;
        }
    }];
    return isIn;
}

@end

