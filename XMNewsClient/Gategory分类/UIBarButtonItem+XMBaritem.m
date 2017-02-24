//
//  UIBarButtonItem+XMBaritem.m
//  XMNewsClient
//
//  Created by montnets on 2017/2/24.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "UIBarButtonItem+XMBaritem.h"

@implementation UIBarButtonItem (XMBaritem)

+(UIBarButtonItem *)barButtonWithImage:(UIImage *)image HeightImage:(UIImage *)heightImage target:(id)target action:(SEL)action ConteollEvent:(UIControlEvents)controllEvent{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    [but setBackgroundImage:image forState:UIControlStateNormal];
    [but setBackgroundImage:heightImage forState:UIControlStateHighlighted];
    [but sizeToFit];
    [but addTarget:target action:action forControlEvents:controllEvent];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:but];
    return item;
}

@end
