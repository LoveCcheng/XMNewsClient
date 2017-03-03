//
//  XMMenuView.h
//  XMNewsClient
//
//  Created by montnets on 2017/3/2.
//  Copyright © 2017年 montnets. All rights reserved.
//

/*****     菜单栏的封装      *****/

#import <UIKit/UIKit.h>

@interface XMMenuView : UIView


/** 标题的数组 */
@property (nonatomic,strong) NSArray *TitleItems;

/** 选中字体的颜色 */
@property (nonatomic,strong) UIColor *SelectTextColor;

/** 字体的颜色 */
@property (nonatomic,strong) UIColor *textColor;

/** 选中的按钮的下标 */
@property (nonatomic,assign) NSInteger selectIndex;

/** 点击按钮的回调 */
@property (nonatomic,copy) void (^MenuViewSelectIndexHandle)(NSInteger index);

@end
