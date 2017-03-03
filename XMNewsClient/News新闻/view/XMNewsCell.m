//
//  XMNewsCell.m
//  XMNewsClient
//
//  Created by montnets on 2017/3/2.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMNewsCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>


@interface XMNewsCell ()

@property (nonatomic,weak) UIImageView *imageViewV;

@property (nonatomic,weak) UILabel *ContentLa;

@property (nonatomic,weak) UILabel *aothurLa;

@property (nonatomic,weak) UILabel *dataLa;

@end


@implementation XMNewsCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    UIImageView *imageViewH= [[UIImageView alloc]init];
    imageViewH.backgroundColor = [UIColor redColor];
    imageViewH.layer.cornerRadius = 5.0;
    imageViewH.layer.masksToBounds = YES;
    self.imageViewV = imageViewH;
    [self.contentView addSubview:self.imageViewV];
    
    
    UILabel *contentLa = [[UILabel alloc]init];
    contentLa.textColor = [UIColor blackColor];
    contentLa.font = [UIFont systemFontOfSize:16];
    contentLa.numberOfLines = 2;
    self.ContentLa = contentLa;
    [self.contentView addSubview:self.ContentLa];
    
    UILabel *aothurLa = [[UILabel alloc]init];
    aothurLa.textColor = [UIColor lightGrayColor];
    aothurLa.font = [UIFont systemFontOfSize:13];
    self.aothurLa = aothurLa;
    [self.contentView addSubview:self.aothurLa];

    
    UILabel *dataLa = [[UILabel alloc]init];
    dataLa.textColor = [UIColor lightGrayColor];
    dataLa.font = [UIFont systemFontOfSize:13];
    self.dataLa = dataLa;
    [self.contentView addSubview:self.dataLa];
}


-(void)setNewsModel:(XMNewModel *)NewsModel{
    _NewsModel = NewsModel;
    
    [self.imageViewV sd_setImageWithURL:[NSURL URLWithString:NewsModel.thumbnail_pic_s] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    self.ContentLa.text = NewsModel.title;
    
    self.aothurLa.text = NewsModel.author_name;
    
    self.dataLa.text = [NSString stringWithFormat:@"%@",NewsModel.date];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof(self)weakSelf = self;
    
    [self.imageViewV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(10);
        make.right.equalTo(weakSelf.contentView).offset(-10);
        make.height.equalTo(@80);
        make.width.equalTo(@80);
    }];
    
    [self.ContentLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(10);
        make.left.equalTo(weakSelf.contentView).offset(10);
        make.right.equalTo(weakSelf.imageViewV.mas_left).offset(-15);
    }];
    
    [self.aothurLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.ContentLa.mas_bottom).offset(30);
        make.left.equalTo(weakSelf.contentView).offset(10);
    }];
//
    [self.dataLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.ContentLa.mas_bottom).offset(30);
        make.left.equalTo(weakSelf.aothurLa.mas_right).offset(20);
    }];

}





















- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
