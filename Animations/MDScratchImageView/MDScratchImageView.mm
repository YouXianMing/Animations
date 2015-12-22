//
// Scratch and See 
//
// The project provides en effect when the user swipes the finger over one texture 
// and by swiping reveals the texture underneath it. The effect can be applied for 
// scratch-card action or wiping a misted glass.
//
// Copyright (C) 2012 http://moqod.com Andrew Kopanev <andrew@moqod.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy 
// of this software and associated documentation files (the "Software"), to deal 
// in the Software without restriction, including without limitation the rights 
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
// of the Software, and to permit persons to whom the Software is furnished to do so, 
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all 
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
// PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
// FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
// OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
// DEALINGS IN THE SOFTWARE.
//

#import "MDScratchImageView.h"
#import "MDMatrix.h"

const size_t MDScratchImageViewDefaultRadius			= 30;

typedef void (*FillTileWithPointFunc)( id, SEL, CGPoint );
typedef void (*FillTileWithTwoPointsFunc)(id, SEL, CGPoint, CGPoint);

inline CGPoint fromUItoQuartz(CGPoint point, CGSize frameSize){
	point.y = frameSize.height - point.y;
	return point;
}

inline CGPoint scalePoint(CGPoint point, CGSize previousSize, CGSize currentSize){
	return CGPointMake(currentSize.width * point.x / previousSize.width, currentSize.height * point.y / previousSize.height);
}

@interface MDScratchImageView () {
	size_t				_tilesX;
	size_t				_tilesY;
	int					_tilesFilled;
	CGColorSpaceRef		_colorSpace;
	CGContextRef		_imageContext;
	
	size_t				_radius;
}

@property (nonatomic, strong) MDMatrix			*maskedMatrix;
@property (nonatomic, strong) NSMutableArray    *touchPoints;

- (UIImage *)addTouches:(NSSet *)touches;
- (void)fillTileWithPoint:(CGPoint)point;
- (void)fillTileWithTwoPoints:(CGPoint)begin end:(CGPoint)end;

@end

@implementation MDScratchImageView

#pragma mark - memory management

- (void)dealloc {
	self.maskedMatrix = nil;
    if (NULL != _imageContext) {
        CGContextRelease(_imageContext);
        _imageContext = NULL;
    }
    if (NULL != _colorSpace) {
        CGColorSpaceRelease(_colorSpace);
        _colorSpace = NULL;
    }
    self.touchPoints = nil;
#if !(__has_feature(objc_arc))
	[super dealloc];
#endif
}

#pragma mark - inner initalization

- (void)initialize {
	self.userInteractionEnabled = YES;
	_tilesFilled = 0;
	
	if (nil == self.image) {
		_tilesX = _tilesY = 0;
		self.maskedMatrix = nil;
		if (NULL != _imageContext) {
			CGContextRelease(_imageContext);
            _imageContext = NULL;
		}
		if (NULL != _colorSpace) {
			CGColorSpaceRelease(_colorSpace);
            _colorSpace = NULL;
		}
	} else {
        self.touchPoints = [NSMutableArray array];
		// CGSize size = self.image.size;
		CGSize size = CGSizeMake(self.image.size.width * self.image.scale, self.image.size.height * self.image.scale);
		
		// initalize bitmap context
		if (NULL == _colorSpace) {
			_colorSpace = CGColorSpaceCreateDeviceRGB();
		}
		if (NULL != _imageContext) {
			CGContextRelease(_imageContext);
		}
		_imageContext = CGBitmapContextCreate(0, size.width, size.height, 8, size.width * 4, _colorSpace, kCGImageAlphaPremultipliedLast);
		CGContextDrawImage(_imageContext, CGRectMake(0, 0, size.width, size.height), self.image.CGImage);
		
		int blendMode = kCGBlendModeClear;
		CGContextSetBlendMode(_imageContext, (CGBlendMode) blendMode);
		
		_tilesX = size.width  / (2 * _radius);
		_tilesY = size.height / (2 * _radius);
		
#if !(__has_feature(objc_arc))
		self.maskedMatrix = [[[MDMatrix alloc] initWithMax:MDSizeMake(_tilesX, _tilesY)] autorelease];
#else
		self.maskedMatrix = [[MDMatrix alloc] initWithMax:MDSizeMake(_tilesX, _tilesY)];
#endif
	}
}

#pragma mark -

- (void)setImage:(UIImage *)image radius:(size_t)radius {
	[super setImage:image];
	_radius = radius;
	[self initialize];
}

- (void)setImage:(UIImage *)image {
	if (image != self.image) {
		[self setImage:image radius:MDScratchImageViewDefaultRadius];
	}
}

#pragma mark -

- (CGFloat)maskingProgress {
	return ( ((CGFloat)_tilesFilled) / ((CGFloat)(self.maskedMatrix.max.x * self.maskedMatrix.max.y)) );
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(!self.image){
        return ;
    }
	[super setImage:[self addTouches:touches]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if(!self.image){
        return ;
    }
	[super setImage:[self addTouches:touches]];
}

#pragma mark -
-(CGPoint)normalizeVector:(CGPoint)p{
    float len = sqrt(p.x*p.x + p.y*p.y);
    if(0 == len){return CGPointMake(0, 0);}
    p.x /= len;
    p.y /= len;
    return p;
}

- (UIImage *)addTouches:(NSSet *)touches {
    CGSize size = CGSizeMake(self.image.size.width * self.image.scale, self.image.size.height * self.image.scale);
	CGContextRef ctx = _imageContext;
	
	CGContextSetFillColorWithColor(ctx,[UIColor clearColor].CGColor);
	CGContextSetStrokeColorWithColor(ctx,[UIColor colorWithRed:0 green:0 blue:0 alpha:0].CGColor);
	int tempFilled = _tilesFilled;
    
	// process touches
	for (UITouch *touch in touches) {
		CGContextBeginPath(ctx);
		CGPoint touchPoint = [touch locationInView:self];
        touchPoint = fromUItoQuartz(touchPoint, self.bounds.size);
        touchPoint = scalePoint(touchPoint, self.bounds.size, size);
		
		if(UITouchPhaseBegan == touch.phase){
            [self.touchPoints removeAllObjects];
            [self.touchPoints addObject:[NSValue valueWithCGPoint:touchPoint]];
            [self.touchPoints addObject:[NSValue valueWithCGPoint:touchPoint]];
			// on begin, we just draw ellipse
            CGRect rect = CGRectMake(touchPoint.x - _radius, touchPoint.y - _radius, _radius*2, _radius*2);
			CGContextAddEllipseInRect(ctx, rect);
			CGContextFillPath(ctx);
			static const FillTileWithPointFunc fillTileFunc = (FillTileWithPointFunc) [self methodForSelector:@selector(fillTileWithPoint:)];
			(*fillTileFunc)(self,@selector(fillTileWithPoint:),rect.origin);
		} else if (UITouchPhaseMoved == touch.phase) {
            [self.touchPoints addObject:[NSValue valueWithCGPoint:touchPoint]];
            // then touch moved, we draw superior-width line
            CGContextSetStrokeColor(ctx, CGColorGetComponents([UIColor yellowColor].CGColor));
            CGContextSetLineCap(ctx, kCGLineCapRound);
            CGContextSetLineWidth(ctx, 2 * _radius);
//            CGContextMoveToPoint(ctx, prevPoint.x, prevPoint.y);
//            CGContextAddLineToPoint(ctx, rect.origin.x, rect.origin.y);
            
            while(self.touchPoints.count > 3){
                CGPoint bezier[4];
                bezier[0] = ((NSValue*)self.touchPoints[1]).CGPointValue;
                bezier[3] = ((NSValue*)self.touchPoints[2]).CGPointValue;
                
                CGFloat k = 0.3;
                CGFloat len = sqrt(pow(bezier[3].x - bezier[0].x, 2) + pow(bezier[3].y - bezier[0].y, 2));
                bezier[1] = ((NSValue*)self.touchPoints[0]).CGPointValue;
                bezier[1] = [self normalizeVector:CGPointMake(bezier[0].x - bezier[1].x - (bezier[0].x - bezier[3].x), bezier[0].y - bezier[1].y - (bezier[0].y - bezier[3].y) )];
                bezier[1].x *= len * k;
                bezier[1].y *= len * k;
                bezier[1].x += bezier[0].x;
                bezier[1].y += bezier[0].y;
                
                bezier[2] = ((NSValue*)self.touchPoints[3]).CGPointValue;
                bezier[2] = [self normalizeVector:CGPointMake( (bezier[3].x - bezier[2].x)  - (bezier[3].x - bezier[0].x), (bezier[3].y - bezier[2].y)  - (bezier[3].y - bezier[0].y) )];
                bezier[2].x *= len * k;
                bezier[2].y *= len * k;
                bezier[2].x += bezier[3].x;
                bezier[2].y += bezier[3].y;
                
                CGContextMoveToPoint(ctx, bezier[0].x, bezier[0].y);
                CGContextAddCurveToPoint(ctx, bezier[1].x, bezier[1].y, bezier[2].x, bezier[2].y, bezier[3].x, bezier[3].y);
                
                [self.touchPoints removeObjectAtIndex:0];
            }
            
			CGContextStrokePath(ctx);
            
            CGPoint prevPoint = [touch previousLocationInView:self];
            prevPoint = fromUItoQuartz(prevPoint, self.bounds.size);
            prevPoint = scalePoint(prevPoint, self.bounds.size, size);

			static const FillTileWithTwoPointsFunc fillTileFunc = (FillTileWithTwoPointsFunc) [self methodForSelector:@selector(fillTileWithTwoPoints:end:)];
			(*fillTileFunc)(self,@selector(fillTileWithTwoPoints:end:),touchPoint, prevPoint);
		}
	}

	// was _tilesFilled changed?
	if(tempFilled != _tilesFilled) {
		[_delegate mdScratchImageView:self didChangeMaskingProgress:self.maskingProgress];
	}
	
	CGImageRef cgImage = CGBitmapContextCreateImage(ctx);
	UIImage *image = [UIImage imageWithCGImage:cgImage];
	CGImageRelease(cgImage);
	return image;
}

/* 
 * filling tile with one ellipse
 */
-(void)fillTileWithPoint:(CGPoint) point{
	size_t x,y;
    point.x = MAX( MIN(point.x, self.image.size.width - 1) , 0);
    point.y = MAX( MIN(point.y, self.image.size.height - 1), 0);
	x = point.x * self.maskedMatrix.max.x / self.image.size.width;
	y = point.y * self.maskedMatrix.max.y / self.image.size.height;
	char value = [self.maskedMatrix valueForCoordinates:x y:y];
	if (!value){
		[self.maskedMatrix setValue:1 forCoordinates:x y:y];
		_tilesFilled++;
	}
}

/*
 * filling tile with line
 */
-(void)fillTileWithTwoPoints:(CGPoint)begin end:(CGPoint)end{
	CGFloat incrementerForx,incrementerFory;
	static const FillTileWithPointFunc fillTileFunc = (FillTileWithPointFunc) [self methodForSelector:@selector(fillTileWithPoint:)];
	
	/* incrementers - about size of a tile */
	incrementerForx = (begin.x < end.x ? 1 : -1) * self.image.size.width / _tilesX;
	incrementerFory = (begin.y < end.y ? 1 : -1) * self.image.size.height / _tilesY;
	
	// iterate on points between begin and end
	CGPoint i = begin;
	while(i.x <= MAX(begin.x, end.x) && i.y <= MAX(begin.y, end.y) && i.x >= MIN(begin.x, end.x) && i.y >= MIN(begin.y, end.y)){
		(*fillTileFunc)(self,@selector(fillTileWithPoint:),i);
		i.x += incrementerForx;
		i.y += incrementerFory;
	}
	(*fillTileFunc)(self,@selector(fillTileWithPoint:),end);
}

@end
