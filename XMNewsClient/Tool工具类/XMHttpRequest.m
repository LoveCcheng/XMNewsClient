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
    [_manager GET:UrlString parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if (responseObject[@"subjects"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:XMMovieDataNotification object:responseObject];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}









































@end
