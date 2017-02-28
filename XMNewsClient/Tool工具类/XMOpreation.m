//
//  XMOpreation.m
//  XMNewsClient
//
//  Created by montnets on 2017/2/27.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMOpreation.h"

@implementation XMOpreation


/** 通过key保存value */
+(void)saveInfo:(NSString *)value WithKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults removeObjectForKey:key];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

/** 通过key取出value */
+(NSString *)readInfoWithKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *Value = [defaults stringForKey:key];
    return Value;
}

/** 通过key取出来plist文件里面的内容 */
+(NSArray *)readInfoFormPlist:(NSString *)key{
    NSString *dir = [XMOpreation readInfoWithKey:key];
    NSString *plist =@"colors.plist";
    NSString *path = [NSString stringWithFormat:@"skins/%@/%@",dir,plist];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:nil]];
    //按逗号分隔字符串
    NSArray *strArr = [dict[key] componentsSeparatedByString:@","];
    return strArr;
}

/** 通过key得到颜色 */
+(UIColor *)ColorWithKey:(NSString *)key{
    //得到key
    NSString *keyStr = [XMOpreation readInfoWithKey:XMkey];
    if ([XMOpreation AppDelegateIsFrist]) {
        keyStr = XMkey;
    }
    //获取plist里面颜色值的字符串
    NSArray *colorArr = [XMOpreation readInfoFormPlist:keyStr];
    NSInteger oneColor = [colorArr[0] integerValue];
    NSInteger TwoColor = [colorArr[1] integerValue];
    NSInteger ThreeColor = [colorArr[2] integerValue];
    
    
    return XMrgbColors(oneColor, TwoColor, ThreeColor);
}

/** 判断程序是不是第一次进入 */
+(BOOL)AppDelegateIsFrist{
    //从info.plist文件获取当前版本号
    NSString *currentVersion=[NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    //获取上一次版本号
    NSString *lastVersion=[[NSUserDefaults standardUserDefaults] objectForKey:XMVersion];
    //判断是否相等
    if (![currentVersion isEqualToString:lastVersion]) {
        //保存当前版本信息
        [XMOpreation saveInfo:currentVersion WithKey:XMVersion];
        [XMOpreation saveInfo:@"red" WithKey:XMkey];
        return YES;
    }
    return NO;
}





@end
