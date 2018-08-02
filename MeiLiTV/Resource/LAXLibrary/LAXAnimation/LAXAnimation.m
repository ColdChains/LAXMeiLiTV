//
//  LAXAnimation.m
//  LAX_OCAnimation
//
//  Created by 冰凉的枷锁 on 2016/11/18.
//  Copyright © 2016年 liuaoxiang. All rights reserved.
//

#import "LAXAnimation.h"

@implementation LAXAnimation

+ (CATransition *)defaultAnimationWithDuration:(NSTimeInterval)duration target:(UIView *)view {
    
    //默认动画
    CATransition *defaultAnimation = [CATransition animation];
    defaultAnimation.timingFunction = UIViewAnimationCurveEaseInOut;
    defaultAnimation.duration = duration;
    defaultAnimation.type = @"pageCurl";
    defaultAnimation.subtype = kCATransitionFromBottom;
    
    //defaultAnimation.delegate = self;
    [view.layer addAnimation:defaultAnimation forKey:@"animation"];
    return defaultAnimation;
    
}

+ (CATransition *)tuijiAnimationWithDirection:(LAXDirection)dir {
    return [self animationWithDuration:kDuration target:kWindow delegate:nil type:1 subtype:dir];
}

+ (CATransition *)fugaiAnimationWithDirection:(LAXDirection)dir {
    return [self animationWithDuration:kDuration target:kWindow delegate:nil type:3 subtype:dir];
}

+ (CATransition *)bowenAnimation {
    return [self animationWithDuration:kDuration target:kWindow delegate:nil type:4 subtype:0];
}

+ (CATransition *)xishouAnimationWithDirection:(LAXDirection)dir {
    return [self animationWithDuration:kDuration target:kWindow delegate:nil type:5 subtype:dir];
}

+ (CATransition *)lifangtiAnimationWithDirection:(LAXDirection)dir {
    return [self animationWithDuration:kDuration target:kWindow delegate:nil type:7 subtype:dir];
}

+ (CATransition *)animationWithDuration:(NSTimeInterval)duration target:(UIView *)view delegate:(nullable id)delegate type:(NSInteger)type subtype:(NSInteger)subtype {
    
    //NSArray *titleArr = @[@"0淡化", @"1推挤", @"2揭开", @"3覆盖", @"4波纹", @"5吸收", @"6翻转", @"7立方体", @"8翻页", @"9反翻页", @"10镜头开", @"11镜头关"];
    NSArray *typeArr = @[kCATransitionFade, kCATransitionPush, kCATransitionReveal, kCATransitionMoveIn, @"rippleEffect", @"suckEffect", @"oglFlip", @"cube", @"pageCurl", @"pageUnCurl", @"cameraIrisHollowOpen", @"cameraIrisHollowClose"];
    NSArray *subtypeArr = @[kCATransitionFromTop, kCATransitionFromLeft, kCATransitionFromBottom, kCATransitionFromRight];
    
    CATransition *defaultAnimation = [CATransition animation];
    defaultAnimation.delegate = delegate;
    defaultAnimation.duration = duration;
    defaultAnimation.timingFunction = UIViewAnimationCurveEaseInOut;
    
    if (type >= 0 && type < 12) {
        defaultAnimation.type = typeArr[type];
    }
    if (subtype >= 0 && subtype < 4) {
        defaultAnimation.subtype = subtypeArr[subtype];
    }
    
    [view.layer addAnimation:defaultAnimation forKey:@"animation"];
    return defaultAnimation;
    
}

+ (void)addShakeGestureRecognizer:(UIView *)view {
    
    //向view添加长按手势
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
    longPress.minimumPressDuration = 1;
    
    [view addGestureRecognizer:longPress];
    view.userInteractionEnabled = YES;
    
}

+ (void)startShake:(UIView *)view {
    
    //创建动画对象,绕Z轴旋转
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //设置属性，周期时长
    [animation setDuration:0.08];
    //抖动角度
    animation.fromValue = @(-M_1_PI/2);
    animation.toValue = @(M_1_PI/2);
    //重复次数，无限大
    animation.repeatCount = HUGE_VAL;
    //恢复原样
    animation.autoreverses = YES;
    //锚点设置为图片中心，绕中心抖动
    view.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    [view.layer addAnimation:animation forKey:@"rotation"];
    
}

+ (void)gestureAction:(UILongPressGestureRecognizer *)sender {
    
    CABasicAnimation *animation = (CABasicAnimation *)[sender.view.layer animationForKey:@"rotation"];
    
    if (animation == nil) {
        [self startShake:sender.view];
    }else {
        sender.view.layer.speed = 1.0;
    }
    
}

+ (void)stopShakeWithTouchView:(UIView *)contentView shakeView:(UIView *)shakeView touches:(NSSet<UITouch *> *)touches event:(UIEvent *)event {
    
    //判断touch点是否在imageView内，在的话，仍然抖动，否则停止抖动
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:contentView];
    CGPoint p = [contentView convertPoint:point toView:shakeView];
    //NSLog(@"%d,%d", p.x, p.y);
    
    if (![shakeView pointInside:p withEvent:event]) {
        shakeView.layer.speed = 0.0;
    }
    
}

@end
