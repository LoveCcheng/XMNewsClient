//
//  XMJokeViewController.m
//  XMNewsClient
//
//  Created by montnets on 2017/2/24.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMJokeViewController.h"
#import "XMHistoryModel.h"
#import "XMWaterLayout.h"
#import "XMHistoryCell.h"

@interface XMJokeViewController ()<UICollectionViewDataSource,XMWaterLayoutDelegate>

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,weak) UICollectionView *collectionView;

@end

@implementation XMJokeViewController

static NSString * const XMModelCell = @"XMModelCell";

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"段子";
    self.view.backgroundColor = [XMOpreation ColorWithKey:XMkey];
    //发送请求
    [XMOpreation getHistoryTodayDataFormServce];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GetHistoryData:) name:XMHistoryDataNotification object:nil];
    
    [self SetUI];
}
/** 获取数据 */
-(void)GetHistoryData:(NSNotification *)noti{
    NSDictionary *dict = noti.object;
    NSArray *arr = dict[@"result"];
    for (int i=0; i<arr.count; i++) {
        XMHistoryModel *model = [XMHistoryModel initWithDictionary:arr[i]];
        [self.dataArray addObject:model];
    }
    [self.collectionView reloadData];
}

-(void)SetUI{
    //创建布局
    XMWaterLayout *layout = [[XMWaterLayout alloc]init];
    layout.delegate = self;
    //创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.dataSource = self ;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    //注册
    [collectionView registerClass:[XMHistoryCell class] forCellWithReuseIdentifier:XMModelCell];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XMHistoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XMModelCell forIndexPath:indexPath];

    cell.backgroundColor = [UIColor orangeColor];
    
    cell.HistoryModel = self.dataArray[indexPath.item];
    
    return cell;
}

#pragma mark - XMWaterLayoutDelegate
/** 返回cell的高度 */
-(CGFloat)WaterFlowLayout:(XMWaterLayout *)WaterFlowlayout HeightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth{
    CGFloat picH = 20+arc4random_uniform(20);
    CGFloat picW = 10+arc4random_uniform(20);
    CGFloat cellHeight = itemWidth*picH/picW;
    return cellHeight;
}











































@end
