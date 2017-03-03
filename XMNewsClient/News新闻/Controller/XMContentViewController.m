//
//  XMContentViewController.m
//  XMNewsClient
//
//  Created by montnets on 2017/3/2.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMContentViewController.h"
#import "XMNewModel.h"
#import "XMNewsCell.h"
#import "XMWebViewController.h"

@interface XMContentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,weak) UITableView *tableView;

@end

@implementation XMContentViewController

-(UITableView *)tableView{
    if (!_tableView) {
        UITableView *table=[[UITableView alloc]initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, self.view.frame.size.height-104-49)];
        table.delegate=self;
        table.dataSource=self;
        [self.view addSubview:table];
        [table registerClass:[XMNewsCell class] forCellReuseIdentifier:@"XMNewsCell"];
        _tableView=table;
    }
    return _tableView;
}


-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [XMOpreation getNewFormServce:self.NewType];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GetNewData:) name:XMNewsDataNotification object:nil];
}

-(void)GetNewData:(NSNotification *)noti{
    NSDictionary *dict = noti.object;
    NSArray *arr = dict[@"result"][@"data"];
    for (int i=0; i<arr.count; i++) {
        XMNewModel *model = [XMNewModel initWithDictionary:arr[i]];
        [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XMNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMNewsCell"];
    
    cell.NewsModel = self.dataArray[indexPath.row];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XMNewModel *model = self.dataArray[indexPath.row];
    if ([model.url isEqualToString:@" "]) {
        model.url = @"http://www.baidu.com";
    }
    XMWebViewController *webView = [[XMWebViewController alloc]init];
    webView.url = model.url;
    [self.navigationController pushViewController:webView animated:YES];
}





@end
