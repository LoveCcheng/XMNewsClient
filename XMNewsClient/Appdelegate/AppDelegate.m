//
//  AppDelegate.m
//  XMNewsClient
//
//  Created by montnets on 2017/2/23.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "AppDelegate.h"
#import "XMLeftViewController.h"
#import "XMSideViewController.h"
#import "XMTabBarController.h"
#import <SMSSDK/SMS_SDK/SMSSDK.h>

//短信验证码的配置
#define SMS_appkey @"1bde216d901c4"
#define SMS_secret @"25daeee68b2acaacf3e0e4ba4c15e32c"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    XMLeftViewController *leftVC = [[XMLeftViewController alloc]init];
    XMTabBarController *tabbarVC = [[XMTabBarController alloc]init];
    
    XMSideViewController *sideVC = [XMSideViewController SideViewControllerWithLeftController:leftVC andMainController:tabbarVC];
    

    self.window.rootViewController = sideVC;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyWindow];
    
    [SMSSDK registerApp:SMS_appkey withSecret:SMS_secret];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
