//
//  XMNewsViewController.m
//  XMNewsClient
//
//  Created by montnets on 2017/2/23.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMNewsViewController.h"
#import "XMMenuView.h"
#import "XMContentViewController.h"

@interface XMNewsViewController ()<UIScrollViewDelegate>

@property (nonatomic,weak) UIScrollView *contentView;

@property (nonatomic,weak) XMMenuView *menuView;

@end

@implementation XMNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新闻";
    [self SetTitleView];
    self.automaticallyAdjustsScrollViewInsets =NO;
    
    [self SetUPChildViewController];
    
    [self setContentView];
}
/** 设置顶部标签 */
-(void)SetTitleView{
    XMMenuView *menuView = [[XMMenuView alloc]initWithFrame:CGRectMake(0, 64, XMScreenW, 40)];
    menuView.TitleItems = @[@"头条",@"社会",@"国内",@"国际",@"娱乐",@"体育",@"军事",@"科技",@"财经",@"时尚"];
    menuView.selectIndex = 0;
    [self.view addSubview:menuView];
    self.menuView = menuView;
//    __weak XMMenuView *weakMenuView = menuView;
    __weak typeof(self)weakSelf = self;
    [menuView setMenuViewSelectIndexHandle:^(NSInteger index) {
        [weakSelf buttonIndex:index];
    }];
}
/** 初始化子控制器 */
-(void)SetUPChildViewController{
    //头条
    XMContentViewController *toutiaoVC = [[XMContentViewController alloc]init];
    toutiaoVC.NewType = XMNewTypeTop;
    [self addChildViewController:toutiaoVC];
    //社会
    XMContentViewController *shehuiVC = [[XMContentViewController alloc]init];
    shehuiVC.NewType = XMNewTypeShehui;
    [self addChildViewController:shehuiVC];
    //国内
    XMContentViewController *guoneiVC = [[XMContentViewController alloc]init];
    guoneiVC.NewType = XMNewTypeGuonei;
    [self addChildViewController:guoneiVC];
    //国际
    XMContentViewController *guojiVC = [[XMContentViewController alloc]init];
    guojiVC.NewType = XMNewTypeGuoji;
    [self addChildViewController:guojiVC];
    //娱乐
    XMContentViewController *yuleVC = [[XMContentViewController alloc]init];
    yuleVC.NewType = XMNewTypeYule;
    [self addChildViewController:yuleVC];
    //体育
    XMContentViewController *tiyuVC = [[XMContentViewController alloc]init];
    tiyuVC.NewType = XMNewTypeTiyu;
    [self addChildViewController:tiyuVC];
    //军事
    XMContentViewController *junshiVC = [[XMContentViewController alloc]init];
    junshiVC.NewType = XMNewTypeJunshi;
    [self addChildViewController:junshiVC];
    //科技
    XMContentViewController *kejiVC = [[XMContentViewController alloc]init];
    kejiVC.NewType = XMNewTypeKeji;
    [self addChildViewController:kejiVC];
    //财经
    XMContentViewController *caijingVC = [[XMContentViewController alloc]init];
    caijingVC.NewType = XMNewTypeCaijing;
    [self addChildViewController:caijingVC];
    //时尚
    XMContentViewController *shishangVC = [[XMContentViewController alloc]init];
    shishangVC.NewType = XMNewTypeShishang;
    [self addChildViewController:shishangVC];

}
/** 中间显示内容的scrollView */
-(void)setContentView{
    UIScrollView *contentView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width*self.childViewControllers.count, 0);
    self.contentView = contentView;
//    self.contentView.backgroundColor = [UIColor redColor];
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:self.contentView];
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//    XMLog(@"%f",scrollView.contentOffset.x);
    //当前索引
    NSInteger index= scrollView.contentOffset.x/scrollView.width;
    //取出子控制器
    UIViewController *tbVC = self.childViewControllers[index];
    tbVC.view.X = scrollView.contentOffset.x;
    tbVC.view.Y = 0;
    tbVC.view.height = scrollView.height;

    [scrollView addSubview:tbVC.view];
}
//停止减速
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger index=scrollView.contentOffset.x/scrollView.width;
    
    [self buttonIndex:index];
}

-(void)buttonIndex:(NSInteger)index{
    
    self.menuView.selectIndex = index;
    
    CGPoint offset = self.contentView.contentOffset;
    offset.x = index*self.contentView.width;
    
    [self.contentView setContentOffset:offset animated:YES];
}






































@end
