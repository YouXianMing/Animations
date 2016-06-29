//
//  ReplicatorLineAnimationView.h
//  Animations
//
//  Created by YouXianMing on 16/4/12.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    
    kReplicatorLeft,
    kReplicatorRight,
    kReplicatorUp,
    kReplicatorDown
    
} EReplicatorLineDirection;

@interface ReplicatorLineAnimationView : UIView

/**
 *  Animation's direction.
 */
@property (nonatomic) EReplicatorLineDirection  direction;

/**
 *  Animation's speed.
 */
@property (nonatomic) CGFloat           speed;

/**
 *  Animation's image.
 */
@property (nonatomic, strong) UIImage  *image;

/**
 *  Start animation.
 */
- (void)startAnimation;

@end
