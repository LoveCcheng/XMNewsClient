//
//  XMWaterLayout.h
//  XMNewsClient
//
//  Created by montnets on 2017/3/3.
//  Copyright © 2017年 montnets. All rights reserved.
//

/** ------------------------------- 自己封装的瀑布流布局 ------------------------------- **/

#import <UIKit/UIKit.h>

@class XMWaterLayout;

//代理
@protocol XMWaterLayoutDelegate <NSObject>
//这个方法要强制执行，他要给出Item的高度
@required

-(CGFloat)WaterFlowLayout:(XMWaterLayout *)WaterFlowlayout HeightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;


@end

@interface XMWaterLayout : UICollectionViewLayout

/** 代理 */
@property (nonatomic,weak) id<XMWaterLayoutDelegate>delegate;


@end
