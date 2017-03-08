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

/** 获取段子信息 */
+(void)getJokeDataFormServceWithPage:(NSInteger)page AndPagesize:(NSInteger)pageSize{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"key"] = HTTP_JOKE_KEY;
    dict[@"sort"] = @"desc";
    dict[@"page"] = [NSString stringWithFormat:@"%ld",page];
    dict[@"pagesize"] = [NSString stringWithFormat:@"%ld",pageSize];
    //获取时间戳
    NSTimeInterval dateTime = [[NSDate date] timeIntervalSince1970];
//    XMLog(@"--%0.2f",date);
    dict[@"time"] = [NSString stringWithFormat:@"%.0f",dateTime];
    [[XMHttpRequest shareHttpRequest] beginHttpRequestWithUrl:HTTP_JOKE andParam:dict];
}


/** 用alelt弹出提示信息 */
/*
+(void)showAlertMessage:(NSString *)message{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES
                                                                               completion:nil];
}
 */

/** 显示自定义的信息 */
+(void)showCustomMessage:(NSString *)message{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *showView = [[UIView alloc]init];
    showView.backgroundColor = [UIColor blackColor];
    showView.alpha = 1.0f;
    showView.width = 120;
    showView.height = 50;
    showView.center = CGPointMake(XMScreenW*0.5, XMScreenH*0.5);
    showView.layer.cornerRadius = 5.0;
    showView.layer.masksToBounds = YES;
    //放在最上层
    [window insertSubview:showView atIndex:9999];
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(5, 10, 100, 40);
    label.text = message;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:17];
    label.textAlignment = NSTextAlignmentCenter;
    [showView addSubview:label];
    
    //使用动画
    [UIView animateWithDuration:2.0 animations:^{
        //透明度变0
        showView.alpha=0;
    } completion:^(BOOL finished) {
        //移除视图
        [showView removeFromSuperview];
    }];
    
    
}




















































@end
