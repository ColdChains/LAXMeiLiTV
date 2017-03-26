//
//  LAXAnimation.h
//  LAX_OCAnimation
//
//  Created by 冰凉的枷锁 on 2016/11/18.
//  Copyright © 2016年 liuaoxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define kDuration 0.5
#define kWindow [[UIApplication sharedApplication].delegate window]

typedef enum LAXDirection: NSUInteger {
    LAXDirectionTop = 0,
    LAXDirectionLeft = 1,
    LAXDirectionBottom = 2,
    LAXDirectionRight = 3
} LAXDirection;

@interface LAXAnimation : NSObject

+ (CATransition *)tuijiAnimationWithDirection:(LAXDirection)dir;
+ (CATransition *)fugaiAnimationWithDirection:(LAXDirection)dir;
+ (CATransition *)bowenAnimation;
+ (CATransition *)xishouAnimationWithDirection:(LAXDirection)dir;
+ (CATransition *)lifangtiAnimationWithDirection:(LAXDirection)dir;

+ (CATransition *)defaultAnimationWithDuration:(NSTimeInterval)duration target:(UIView *)view;
+ (CATransition *)animationWithDuration:(NSTimeInterval)duration target:(UIView *)view delegate:(id)delegate type:(NSInteger)type subtype:(NSInteger)subtype;

+ (void)addShakeGestureRecognizer:(UIView *)view;
+ (void)stopShakeWithTouchView:(UIView *)contentView shakeView:(UIView *)shakeView touches:(NSSet<UITouch *> *)touches event:(UIEvent *)event;

@end
