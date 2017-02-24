//
//  XMSideViewController.m
//  XMLolGames
//
//  Created by montnets on 2016/12/22.
//  Copyright © 2016年 montnets. All rights reserved.
//

#import "XMSideViewController.h"
#import <objc/runtime.h>


/** mainviewController距离右边界的最小宽度 */
#define XMmainControllerSpace 100

/** mainViewController视图的最小比例 */
//#define XMmainControllerScale 0.8
#define XMmainControllerScale 1.0

/** 动画时间 */
#define XManimatedTimeDuration 0.5

@interface XMSideViewController ()
{
    //全局变量，用来记录页面的活动。保证点击和滑动的效果一直存在
    BOOL isClick;
}


@end

@implementation XMSideViewController


+(instancetype)SideViewControllerWithLeftController:(UIViewController *)leftVC andMainController:(UIViewController *)MainVC{
    return [[self alloc]initWithLeftController:leftVC andMainController:MainVC];
}

-(instancetype)initWithLeftController:(UIViewController *)leftVC andMainController:(UIViewController *)MainVC{
    self=[super init];
    if (self) {
        _LeftViewController =leftVC;
        _MainViewController=MainVC;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    isClick = NO;
    self.view.backgroundColor=[UIColor whiteColor];
    
    //3建立关联
    self.LeftViewController.sideSlipViewController=self;
    self.MainViewController.sideSlipViewController=self;
    
    
    //1添加两个控制器视图
    [self.view addSubview:_LeftViewController.view];
    [self.view addSubview:_MainViewController.view];
    
    //2添加拖动手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognizerhandel:)];
    [_MainViewController.view addGestureRecognizer:panGesture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemClickNot) name:XMLeftItemClickNoti object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leftViewhide) name:XMLeftViewSelectRowNotification object:nil];
}
/** 点击导航栏左边按钮对应的处理 */
-(void)itemClickNot{
    isClick = !isClick;
    if (isClick) {
        [UIView animateWithDuration:XManimatedTimeDuration animations:^{
            _MainViewController.view.transform = CGAffineTransformMakeScale(XMmainControllerScale, XMmainControllerScale);
            _MainViewController.view.X = self.view.width - XMmainControllerSpace;
        } completion:^(BOOL finished) {
            [[NSNotificationCenter defaultCenter] postNotificationName:XMLeftViewShowNotification object:nil];
        }];
    }else{
        [UIView animateWithDuration:XManimatedTimeDuration animations:^{
            _MainViewController.view.transform = CGAffineTransformMakeScale(XMmainControllerScale, XMmainControllerScale);
            _MainViewController.view.X =0;
        } completion:^(BOOL finished) {
            [[NSNotificationCenter defaultCenter] postNotificationName:XMLeftViewHideNotification object:nil];
        }];
    }
}


-(void)leftViewhide{
    isClick = !isClick;
    [UIView animateWithDuration:XManimatedTimeDuration animations:^{
        _MainViewController.view.transform = CGAffineTransformMakeScale(XMmainControllerScale, XMmainControllerScale);
        _MainViewController.view.X =0;
    } completion:^(BOOL finished) {
        [[NSNotificationCenter defaultCenter] postNotificationName:XMLeftViewHideNotification object:nil];
    }];
}

/** 处理拖动手势 */
-(void)panGestureRecognizerhandel:(UIPanGestureRecognizer *)panGesture{
    
    //获取mianVC中心店
    CGPoint center = panGesture.view.center;
    //获取拖动的位移
    CGPoint offset = [panGesture translationInView:self.view];
    //main中心店坐标
    CGFloat xCenterOffset = center.x + offset.x;
    
    //边界检查
    if (xCenterOffset < self.view.center.x) {
        xCenterOffset = self.view.center.x;
    }
    //修改mainVC的中心店
    panGesture.view.center = CGPointMake(xCenterOffset, panGesture.view.center.y);
    //清楚位移的叠加
    [panGesture setTranslation:CGPointZero inView:self.view];
    /**
     0<= panRecognizer.view.x/(self.view.width - kMainViewControllerRigthDistance) <= 1
     修改mainView的比例大小
     */
    
    CGFloat scale =  1 - (1 - XMmainControllerScale)*panGesture.view.X/(self.view.width - XMmainControllerSpace);
    
    
    panGesture.view.transform = CGAffineTransformMakeScale(scale, scale);

    //main的   0 <= main.x <= 当前屏幕的width - kMainViewControllerRigthDistance
    if (panGesture.view.X >= 0 && panGesture.view.X <= self.view.width - XMmainControllerSpace)
    {
        //main可以移动的范围
    }
    else
    {
        panGesture.view.X = self.view.width - XMmainControllerSpace;
    }

    //拖动停止的时候判断x的位移
    if (panGesture.state == UIGestureRecognizerStateEnded)
    {
        if (panGesture.view.X < (self.view.width - XMmainControllerSpace)/2)
        {
            //隐藏左边控制器视图
            [self handleLeftViewController:YES animated:YES];
        }
        else
        {
            //显示左边控制器视图
            [self handleLeftViewController:NO animated:YES];
        }
    }
    
}


- (void)handleLeftViewController:(BOOL)hidden animated:(BOOL)animated
{
    //隐藏leftViewController视图
    if (hidden)
    {
        [self hiddenLeftViewController:animated];
    }
    //显示
    else
    {
        [self showLeftViewController:animated];
    }
}
- (void)hiddenLeftViewController:(BOOL)animated
{
    isClick = !isClick;
    //动画
    if (animated)
    {
        [UIView animateWithDuration:XManimatedTimeDuration animations:^{
            //还原
            _MainViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
            _MainViewController.view.X = 0;
            
        } completion:^(BOOL finished) {
             [[NSNotificationCenter defaultCenter] postNotificationName:XMLeftViewHideNotification object:nil];
        }];
    }
    else
    {
        //还原
        _MainViewController.view.X = 0;
        _MainViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }
}

- (void)showLeftViewController:(BOOL)animated
{
    isClick = !isClick;
    if (animated)
    {
        [UIView animateWithDuration:XManimatedTimeDuration animations:^{
            
            _MainViewController.view.transform = CGAffineTransformMakeScale(XMmainControllerScale, XMmainControllerScale);
            _MainViewController.view.X = self.view.width - XMmainControllerSpace;
        } completion:^(BOOL finished) {
             [[NSNotificationCenter defaultCenter] postNotificationName:XMLeftViewShowNotification object:nil];
        }];
    }
    else
    {
        _MainViewController.view.X = self.view.width - XMmainControllerSpace;
        _MainViewController.view.transform = CGAffineTransformMakeScale(XMmainControllerScale, XMmainControllerScale);
    }
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


@end



/** 协议 */

@implementation UIViewController (SideSlipViewControllerExtension)

static char key;

- (void)setSideSlipViewController:(XMSideViewController *)sideSlipViewController
{
    objc_setAssociatedObject(self, &key, sideSlipViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XMSideViewController *)sideSlipViewController
{
    if (self.tabBarController)
    {
        return self.tabBarController.sideSlipViewController;
    }
    else if (self.navigationController)
    {
        return self.navigationController.sideSlipViewController;
    }
    else
    {
        return objc_getAssociatedObject(self, &key);
    }
    
}

-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}


@end






























