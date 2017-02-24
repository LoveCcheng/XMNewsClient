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
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
     [self automaticallyAdjustsScrollViewInsets];
    [self setApperarance];
}
/** 设置导航条上面的外观  */
-(void)setApperarance{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:17]} forState:UIControlStateNormal];

}























@end
