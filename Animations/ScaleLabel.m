//
//  ScaleLabel.m
//  Animations
//
//  Created by YouXianMing on 15/12/17.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "ScaleLabel.h"

@interface ScaleLabel ()

@property (nonatomic, strong) UILabel  *backedLabel;
@property (nonatomic, strong) UILabel  *colorLabel;

@end

@implementation ScaleLabel

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _backedLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _colorLabel  = [[UILabel alloc] initWithFrame:self.bounds];
        
        _backedLabel.alpha = 0;
        _colorLabel.alpha  = 0;
        
        _backedLabel.textAlignment = NSTextAlignmentCenter;
        _colorLabel.textAlignment  = NSTextAlignmentCenter;
        
        [self addSubview:_backedLabel];
        [self addSubview:_colorLabel];
    }
    
    return self;
}

- (void)startAnimation {
    
    if (_endScale == 0) {
        
        _endScale = 2.f;
    }
    
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:7 initialSpringVelocity:4 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         _backedLabel.alpha     = 1.f;
                         _backedLabel.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
                         
                         _colorLabel.alpha      = 1.f;
                         _colorLabel.transform  = CGAffineTransformMake(1, 0, 0, 1, 0, 0);;
                         
                     } completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:2 delay:0.5 usingSpringWithDamping:7 initialSpringVelocity:4
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              
                                              _colorLabel.alpha     = 0.f;
                                              _colorLabel.transform = CGAffineTransformMake(_endScale, 0, 0, _endScale, 0, 0);
                                              
                                          } completion:nil];
                     }];
}


#pragma mark - Overwrite getter & setter methods.
@synthesize text = _text;
- (void)setText:(NSString *)text {
    
    _text             = text;
    _backedLabel.text = text;
    _colorLabel.text  = text;
}

- (NSString *)text {
    
    return _text;
}

@synthesize startScale = _startScale;
- (void)setStartScale:(CGFloat)startScale {
    
    _startScale            = startScale;
    _backedLabel.transform = CGAffineTransformMake(startScale, 0, 0, startScale, 0, 0);
    _colorLabel.transform  = CGAffineTransformMake(startScale, 0, 0, startScale, 0, 0);
}

- (CGFloat)startScale {
    
    return _startScale;
}

@synthesize font = _font;
- (void)setFont:(UIFont *)font {
    
    _font             = font;
    _backedLabel.font = font;
    _colorLabel.font  = font;
}

- (UIFont *)font {
    
    return _font;
}

@synthesize backedLabelColor = _backedLabelColor;
- (void)setBackedLabelColor:(UIColor *)backedLabelColor {
    
    _backedLabelColor      = backedLabelColor;
    _backedLabel.textColor = backedLabelColor;
}

@synthesize colorLabelColor = _colorLabelColor;
- (void)setColorLabelColor:(UIColor *)colorLabelColor {
    
    _colorLabelColor      = colorLabelColor;
    _colorLabel.textColor = colorLabelColor;
}

@end
