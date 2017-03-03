//
//  XMNewModel.m
//  XMNewsClient
//
//  Created by montnets on 2017/3/2.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMNewModel.h"

@implementation XMNewModel


+(instancetype)initWithDictionary:(NSDictionary *)dict{
    XMNewModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"title---%@,pic_url----%@,%@",self.title,self.date,self.thumbnail_pic_s];
}


@end
