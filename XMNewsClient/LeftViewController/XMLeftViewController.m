//
//  XMLeftViewController.m
//  XMNewsClient
//
//  Created by montnets on 2017/2/23.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMLeftViewController.h"

@interface XMLeftViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *tableView;

@end

@implementation XMLeftViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self CreateTopView];
    
    [self createTableView];
}

-(void)CreateTopView{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, XMScreenW-100, 150)];
    topView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:topView];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.width = 100;
    imageView.height =100;
    imageView.Y = 20;
    imageView.centerX = topView.centerX;
    imageView.backgroundColor = [UIColor greenColor];
    imageView.layer.cornerRadius = 50;
    imageView.layer.masksToBounds= YES;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://img2.imgtn.bdimg.com/it/u=4142799652,1018745918&fm=23&gp=0.jpg"]];
    imageView.image= [UIImage imageWithData:data];
    
    [topView addSubview:imageView];
}

-(void)createTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, XMScreenW - 100, 300) style:UITableViewStylePlain];
    tableView.delegate  =self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor redColor];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = @"我是一个人";
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}












@end
