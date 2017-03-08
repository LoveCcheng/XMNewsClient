//
//  XMHistoryModel.m
//  XMNewsClient
//
//  Created by montnets on 2017/3/3.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMHistoryModel.h"


@implementation XMHistoryModel


+(instancetype)initWithDictionary:(NSDictionary *)dict{
    XMHistoryModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

-(NSString *)description{
    return [NSString stringWithFormat:@"title---%@,pic_url----%@,%@",self.title,self.des,self.pic];
}








































@end
