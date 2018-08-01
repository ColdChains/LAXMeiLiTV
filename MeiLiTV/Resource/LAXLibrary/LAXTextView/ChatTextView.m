//
//  ChatTextView.m
//  TIMChat
//
//  Created by AlexiChen on 16/3/31.
//  Copyright © 2016年 AlexiChen. All rights reserved.
//

#import "ChatTextView.h"

@implementation ChatTextView 

- (instancetype)init
{
    if (self = [super init])
    {
        //lax显示聊天的textview
        self.text = @"";
        self.editable = NO;
        self.scrollEnabled = NO;
        self.delegate = self;
        self.dataDetectorTypes = UIDataDetectorTypeAll;
        self.backgroundColor = [UIColor clearColor];
//        self.backgroundColor = [UIColor orangeColor];
//        self.contentOffset = CGPointMake(0, 8);
//        self.font = [UIFont systemFontOfSize:14];
//        self.layer.cornerRadius = 10;
        self.clipsToBounds = NO;
        self.textContainer.lineFragmentPadding = 0;
        self.textContainerInset = UIEdgeInsetsZero;
        
    }
    return self;
}

- (void)setUP {
    self.editable = NO;
    self.scrollEnabled = NO;
    self.delegate = self;
    self.dataDetectorTypes = UIDataDetectorTypeAll;
    self.textContainerInset = UIEdgeInsetsZero;
//    self.textContainer.lineFragmentPadding = 0;
}

// lax作用是屏蔽UITextView长按，双击等显示菜单问题
- (BOOL)enableLongPressed
{
    return NO;
//    return YES;
}

- (BOOL)shouldPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return [self shouldPerformAction:action withSender:sender];
}

- (BOOL)canBecomeFirstResponder
{
    return [self shouldPerformAction:nil withSender:nil];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    
    [self addUnderline:characterRange];
    NSInteger lo = characterRange.location;
    NSInteger le = characterRange.length;
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:@[[NSNumber numberWithInteger:lo], [NSNumber numberWithInteger:le]] forKeys:@[@"lo", @"le"]];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction:) userInfo:dict repeats:NO];
    
    if ([URL.scheme isEqualToString:@"tel"]) {
        NSLog(@"%@", URL);
        
        NSURL *url = [NSURL URLWithString:@"phone://"];
        // 如果已经安装了这个应用,就跳转
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
        
        return YES;
    }
    return YES;
}

- (void)timerAction:(NSTimer *)timer {
    NSInteger lo = [[[timer userInfo] objectForKey:@"lo"] integerValue];
    NSInteger le = [[[timer userInfo] objectForKey:@"le"] integerValue];
    [self removeUnderline: NSMakeRange(lo, le)];
}

- (void)addUnderline:(NSRange)characterRange {
    NSMutableAttributedString *mustr = [[NSMutableAttributedString alloc] initWithAttributedString: self.attributedText];
    [mustr removeAttribute:NSBackgroundColorAttributeName range:characterRange];
//    [mustr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:characterRange];
//    [mustr addAttribute:NSBackgroundColorAttributeName value:[UIColor redColor] range:characterRange];
    [mustr addAttribute:NSUnderlineStyleAttributeName value:
     [NSNumber numberWithInteger:NSUnderlineStyleSingle | NSUnderlinePatternSolid] range:characterRange];
    self.attributedText = mustr;
}

- (void)removeUnderline:(NSRange)characterRange {
    NSMutableAttributedString *mustr = [[NSMutableAttributedString alloc] initWithAttributedString: self.attributedText];
    [mustr removeAttribute:NSUnderlineStyleAttributeName range:characterRange];
    self.attributedText = mustr;
}

//
//- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
//{
//    DebugLog(@"%@", URL);
////    // 跳到对应人的空间
////    UserInfo *host = [[UserInfo alloc] init];
////    host.avatar = _item.replyForUserAvatar;
////    host.username = _item.replyForUserName;
////    host.uid =  _item.replyForUserId;
////
////    HostHomeViewController *vc = [[HostHomeViewController alloc] initWith:host];
////    [[AppDelegate sharedAppDelegate] pushViewController:vc];
//
//    return NO;
//}

@end
