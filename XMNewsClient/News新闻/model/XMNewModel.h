//
//  XMNewModel.h
//  XMNewsClient
//
//  Created by montnets on 2017/3/2.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMNewModel : NSObject

/** 标题 */
@property (nonatomic,copy) NSString *title;
/** 作者 */
@property (nonatomic,copy) NSString *author_name;
/** 时间 */
@property (nonatomic,copy) NSString *date;
/** 网址链接 */
@property (nonatomic,copy) NSString *url;
/** 图片地址 */
@property (nonatomic,copy) NSString *thumbnail_pic_s;


+(instancetype)initWithDictionary:(NSDictionary *)dict;


@end
