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

@property (nonatomic,strong) NSArray *oneArr;

@property (nonatomic,strong) NSArray *twoArr;

@end

@implementation XMLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.oneArr = @[@"新闻",@"段子",@"关于",@"我的"];
    self.twoArr = @[@"夜间模式",@"清除缓存",@"联系我们"];
    
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
    imageView.image= [UIImage imageNamed:@"12"];
    
    [topView addSubview:imageView];
}

-(void)createTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, XMScreenW - 100, 300) style:UITableViewStylePlain];
    tableView.delegate  =self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.backgroundColor = [UIColor whiteColor];
    //禁止滑动
    [tableView setScrollEnabled:NO];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.oneArr.count;
    }
    return self.twoArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = self.oneArr[indexPath.row];
        
    }
    
    if (indexPath.section == 1) {
        cell.textLabel.text = self.twoArr[indexPath.row];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.textLabel.textColor = [UIColor redColor];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *la = [[UILabel alloc]init];
    la.textColor = [UIColor blueColor];
    la.frame = CGRectMake(50, 0, 100, 40);
    if (section == 0) {
        la.text = @"基本功能";
    }else{
        la.text = @"辅助功能";
    }
    return la;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XMLogFun;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"index"] = [NSString stringWithFormat:@"%ld",indexPath.row];
    if (indexPath.section == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:XMLeftViewSelectRowNotification object:dict];
    }
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}




@end
