//
//  XMHistoryModel.h
//  XMNewsClient
//
//  Created by montnets on 2017/3/3.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMHistoryModel : NSObject


/** 图片地址 */
@property (nonatomic,copy) NSString *pic;
/** 事件 */
@property (nonatomic,copy) NSString *title;
/** 描述 */
@property (nonatomic,copy) NSString *des;
/** 农历 */
@property (nonatomic,copy) NSString *lunar;
/** 月份 */
@property (nonatomic,copy) NSString *month;
/** 日 */
@property (nonatomic,copy) NSString *day;



+(instancetype)initWithDictionary:(NSDictionary *)dict;




@end
