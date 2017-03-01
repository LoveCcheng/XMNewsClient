//
//  XMMovieModel.m
//  XMNewsClient
//
//  Created by montnets on 2017/3/1.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMMovieModel.h"

@implementation XMMovieModel

+(instancetype)initWithDictionary:(NSDictionary *)dict{
    XMMovieModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];

    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
-(NSString *)description{
    return [NSString stringWithFormat:@"title---%@,pic_url----%@,%@",self.title,self.year,self.images];
}


@end
