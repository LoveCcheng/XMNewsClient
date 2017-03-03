//
//  XMHistoryCell.m
//  XMNewsClient
//
//  Created by montnets on 2017/3/3.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMHistoryCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface XMHistoryCell ()
/** 图片 */
@property (nonatomic,weak) UIImageView *XMimageView;
/** 事件 */
@property (nonatomic,weak) UILabel *EventLabel;
/** 时间 */
@property (nonatomic,weak) UILabel *TimeLabel;

@end

@implementation XMHistoryCell


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUI];
    }
    return self;
}

-(void)SetUI{
    UIImageView *imageViewx = [[UIImageView alloc]init];
    imageViewx.backgroundColor = [UIColor redColor];
    self.XMimageView = imageViewx;
    
    UILabel *eventla= [[UILabel alloc]init];
    eventla.font  =[UIFont systemFontOfSize:13];
    eventla.numberOfLines = 0;
    eventla.backgroundColor = [UIColor blueColor];
    eventla.textColor = [UIColor whiteColor];
    self.EventLabel = eventla;
    
    UILabel *TimeLabel= [[UILabel alloc]init];
    TimeLabel.font  =[UIFont systemFontOfSize:11];
    TimeLabel.backgroundColor = [UIColor yellowColor];
    self.TimeLabel = TimeLabel;
    
    [self.contentView addSubview:self.XMimageView];
    
    [self.contentView addSubview:self.EventLabel];
    
    [self.contentView addSubview:self.TimeLabel];
}


-(void)setHistoryModel:(XMHistoryModel *)HistoryModel{
    _HistoryModel = HistoryModel;

    //赋值操作
    [self.XMimageView sd_setImageWithURL:[NSURL URLWithString:HistoryModel.pic] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    self.EventLabel.text = HistoryModel.title;

}
-(void)layoutSubviews{
    [super layoutSubviews];

    __weak typeof(self)weakSelf = self;
    [self.TimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(weakSelf.contentView).offset(0);
        make.height.equalTo(@20);
    }];
    
    [self.EventLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(weakSelf.contentView).offset(0);
        make.bottom.equalTo(weakSelf.TimeLabel.mas_top).offset(0);
        make.height.equalTo(@50);
    }];
    
    [self.XMimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.equalTo(weakSelf.contentView).offset(0);
        make.bottom.equalTo(weakSelf.EventLabel.mas_top).offset(0);
    }];

}


























@end
