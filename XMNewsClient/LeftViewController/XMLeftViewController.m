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

//显示颜色的视图
@property (nonatomic,weak) UIView *showView;

@end

@implementation XMLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.oneArr = @[@"新闻",@"段子",@"关于",@"我的"];
    self.twoArr = @[@"清除缓存",@"联系我们",@"更换主题"];
    
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
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, XMScreenW - 100, 320) style:UITableViewStylePlain];
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
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"index"] = [NSString stringWithFormat:@"%ld",indexPath.row];
    if (indexPath.section == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:XMLeftViewSelectRowNotification object:dict];
    }else{
        if (indexPath.row == 2) {
            [self addMidView];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:XMLeftViewSelectRowNotification object:nil];
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
//颜色主体的点击按钮
-(void)addMidView{
    UIView *view = [[UIView alloc]init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    view.backgroundColor = [UIColor lightGrayColor];
    view.width = 150;
    view.height = 150;
    view.center = window.center;
    view.alpha = 0.7;
    [window insertSubview:view atIndex:9999];
    self.showView = view;
    CGFloat butWidth = view.width/3;
    CGFloat butHeight = view.height/3;
    for (int i=0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.X =i*butWidth;
        button.Y =0;
        button.width = butWidth;
        button.height = butHeight;
        button.tag=i+100;
        if (i==0) {
            button.backgroundColor = [UIColor redColor];
        }else if (i==1){
            button.backgroundColor = [UIColor greenColor];
        }else{
            button.backgroundColor = [UIColor orangeColor];
        }
        [view addSubview:button];
        
        [button addTarget:self action:@selector(ModelbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)ModelbuttonClick:(UIButton *)but{
    if (but.tag == 100) {
        [XMOpreation saveInfo:@"red" WithKey:XMkey];
    }else if(but.tag == 101){
        [XMOpreation saveInfo:@"green" WithKey:XMkey];
    }else{
        [XMOpreation saveInfo:@"orange" WithKey:XMkey];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:XMLeftViewNightTypeNotification object:nil];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.showView.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf.showView removeFromSuperview];
    }];
}















@end
