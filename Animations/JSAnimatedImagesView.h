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

#import <UIKit/UIKit.h>

static const CGFloat JSAnimatedImagesViewDefaultTimePerImage = 5.0f;
static const CGFloat JSAnimatedImagesViewDefaultImageSwappingAnimationDuration = 1.0f;
static const BOOL JSAnimatedImagesViewDefaultMotionAnimationEnabled = YES;

@protocol JSAnimatedImagesViewDataSource;

@interface JSAnimatedImagesView : UIView

@property (nonatomic, weak) id<JSAnimatedImagesViewDataSource> dataSource;

/**
 Time between image transitions.
 @note The default value is `JSAnimatedImagesViewDefaultTimePerImage`
 */
@property (nonatomic, assign) NSTimeInterval timePerImage;

/**
 The time it takes for images to fade out.
 @note The default value is `JSAnimatedImagesViewDefaultImageSwappingAnimationDuration`
 */
@property (nonatomic, assign) NSTimeInterval transitionDuration;

/**
 Indicates weather the image should be zoomed and moved during display time.
 Setting this property affects only upcoming images if the animation has already been started.
 @note The default value is `JSAnimatedImagesViewDefaultMotionAnimationEnabled`
 */
@property (nonatomic, assign) BOOL motionAnimationEnabled;

/**
 The view starts animating automatically when it becomes visible, but you can use this method to start the animations again if you stop them using the `stopAnimating`.
 */
- (void)startAnimating;

/**
 The view automatically stops animating when it goes out of the screen, but you can choose to stop it manually using this method. You can re-start the animation using `startAnimating`.
 */
- (void)stopAnimating;

/**
 Forces `JSAnimatedImagesView` to call the data source methods again.
 You can use this method if the number of images has changed.
 */
- (void)reloadData;

@end

@protocol JSAnimatedImagesViewDataSource

/**
 Implement this method to tell `JSAnimatedImagesView` how many images it has to display.
 @param animatedImagesView The view that is requesting the number of images.
 */
- (NSUInteger)animatedImagesNumberOfImages:(JSAnimatedImagesView *)animatedImagesView;

/**
 Implement this method to provide an image for `JSAnimatedImagesView` to display inmediately after.
 @param animatedImagesView The view that is requesting the image object.
 @param index The index of the image to return. This is a value between `0` and `totalNumberOfImages - 1` (@see `animatedImagesNumberOfImages:`).
 */
- (UIImage *)animatedImagesView:(JSAnimatedImagesView *)animatedImagesView imageAtIndex:(NSUInteger)index;

@end
