//
//  UIViewController+XMDealloc.m
//  XMNewsClient
//
//  Created by montnets on 2017/3/6.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "UIViewController+XMDealloc.h"
#import <objc/runtime.h>

@implementation UIViewController (XMDealloc)
/** load类方法是程序运行时这个类被加载到内存中就调用的一个方法，执行比较早，并且不需要我们手动调用。而且这个方法具有唯一性，也就是只会被调用一次，不用担心资源抢夺的问题。 */
+(void)load{
    //dealloc 是限制方法，不能私自改动，所以用@selector(dealloc)，但是可以用NSSelectorFromString(@"dealloc")
    Method methodOne = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
    Method methodTwo = class_getInstanceMethod(self, @selector(XM_dealloc));
    method_exchangeImplementations(methodOne, methodTwo);
}

-(void)XM_dealloc{
    XMLog(@"---移除通知%@",self);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self XM_dealloc];
}
@end
