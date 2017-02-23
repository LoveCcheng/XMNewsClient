//
//  XMSideViewController.h
//  XMLolGames
//
//  Created by montnets on 2016/12/22.
//  Copyright © 2016年 montnets. All rights reserved.
//

/**
   XMSideViewController  ----- 侧滑控制器
 */

#import <UIKit/UIKit.h>

@interface XMSideViewController : UIViewController



/** 左边的控制器 */
@property (nonatomic,strong) UIViewController *LeftViewController;


/** 主控制器 */
@property (nonatomic,strong) UIViewController *MainViewController;


/** 初始化方法----类方法 */
+(instancetype)SideViewControllerWithLeftController:(UIViewController *)leftVC andMainController:(UIViewController *)MainVC;


/** 初始化方法----方法 */
-(instancetype)initWithLeftController:(UIViewController *)leftVC andMainController:(UIViewController *)MainVC;





@end

/** 协议 */

@interface UIViewController (SideSlipViewControllerExtension)

@property (nonatomic, strong) XMSideViewController *sideSlipViewController;

@end
