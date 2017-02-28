//
//  XMNavigationViewController.m
//  XMNewsClient
//
//  Created by montnets on 2017/2/24.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMNavigationViewController.h"

@interface XMNavigationViewController ()

@end

@implementation XMNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏背景颜色
    [self.navigationBar setBarTintColor:[XMOpreation ColorWithKey:XMkey]];
     [self automaticallyAdjustsScrollViewInsets];
    [self setApperarance];
    //夜间模式的
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChangeNightType) name:XMLeftViewNightTypeNotification object:nil];
}
/** 设置导航条上面的外观  */
-(void)setApperarance{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:17]} forState:UIControlStateNormal];
}

-(void)ChangeNightType{
    UIColor *bgColor = [XMOpreation ColorWithKey:XMkey];
    //设置颜色
    [self.navigationBar setBarTintColor:bgColor];
}





















@end
