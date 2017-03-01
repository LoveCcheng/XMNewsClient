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

/** 从服务器获取数据 */
+(void)getNewFormServce:(NSString *)str;

/** 获取电影数据 */
+(void)getMovieFormServce;


@end
