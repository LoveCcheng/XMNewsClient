//
//  XMHttpRequest.m
//  XMNewsClient
//
//  Created by montnets on 2017/2/28.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMHttpRequest.h"



@interface XMHttpRequest ()

{
    AFHTTPSessionManager *_manager;
}

@end

@implementation XMHttpRequest

-(instancetype)init{
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
    }
    return self;
}

+(instancetype)shareHttpRequest{
    static XMHttpRequest *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager =[[self alloc]init];
    });
    return manager;
}

-(void)beginHttpRequestWithUrl:(NSString *)Url andParam:(NSDictionary *)param{
    [self getWithUrlString:Url andParam:param];
    
}

-(void)getWithUrlString:(NSString *)UrlString andParam:(NSDictionary *)param{
    _manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [_manager GET:UrlString parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        //电影数据
        if (responseObject[@"subjects"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:XMMovieDataNotification object:responseObject];
        }
        //新闻数据
        if([param[@"key"] isEqualToString:HTTP_NEWS_KEY]){
            [[NSNotificationCenter defaultCenter] postNotificationName:XMNewsDataNotification object:responseObject];
        }
        //历史上今天数据
        if ([param[@"key"] isEqualToString:HTTP_TODAY_KEY]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:XMHistoryDataNotification object:responseObject];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XMLog(@"--%@",error);
    }];
}









































@end
