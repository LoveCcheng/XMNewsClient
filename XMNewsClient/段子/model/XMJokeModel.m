//
//  XMJokeModel.m
//  XMNewsClient
//
//  Created by montnets on 2017/3/7.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMJokeModel.h"

@implementation XMJokeModel

+(instancetype)initWithDictionary:(NSDictionary *)dict{
    XMJokeModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];

    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"title---%@,pic_url----%@,%@",self.updatetime,self.content,self.unixtime];
}


































@end
