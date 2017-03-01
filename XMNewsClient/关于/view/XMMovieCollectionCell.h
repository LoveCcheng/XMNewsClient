//
//  XMMovieCollectionCell.h
//  XMNewsClient
//
//  Created by montnets on 2017/3/1.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMMovieModel.h"

@interface XMMovieCollectionCell : UICollectionViewCell

/** 电影数据模型 */
@property (nonatomic,copy) XMMovieModel *Moviemodel;

/** 是否改变样式 */
@property (nonatomic,assign) BOOL isChan;


@end
