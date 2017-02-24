//
//  UIBarButtonItem+XMBaritem.h
//  XMNewsClient
//
//  Created by montnets on 2017/2/24.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XMBaritem)

/** 把按钮加到导航栏的两边 */
+(UIBarButtonItem *)barButtonWithImage:(UIImage *)image HeightImage:(UIImage *)heightImage target:(id)target action:(SEL)action ConteollEvent:(UIControlEvents)controllEvent;



@end
