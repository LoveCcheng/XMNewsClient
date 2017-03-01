//
//  XMAboutViewController.m
//  XMNewsClient
//
//  Created by montnets on 2017/2/23.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMAboutViewController.h"
#import "XMMovieModel.h"
#import "XMMovieCollectionCell.h"

@interface XMAboutViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) UICollectionView *collectionView;
//是否改变样式
@property (nonatomic,assign) BOOL isChange;

@end

@implementation XMAboutViewController

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
        //滚动方向
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        flowlayout.minimumLineSpacing = 2;
        
        flowlayout.minimumInteritemSpacing = 2;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(2, 64, XMScreenW-4, XMScreenH-4) collectionViewLayout:flowlayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        //注册cell
        [_collectionView registerClass:[XMMovieCollectionCell class] forCellWithReuseIdentifier:@"XMMovieCollectionCell"];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isChange = NO;
    self.navigationItem.title = @"关于";
    [XMOpreation getMovieFormServce];
    [self setRightBaritem];
    self.automaticallyAdjustsScrollViewInsets =YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getMoviedata:) name:XMMovieDataNotification object:nil];
    
}
/** 添加切换显示模式的按钮 */
-(void)setRightBaritem{
    UIBarButtonItem *rightitem = [UIBarButtonItem barButtonWithImage:[UIImage imageNamed:@"product_list_list_btn"] SelectImage:[UIImage imageNamed:@"product_list_grid_btn"] target:self action:@selector(rightBarClick:) ConteollEvent:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightitem;
}

-(void)rightBarClick:(UIButton *)but{
    but.selected = !but.selected;
    self.isChange = !self.isChange;
    [self.collectionView reloadData];
}
/** 获取电影数据 */
-(void)getMoviedata:(NSNotification *)noti{
    NSDictionary *dict = noti.object;
    NSArray *arrData = dict[@"subjects"];
    
    for (int i=0; i<arrData.count; i++) {
        XMMovieModel *model = [XMMovieModel initWithDictionary:arrData[i]];

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
    XMMovieCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XMMovieCollectionCell" forIndexPath:indexPath];
    cell.isChan =self.isChange;
    cell.Moviemodel = self.dataArray[indexPath.row];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isChange) {
        return CGSizeMake((XMScreenW - 6)/2, XMScreenH/4);
    }
    return CGSizeMake(XMScreenW - 4, XMScreenH/6);
}































@end
