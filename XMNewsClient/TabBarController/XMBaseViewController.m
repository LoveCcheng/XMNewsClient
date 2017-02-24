//
//  XMBaseViewController.m
//  XMNewsClient
//
//  Created by montnets on 2017/2/24.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMBaseViewController.h"

@interface XMBaseViewController ()

@end

@implementation XMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addbarItem];
}
/** 添加左边的按钮 */
-(void)addbarItem{
    UIBarButtonItem *leftItem = [UIBarButtonItem barButtonWithImage:[UIImage imageNamed:@"reveal-icon"] HeightImage:[UIImage imageNamed:@"reveal-icon"] target:self action:@selector(leftBarButtonItemClick) ConteollEvent:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)leftBarButtonItemClick{
    [[NSNotificationCenter defaultCenter] postNotificationName:XMLeftItemClickNoti object:nil];
}

@end
