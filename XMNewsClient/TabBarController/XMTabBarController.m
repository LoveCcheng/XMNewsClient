//
//  XMTabBarController.m
//  XMNewsClient
//
//  Created by montnets on 2017/2/23.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMTabBarController.h"
#import "XMNewsViewController.h"
#import "XMMeViewController.h"
#import "XMAboutViewController.h"
#import "XMJokeViewController.h"
#import "XMGoodsViewController.h"

#import "XMNavigationViewController.h"

@interface XMTabBarController ()

@property (nonatomic,weak) UIView *hideView;

@end

@implementation XMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self AddChildController];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickConplete) name:XMLeftViewShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickConpleteNO) name:XMLeftViewHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectIndex:) name:XMLeftViewSelectRowNotification object:nil];
    
    
}
-(void)selectIndex:(NSNotification *)noti{
    NSDictionary *dict = noti.object;
    self.selectedIndex = [dict[@"index"] integerValue];
}

-(void)clickConplete{
    [self addVIew];
    [UIView animateWithDuration:0.5 animations:^{
        self.hideView.alpha = 0.5;
    }];
}
-(void)clickConpleteNO{
    [UIView animateWithDuration:0.5 animations:^{
        self.hideView.alpha = 0;
    }];
    [self.hideView removeFromSuperview];
}
/** 添加自控制器 */
-(void)AddChildController{
    XMNewsViewController *newsVC = [[XMNewsViewController alloc]init];
    [self addoneController:newsVC andTitle:@"新闻" andImage:[UIImage imageNamed:@"tab_icon_friend_normal"] andSelectImage:[UIImage imageNamed:@"tab_icon_friend_press"]];
    
    XMJokeViewController *jokeVC = [[XMJokeViewController alloc]init];
    [self addoneController:jokeVC andTitle:@"段子" andImage:[UIImage imageNamed:@"tab_icon_quiz_normal"] andSelectImage:[UIImage imageNamed:@"tab_icon_quiz_press"]];
    
    
    XMAboutViewController *aboutVC = [[XMAboutViewController alloc]init];
    [self addoneController:aboutVC andTitle:@"关于" andImage:[UIImage imageNamed:@"tab_icon_quiz_normal"] andSelectImage:[UIImage imageNamed:@"tab_icon_quiz_press"]];
    
    XMMeViewController *meVC = [[XMMeViewController alloc]init];
    [self addoneController:meVC andTitle:@"我的" andImage:[UIImage imageNamed:@"tab_icon_more_normal"] andSelectImage:[UIImage imageNamed:@"tab_icon_more_press"]];
    
}
/** 添加一个子控制器 */
-(void)addoneController:(UIViewController *)controller andTitle:(NSString *)title andImage:(UIImage *)image andSelectImage:(UIImage *)selectImage{
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = image;
    controller.tabBarItem.selectedImage = [self setImageDisplayModel:selectImage];
    
    XMNavigationViewController *nav = [[XMNavigationViewController alloc]initWithRootViewController:controller];
    [self addChildViewController:nav];
}

/** 设置底部选中图片的默认不渲染 */
-(UIImage *)setImageDisplayModel:(UIImage *)image{
    UIImage *imageModel = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return imageModel;
}
/** 添加灰色的蒙版 */
-(void)addVIew{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 64, XMScreenW, XMScreenH);
    view.backgroundColor = [UIColor grayColor];
    view.alpha=0;
    self.hideView = view;
    [self.view addSubview:view];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}












































@end
