//
//  XMNewsCell.h
//  XMNewsClient
//
//  Created by montnets on 2017/3/2.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMNewModel.h"


@interface XMNewsCell : UITableViewCell

/** 传过来的数据模型 */
@property (nonatomic,strong) XMNewModel *NewsModel;


@end
