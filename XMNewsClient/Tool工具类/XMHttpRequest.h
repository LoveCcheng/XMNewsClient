//
//  XMHttpRequest.h
//  XMNewsClient
//
//  Created by montnets on 2017/2/28.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface XMHttpRequest : NSObject

/** 初始化单利 */
+(instancetype)shareHttpRequest;


-(void)beginHttpRequestWithUrl:(NSString *)Url andParam:(NSDictionary *)param;



@end
