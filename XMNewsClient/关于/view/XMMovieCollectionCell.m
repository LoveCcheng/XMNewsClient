//
//  XMMovieCollectionCell.m
//  XMNewsClient
//
//  Created by montnets on 2017/3/1.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMMovieCollectionCell.h"
#import <UIImageView+WebCache.h>

@interface XMMovieCollectionCell ()
{
    BOOL _ischangeone;
}
/** 图片*/
@property (nonatomic,strong) UIImageView *imageView;
/** 电影名称 */
@property (nonatomic,strong) UILabel *titleLa;
/** 评分 */
@property (nonatomic,strong) UILabel *ScoreLa;
/** 年份 */
@property (nonatomic,strong) UILabel *yearLa;
/** 类型 */
@property (nonatomic,strong) UILabel *typeLa;

@end


@implementation XMMovieCollectionCell


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
        _ischangeone =NO;
        self.contentView.layer.cornerRadius = 5.0;
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.borderWidth = 1.0;
    }
    return self;
}

-(void)setUI{
    self.imageView = [[UIImageView alloc]init];
    
    self.titleLa = [[UILabel alloc]init];

    self.titleLa.font = [UIFont systemFontOfSize:15];

    
    self.ScoreLa = [[UILabel alloc]init];

    self.ScoreLa.font = [UIFont systemFontOfSize:13];


    
    self.yearLa= [[UILabel alloc]init];

    self.yearLa.font = [UIFont systemFontOfSize:13];
    
    self.typeLa = [[UILabel alloc]init];
    self.typeLa.font = [UIFont systemFontOfSize:15];
}

-(void)setMoviemodel:(XMMovieModel *)Moviemodel{
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:Moviemodel.images[@"small"]]];
    
    self.titleLa.text = Moviemodel.title;
    
    CGFloat score = [Moviemodel.rating[@"average"] floatValue];
    
    self.ScoreLa.text = [NSString stringWithFormat:@"%0.1f分",score];
    
    self.yearLa.text = [NSString stringWithFormat:@"%@年",Moviemodel.year];
    
    self.typeLa.text =[NSString stringWithFormat:@"类型:%@",Moviemodel.genres.firstObject];
    //重新布局一下
    [self layoutSubviews];
}

-(void)setIsChan:(BOOL)isChan{
    _ischangeone =isChan;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.titleLa];
    [self.contentView addSubview:self.ScoreLa];
    [self.contentView addSubview:self.yearLa];
    [self.contentView addSubview:self.typeLa];
    
    if (_ischangeone) {
        self.imageView.centerX = self.bounds.size.width/2;
        self.imageView.Y = 5;
        self.imageView.width = self.bounds.size.width - 60;
        self.imageView.height = self.bounds.size.width - 60;
        
        self.titleLa.frame = CGRectMake(20, self.bounds.size.width - 45, XMScreenW/2, 20);
        
        self.ScoreLa.frame = CGRectMake(20, self.bounds.size.width - 30, 50, 20);
        
        self.yearLa.frame = CGRectMake(80, self.bounds.size.width - 30, 100, 20);
        
        self.typeLa.frame = CGRectMake(20, self.bounds.size.width - 15, 100, 20);
    }else{
        self.imageView.X = 5;
        self.imageView.Y = 5;
        self.imageView.width = self.bounds.size.height - 10;
        self.imageView.height = self.bounds.size.height - 10;
        
        self.titleLa.frame = CGRectMake(self.bounds.size.height + 10, 5, XMScreenW/2, 30);
        
        self.ScoreLa.frame = CGRectMake(self.bounds.size.height + 10, 40, 50, 30);
        
        self.yearLa.frame = CGRectMake(self.bounds.size.height + 60, 40, 100, 30);
        
        self.typeLa.frame = CGRectMake(self.bounds.size.height + 10, 75, 100, 30);
    }

}











@end
