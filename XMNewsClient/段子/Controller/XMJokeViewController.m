//
//  XMJokeViewController.m
//  XMNewsClient
//
//  Created by montnets on 2017/2/24.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMJokeViewController.h"
#import "XMJokeModel.h"
#import "XMWaterLayout.h"
#import "XMJokeViewCell.h"

@interface XMJokeViewController ()<XMWaterLayoutDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,weak) UICollectionView *collectionView;

@end

@implementation XMJokeViewController

//-(UICollectionView *)collectionView{
//    if (!_collectionView) {
//        XMWaterLayout *waterLayout = [[XMWaterLayout alloc]init];
//        waterLayout.delegate =self;
//        
//        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:waterLayout];
//        collectionView.dataSource = self;
//        collectionView.backgroundColor = [XMOpreation ColorWithKey:XMkey];
//        
//        [collectionView registerClass:[XMJokeViewCell class] forCellWithReuseIdentifier:@"CollCell"];
//        _collectionView = collectionView;
//    }
//    return _collectionView;
//}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"段子";
    self.view.backgroundColor = [XMOpreation ColorWithKey:XMkey];
    [self setCollection];
    //发送请求
    [XMOpreation getJokeDataFormServceWithPage:1 AndPagesize:10];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBgColor) name:XMLeftViewNightTypeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getJokeData:) name:XMJokeDataNotification object:nil];
}

-(void)setCollection{
    XMWaterLayout *waterLayout = [[XMWaterLayout alloc]init];
    waterLayout.delegate =self;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:waterLayout];
    collectionView.dataSource = self;
    collectionView.backgroundColor = [XMOpreation ColorWithKey:XMkey];
    
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[XMJokeViewCell class] forCellWithReuseIdentifier:@"CollCell"];
    self.collectionView = collectionView;

}

-(void)changeBgColor{
    self.view.backgroundColor = [XMOpreation ColorWithKey:XMkey];
}
-(void)getJokeData:(NSNotification *)noti{
    NSDictionary *dict = noti.object;
    NSArray *arr = dict[@"result"][@"data"];
    for (int i=0; i<arr.count; i++) {
        XMJokeModel *model = [XMJokeModel initWithDictionary:arr[i]];
        
        [self.dataArray addObject:model];
    }
    [self.collectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XMJokeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollCell" forIndexPath:indexPath];
    cell.jokeModel = self.dataArray[indexPath.row];
    return cell;
}

-(CGFloat)WaterFlowLayout:(XMWaterLayout *)WaterFlowlayout HeightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth{
    
    XMJokeModel *model = self.dataArray[index];
    CGSize maxSize = CGSizeMake(itemWidth, MAXFLOAT);
    //计算文字的高度
    CGFloat TextH = [model.content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
    //20是时间的高度
    CGFloat cellH =TextH + 20;
    
    return cellH;
}












@end
