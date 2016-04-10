/*
 Copyright (c) 2012 JaviSoto (http://www.javisoto.me)

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "JSAnimatedImagesView.h"

#import "MSWeakTimer.h"

#if !__has_feature(objc_arc)
    #error JSAnimatedImagesView requires ARC enabled. Mark the .m file with the objc_arc linker flag.
#endif

static const NSUInteger JSAnimatedImagesViewNoImageDisplayingIndex = -1;

static const CGFloat JSAnimatedImagesViewImageViewsBorderOffset = 10;

@interface JSAnimatedImagesView()
{
    BOOL _animating;
    NSUInteger _totalImages;
    NSUInteger _currentlyDisplayingImageViewIndex;
    NSInteger _currentlyDisplayingImageIndex;

    NSArray *_imageViews;
}

@property (nonatomic, strong) MSWeakTimer *imageSwappingTimer;

@end

@implementation JSAnimatedImagesView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self commonInit];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit
{
    NSMutableArray *imageViews = [NSMutableArray array];
    
    const NSUInteger numberOfImageViews = 2;
    
    for (int i = 0; i < numberOfImageViews; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, -JSAnimatedImagesViewImageViewsBorderOffset, -JSAnimatedImagesViewImageViewsBorderOffset)];

        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;

        [self addSubview:imageView];

        [imageViews addObject:imageView];
    }
         
    _imageViews = imageViews;

    _currentlyDisplayingImageIndex = JSAnimatedImagesViewNoImageDisplayingIndex;
    _timePerImage = JSAnimatedImagesViewDefaultTimePerImage;
    _transitionDuration = JSAnimatedImagesViewDefaultImageSwappingAnimationDuration;
    _motionAnimationEnabled = JSAnimatedImagesViewDefaultMotionAnimationEnabled;
}

#pragma mark - Animations

- (void)startAnimating
{
    NSAssert(self.dataSource != nil, @"You need to set the data source property");
    
    if (!_animating)
    {
        _animating = YES;
        [self.imageSwappingTimer fire];
    }
}

- (void)bringNextImage
{
    NSAssert(_totalImages > 1, @"There should be more than 1 image to swap");
    
    UIImageView *imageViewToHide = [_imageViews objectAtIndex:_currentlyDisplayingImageViewIndex];
    
    _currentlyDisplayingImageViewIndex = _currentlyDisplayingImageViewIndex == 0 ? 1 : 0;
    
    UIImageView *imageViewToShow = [_imageViews objectAtIndex:_currentlyDisplayingImageViewIndex];

    NSUInteger nextImageToShowIndex = _currentlyDisplayingImageIndex;
    
    do
    {
        nextImageToShowIndex = [[self class] randomNumberBetweenNumber:0 andNumber:_totalImages - 1];
    }
    while (nextImageToShowIndex == _currentlyDisplayingImageIndex);
    
    _currentlyDisplayingImageIndex = nextImageToShowIndex;

    UIImage *imageToShow = [self.dataSource animatedImagesView:self imageAtIndex:nextImageToShowIndex];
    NSAssert(imageToShow != nil, @"Must return an image");

    imageViewToShow.image = imageToShow;
    
    static const CGFloat kMovementAndTransitionTimeOffset = 0.1;
    
    /* Move image animation */
    if (self.motionAnimationEnabled) {
        [UIView animateWithDuration:self.timePerImage + self.transitionDuration + kMovementAndTransitionTimeOffset
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationCurveEaseIn
                         animations:^
         {
             NSInteger randomTranslationValueX = [[self class] randomNumberBetweenNumber:0 andNumber:JSAnimatedImagesViewImageViewsBorderOffset] - JSAnimatedImagesViewImageViewsBorderOffset;
             NSInteger randomTranslationValueY = [[self class] randomNumberBetweenNumber:0 andNumber:JSAnimatedImagesViewImageViewsBorderOffset] - JSAnimatedImagesViewImageViewsBorderOffset;
             
             CGAffineTransform translationTransform = CGAffineTransformMakeTranslation(randomTranslationValueX, randomTranslationValueY);
             
             CGFloat randomScaleTransformValue = [[self class] randomNumberBetweenNumber:115 andNumber:120] / 100.0f;
             
             CGAffineTransform scaleTransform = CGAffineTransformMakeScale(randomScaleTransformValue, randomScaleTransformValue);
             
             imageViewToShow.transform = CGAffineTransformConcat(scaleTransform, translationTransform);
         }
                         completion:NULL];
    }
    
    /* Fade animation */
    [UIView animateWithDuration:self.transitionDuration
                          delay:kMovementAndTransitionTimeOffset
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationCurveEaseIn
                     animations:^
     {
         imageViewToShow.alpha = 1.0;
         imageViewToHide.alpha = 0.0;
     }
                     completion:^(BOOL finished)
     {
         if (finished)
         {
             imageViewToHide.transform = CGAffineTransformIdentity;
         }
     }];
}

- (void)reloadData
{
    _totalImages = [self.dataSource animatedImagesNumberOfImages:self];

    // Using the ivar directly. If there's no timer, it's because the animations are stopped.
    [_imageSwappingTimer fire];
}

- (void)stopAnimating
{
    if (_animating)
    {
        self.imageSwappingTimer = nil;

        // Fade all image views out
        [UIView animateWithDuration:self.transitionDuration
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^
         {
             for (UIImageView *imageView in _imageViews)
             {
                 imageView.alpha = 0.0;
             }
         }
                         completion:^(BOOL finished)
         {
             _currentlyDisplayingImageIndex = JSAnimatedImagesViewNoImageDisplayingIndex;
             _animating = NO;
         }];
    }
}

#pragma mark - Parameters

- (void)setDataSource:(id<JSAnimatedImagesViewDataSource>)dataSource
{
    if (dataSource != _dataSource)
    {
        _dataSource = dataSource;
        _totalImages = [_dataSource animatedImagesNumberOfImages:self];
    }
}

#pragma mark - Getters

- (MSWeakTimer *)imageSwappingTimer
{
    if (!_imageSwappingTimer)
    {
        _imageSwappingTimer = [MSWeakTimer scheduledTimerWithTimeInterval:self.timePerImage
                                                                   target:self
                                                                 selector:@selector(bringNextImage)
                                                                 userInfo:nil
                                                                  repeats:YES
                                                            dispatchQueue:dispatch_get_main_queue()];
    }
    
    return _imageSwappingTimer;
}

#pragma mark - View Life Cycle

- (void)didMoveToWindow
{
    const BOOL didAppear = (self.window != nil);

    if (didAppear)
    {
        [self startAnimating];
    }
    else
    {
        [self stopAnimating];
    }
}

#pragma mark - Random Numbers

+ (NSUInteger)randomNumberBetweenNumber:(NSUInteger)minNumber andNumber:(NSUInteger)maxNumber
{
    if (minNumber > maxNumber)
    {
        return [self randomNumberBetweenNumber:maxNumber andNumber:minNumber];
    }
    
    NSUInteger randomInt = (arc4random_uniform((u_int32_t)(maxNumber - minNumber + 1))) + minNumber;
    
    return randomInt;
}

@end
