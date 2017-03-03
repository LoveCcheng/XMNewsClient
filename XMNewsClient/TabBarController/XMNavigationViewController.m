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

/** 可以在这个方法中拦截所有push的控制器 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //设置非跟控制器的导航条内容---就是被push的控制器
    if (self.viewControllers.count != 0) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [button sizeToFit];
        
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [button addTarget:self action:@selector(NavbuttonClick) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        
        
        //当界面跳转的时候--- 隐藏tabbar(下面的几个导航按钮)
        viewController.hidesBottomBarWhenPushed=YES;
        
    }
    //后调用可以在自己的控制器里修改特殊的样式--可以覆盖上面设置的控制器
    [super pushViewController:viewController animated:animated];
}
-(void)NavbuttonClick{
    [self popViewControllerAnimated:YES];
}
































@end
