//
//  XMOpreation.h
//  XMNewsClient
//
//  Created by montnets on 2017/2/27.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMOpreation : NSObject

/** 通过key保存value */
+(void)saveInfo:(NSString *)value WithKey:(NSString *)key;

/** 通过key取出value */
+(NSString *)readInfoWithKey:(NSString *)key;

/** 通过key取出来plist文件里面的内容 */
+(NSArray *)readInfoFormPlist:(NSString *)key;

/** 通过key得到颜色 */
+(UIColor *)ColorWithKey:(NSString *)key;

/** 判断程序是不是第一次进入 */
+(BOOL)AppDelegateIsFrist;

/** 从服务器获取新闻数据 */
+(void)getNewFormServce:(XMNewType)type;

/** 获取电影数据 */
+(void)getMovieFormServce;

/** 获取历史上的今天的数据 */
+(void)getHistoryTodayDataFormServce;

/** 获取段子信息  page:页码  pageSize:每页的数量 */
+(void)getJokeDataFormServceWithPage:(NSInteger)page AndPagesize:(NSInteger)pageSize;

/** 用alelt弹出提示信息 */
//+(void)showAlertMessage:(NSString *)message;

/** 显示自定义的信息 */
+(void)showCustomMessage:(NSString *)message;




@end
