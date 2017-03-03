//
//  XMOpreation.m
//  XMNewsClient
//
//  Created by montnets on 2017/2/27.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMOpreation.h"
#import "XMHttpRequest.h"


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
    NSArray *strArr = [dict[dir] componentsSeparatedByString:@","];
    return strArr;
}
/** 通过key得到颜色 */
+(UIColor *)ColorWithKey:(NSString *)key{
    if ([XMOpreation AppDelegateIsFrist]) {
        [XMOpreation saveInfo:@"white" WithKey:key];
    }
    //获取plist里面颜色值的字符串
    NSArray *colorArr = [XMOpreation readInfoFormPlist:key];
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
        
        return YES;
    }
    return NO;
}

/** 从服务器获取新闻数据 */
+(void)getNewFormServce:(XMNewType)type{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"key"]=HTTP_NEWS_KEY;
    switch (type) {
        case XMNewTypeTop:
            dict[@"type"] = @"top";
            break;
        case XMNewTypeKeji:
            dict[@"type"] = @"keji";
            break;
        case XMNewTypeShehui:
            dict[@"type"] = @"shehui";
            break;
        case XMNewTypeGuonei:
            dict[@"type"] = @"guonei";
            break;
        case XMNewTypeGuoji:
            dict[@"type"] = @"guoji";
            break;
        case XMNewTypeYule:
            dict[@"type"] = @"yule";
            break;
        case XMNewTypeTiyu:
            dict[@"type"] = @"tiyu";
            break;
        case XMNewTypeJunshi:
            dict[@"type"] = @"junshi";
            break;
        case XMNewTypeShishang:
            dict[@"type"] = @"shishang";
            break;
        case XMNewTypeCaijing:
            dict[@"type"] = @"caijing";
            break;
        default:
            break;
    }
    [[XMHttpRequest shareHttpRequest] beginHttpRequestWithUrl:HTTP_NEWS andParam:dict];
}

/** 获取电影数据 */
+(void)getMovieFormServce{
    [[XMHttpRequest shareHttpRequest] beginHttpRequestWithUrl:HTTP_MOVIE andParam:nil];
}
/** 获取历史上的今天的数据 */
+(void)getHistoryTodayDataFormServce{
    NSArray *arr = [XMOpreation getDate];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"key"] = HTTP_TODAY_KEY;
    dict[@"v"] = @(1.0);
    dict[@"month"] = @([[arr firstObject] intValue]);
    dict[@"day"] = @([[arr lastObject] intValue]);
    [[XMHttpRequest shareHttpRequest] beginHttpRequestWithUrl:HTTP_TODAY andParam:dict];
}

/** 获取日期 */
+(NSArray *)getDate{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned int timeflags = NSCalendarUnitYear|
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:timeflags fromDate:date];
    unsigned int month = (unsigned int)[dateComponent month];
    unsigned int day = (unsigned int)[dateComponent day];
    
    NSMutableArray *Arr = [[NSMutableArray alloc]init];
    [Arr addObject:[NSString stringWithFormat:@"%d",month]];
    [Arr addObject:[NSString stringWithFormat:@"%d",day]];
    return Arr;
}















@end
