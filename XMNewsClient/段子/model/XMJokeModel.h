//
//  XMJokeModel.h
//  XMNewsClient
//
//  Created by montnets on 2017/3/7.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMJokeModel : NSObject

/** 时间戳 */
@property (nonatomic,copy) NSString *unixtime;

/** 发布时间 */
@property (nonatomic,copy) NSString *updatetime;

/** 笑话内容 */
@property (nonatomic,copy) NSString *content;

+(instancetype)initWithDictionary:(NSDictionary *)dict;


@end
