//
//  XMMenuView.m
//  XMNewsClient
//
//  Created by montnets on 2017/3/2.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMMenuView.h"

#define BUT_WIDTH 60

@interface XMMenuView ()
/** 滚动的ScrollView */
@property (nonatomic,weak) UIScrollView *menuScrollView;

@end



@implementation XMMenuView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化用
        _SelectTextColor = [UIColor blackColor];
        _textColor = [UIColor redColor];
    }
    return self;
}

-(UIScrollView *)menuScrollView{
    if (!_menuScrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        scrollView.backgroundColor = [UIColor greenColor];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        _menuScrollView = scrollView;
        
    }
    return _menuScrollView;
}

#pragma mark - 接受数据
-(void)setTitleItems:(NSArray *)TitleItems{
    _TitleItems = TitleItems;
    //设置滚动范围
    self.menuScrollView.contentSize = CGSizeMake(BUT_WIDTH*TitleItems.count, self.menuScrollView.frame.size.height);
    
    //动态创建按钮
    for (int i = 0; i<_TitleItems.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(BUT_WIDTH*i, 0, BUT_WIDTH, self.frame.size.height);
        button.backgroundColor = [UIColor orangeColor];
        [button setTitle:TitleItems[i] forState:UIControlStateNormal];
        [button setTitleColor:_textColor forState:UIControlStateNormal];
        [button setTitleColor:_SelectTextColor forState:UIControlStateSelected];
        button.tag = i+1;
        [self.menuScrollView addSubview:button];
        [button addTarget:self action:@selector(TitltButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}
#pragma mark - 按钮点击
-(void)TitltButtonClick:(UIButton *)but{
    NSInteger index = but.tag - 1;
    //点击按钮的中心点
    CGFloat buttonCenterX = but.centerX;
    //按钮处理
    [self menuButtonClick:but];
    //滚动视图的偏移量处理
    [self menuScrollerContentOffsetHandleWithCenterX:buttonCenterX];
    
    _selectIndex = index;
    if (_MenuViewSelectIndexHandle) {
        _MenuViewSelectIndexHandle(index);
    }
}

-(void)setSelectIndex:(NSInteger)selectIndex{
    [self ClearButtonStatus];
    
    UIButton *but = [self.menuScrollView viewWithTag:selectIndex+1];
    but.selected = YES;
    [self menuScrollerContentOffsetHandleWithCenterX:but.centerX];
    

    
}


#pragma mrak - 按钮处理
-(void)menuButtonClick:(UIButton *)button{
    //清除所有按钮的点击状态
    [self ClearButtonStatus];
    button.selected = YES;
}
//清除所有按钮的点击状态
-(void)ClearButtonStatus{
    for (int i = 0; i<_TitleItems.count; i++) {
        UIButton *but = [self.menuScrollView viewWithTag:i+1];
        but.selected = NO;
    }
}
#pragma mark - 滚动视图的偏移量处理
-(void)menuScrollerContentOffsetHandleWithCenterX:(CGFloat)centerX{
    //滚动视图X的偏移量 = 按钮的中心点x - 当前屏幕宽度的一半
    CGFloat xOffset = centerX - self.menuScrollView.frame.size.width/2;
    
    //左边偏移限制:如果按钮的中心点小于屏幕的一半。不能偏移。
    if (centerX < self.menuScrollView.frame.size.width/2)
    {
        xOffset = 0;
    }
    else if (centerX > self.menuScrollView.contentSize.width - self.menuScrollView.frame.size.width/2)
    {
        //最大偏移量
        xOffset = self.menuScrollView.contentSize.width - self.menuScrollView.frame.size.width;
    }
    //修改偏移量
    [self.menuScrollView setContentOffset:CGPointMake(xOffset, 0) animated:YES];
}




@end
