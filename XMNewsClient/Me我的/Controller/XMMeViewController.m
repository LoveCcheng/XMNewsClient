//
//  XMMeViewController.m
//  XMNewsClient
//
//  Created by montnets on 2017/2/23.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMMeViewController.h"

@interface XMMeViewController ()

@end

@implementation XMMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    [self setRightnavgiationBar];
}

-(void)setRightnavgiationBar{
    UIBarButtonItem *rightItem = [UIBarButtonItem barButtonWithImage:[UIImage imageNamed:@"mine-moon-icon"] HeightImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(RightBarClick) ConteollEvent:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)RightBarClick{
    
    NSString *str = [XMOpreation readInfoWithKey:XMkey];
    if ([str isEqualToString:@"night"]) {
        [XMOpreation saveInfo:@"white" WithKey:XMkey];
    }else{
        [XMOpreation saveInfo:@"night" WithKey:XMkey];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:XMLeftViewNightTypeNotification object:nil];
}

@end
