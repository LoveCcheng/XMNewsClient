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

@required
/** 这个方法要强制执行，他要给出Item的高度 */
-(CGFloat)WaterFlowLayout:(XMWaterLayout *)WaterFlowlayout HeightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;
@optional
/** 返回列数 */
-(NSInteger)columnCountWaterFlowLayout:(XMWaterLayout *)WaterFlowlayout;
/** 返回列之间的间隔 */
-(CGFloat)columnMarginWaterFlowLayout:(XMWaterLayout *)WaterFlowlayout;
/** 返回行之间的间隔 */
-(CGFloat)RowMarginWaterFlowLayout:(XMWaterLayout *)WaterFlowlayout;
/** 返回Item与四周之间的间隔 */
-(UIEdgeInsets)edgeInsetsWaterFlowLayout:(XMWaterLayout *)WaterFlowlayout;

@end

@interface XMWaterLayout : UICollectionViewLayout

/** 代理 */
@property (nonatomic,weak) id<XMWaterLayoutDelegate>delegate;


/**
  *对于列数的控制和间隔的控制，可以用上面的代理，也可以用属性
  *代理的好处就是让使用者按照我们自己制定的路线走，能很好的控制程序的执行,但是会一点笨重，没有属性传值灵活
  *属性的好处就是灵活使用，使用者可以在任何自己要修改的地方修改参数，但是就会出现一些重新运算视图的样式大小等，
 
 */

/** ---------------------这里建议用上面的代理方法--------------------- */

//-----------------------下面的属性没有实现，不要调用
 /** 列数 */
@property (nonatomic,assign) NSInteger columnsCount;
/** 列之间的间隔 */
@property (nonatomic,assign) CGFloat columnsMargin;
/** 行之间的间隔 */
@property (nonatomic,assign) CGFloat RowsMargin;
/** Item与四周之间的间隔 */
@property (nonatomic,assign) UIEdgeInsets edgesInsets;





@end
