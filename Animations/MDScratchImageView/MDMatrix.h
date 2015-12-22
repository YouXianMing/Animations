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

#ifndef _MATRIX_H_
#define _MATRIX_H_
#import <Foundation/Foundation.h>

typedef struct {
	size_t x;
	size_t y;
} MDSize;

MDSize MDSizeMake(size_t x,size_t y){
	MDSize r = {x,y};
	return r;
}

@interface MDMatrix : NSObject

-(id)initWithMaxX:(size_t)x MaxY:(size_t)y;
-(id)initWithMax:(MDSize) maxCoords;

-(char)valueForCoordinates:(size_t)x y:(size_t)y;
-(void)setValue:(char)value forCoordinates:(size_t)x y:(size_t)y;

-(void)fillWithValue:(char)value;

@property (readonly, assign) MDSize			max;

@end

#endif //_MATRIX_H_