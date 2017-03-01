//
//  XMMovieModel.h
//  XMNewsClient
//
//  Created by montnets on 2017/3/1.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMMovieModel : NSObject


/** 片名 */
@property (nonatomic,copy) NSString *title;

/** 年份 */
@property (nonatomic,copy) NSString *year;

/** 图片 */
@property (nonatomic,strong) NSDictionary *images;

/** 评分 */
@property (nonatomic,strong) NSDictionary *rating;

/** 类型 */
@property (nonatomic,strong) NSArray *genres;


@property (nonatomic,assign) BOOL *isChange;

+(instancetype)initWithDictionary:(NSDictionary *)dict;





@end
