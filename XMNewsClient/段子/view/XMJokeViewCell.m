//
//  XMJokeViewCell.m
//  XMNewsClient
//
//  Created by montnets on 2017/3/7.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMJokeViewCell.h"
#import <Masonry.h>

@interface XMJokeViewCell ()

/** 内容 */
@property (nonatomic,weak) UILabel *ContentLa;
/** 时间 */
@property (nonatomic,weak) UILabel *TimeLa;

@end

@implementation XMJokeViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
//        self.contentView.backgroundColor = [UIColor grayColor];
        self.contentView.layer.cornerRadius = 5.0f;
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.borderColor = [UIColor grayColor].CGColor;
        self.contentView.layer.borderWidth = 1;
    }
    return self;
}

-(void)setUI{
    UILabel *contentLa = [[UILabel alloc]init];
    contentLa.font = [UIFont systemFontOfSize:16];
    contentLa.textAlignment = NSTextAlignmentLeft;
    contentLa.textColor = [UIColor blackColor];
    contentLa.numberOfLines = 0;
    self.ContentLa = contentLa;
    
    UILabel *TimeLa = [[UILabel alloc]init];
    TimeLa.font = [UIFont systemFontOfSize:14];
    TimeLa.textAlignment = NSTextAlignmentCenter;
    TimeLa.textColor = [UIColor greenColor];
    self.TimeLa = TimeLa;
    
    [self.contentView addSubview:self.ContentLa];
    [self.contentView addSubview:self.TimeLa];
}

-(void)setJokeModel:(XMJokeModel *)jokeModel{
    _jokeModel = jokeModel;
    self.ContentLa.text = jokeModel.content;
    self.TimeLa.text = jokeModel.updatetime;
}

-(void)layoutSubviews{
    [super layoutSubviews];

    __weak typeof(self)weakSelf = self;
    [self.ContentLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weakSelf.contentView).offset(0);
        make.right.equalTo(weakSelf.contentView).offset(0);
    }];
    
    [self.TimeLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.ContentLa.mas_bottom).offset(0);
        make.left.right.equalTo(weakSelf.contentView).offset(0);
        make.height.equalTo(@20);
    }];
}














@end
