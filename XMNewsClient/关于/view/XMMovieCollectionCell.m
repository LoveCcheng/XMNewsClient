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
@property (nonatomic,weak) UIImageView *imageView;
/** 电影名称 */
@property (nonatomic,weak) UILabel *titleLa;
/** 评分 */
@property (nonatomic,weak) UILabel *ScoreLa;
/** 年份 */
@property (nonatomic,weak) UILabel *yearLa;
/** 类型 */
@property (nonatomic,weak) UILabel *typeLa;

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
    UIImageView *imageView = [[UIImageView alloc]init];
//    imageView.backgroundColor = [UIColor greenColor];
    self.imageView = imageView;
    [self.contentView addSubview:self.imageView];
    
    UILabel *titleLa = [[UILabel alloc]init];
//    titleLa.backgroundColor = [UIColor yellowColor];
    titleLa.font = [UIFont systemFontOfSize:15];
    self.titleLa = titleLa;
    [self.contentView addSubview:self.titleLa];
    
    UILabel *ScoreLa = [[UILabel alloc]init];
//    ScoreLa.backgroundColor = [UIColor yellowColor];
    ScoreLa.font = [UIFont systemFontOfSize:13];
    self.ScoreLa = ScoreLa;
    [self.contentView addSubview:self.ScoreLa];
    
    UILabel *yearLa = [[UILabel alloc]init];
//    yearLa.backgroundColor = [UIColor orangeColor];
    yearLa.font = [UIFont systemFontOfSize:13];
    self.yearLa = yearLa;
    [self.contentView addSubview:self.yearLa];
    
    UILabel *typeLa = [[UILabel alloc]init];
//    typeLa = [UIColor orangeColor];
    typeLa.font = [UIFont systemFontOfSize:15];
    self.typeLa = typeLa;
    [self.contentView addSubview:self.typeLa];
}

-(void)setMoviemodel:(XMMovieModel *)Moviemodel{
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:Moviemodel.images[@"small"]]];
    
    self.titleLa.text = Moviemodel.title;
    
    CGFloat score = [Moviemodel.rating[@"average"] floatValue];
    
    self.ScoreLa.text = [NSString stringWithFormat:@"%0.2f分",score];
    
    self.yearLa.text = [NSString stringWithFormat:@"%@年",Moviemodel.year];
    
    self.typeLa.text =[NSString stringWithFormat:@"类型:%@",Moviemodel.genres.firstObject];
}

-(void)setIsChan:(BOOL)isChan{
    _ischangeone =isChan;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (_ischangeone) {
        self.imageView.X = 5;
        self.imageView.Y = 5;
        self.imageView.width = self.bounds.size.width - 60;
        self.imageView.height = self.bounds.size.width - 60;
        
        self.titleLa.frame = CGRectMake(5, self.bounds.size.width - 45, XMScreenW/2, 20);
        
        self.ScoreLa.frame = CGRectMake(5, self.bounds.size.width - 30, 50, 20);
        
        self.yearLa.frame = CGRectMake(80, self.bounds.size.width - 30, 100, 20);
        
        self.typeLa.frame = CGRectMake(5, self.bounds.size.width - 15, 100, 20);
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
