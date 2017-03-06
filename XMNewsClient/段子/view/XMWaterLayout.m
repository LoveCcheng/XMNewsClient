//
//  XMWaterLayout.m
//  XMNewsClient
//
//  Created by montnets on 2017/3/3.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMWaterLayout.h"

/** 默认的列数 */
static const NSInteger XMdefaultsColumnCount = 2;
/** 每一列的间距 */
static const NSInteger XMdefaultsColumnMargin = 10;
/** 每一行的间距 */
static const NSInteger XMdefaultsRowMargin = 10;
/** 每个item与边缘的间距 */
static const UIEdgeInsets XMdefaultsEdgeInsets = {10,10,10,10};

@interface XMWaterLayout ()
/** 存放所以列的当前高度 */
@property (nonatomic,strong) NSMutableArray *columnHeightArr;
/** 存放所有cell的布局属性 */
@property (nonatomic,strong) NSMutableArray *attrsArray;
/** 内容的高度 */
@property (nonatomic, assign) CGFloat contentHeight;

/** 返回列数 */
-(NSInteger)columnCount;
/** 返回每一列的间距 */
-(CGFloat)columnMargin;
/** 每一行的间距 */
-(CGFloat)rowMargin;
/** 每个item与边缘的间距 */
-(UIEdgeInsets)edgeInsets;
@end

@implementation XMWaterLayout

/************************ 从代理方法取值   vvvvvv ***********************************/
/** 返回列数 */
-(NSInteger)columnCount{
    if ([self.delegate respondsToSelector:@selector(columnCountWaterFlowLayout:)]) {
        return [self.delegate columnCountWaterFlowLayout:self];
    }
    return XMdefaultsColumnCount;
}
/** 返回每一列的间距 */
-(CGFloat)columnMargin{
    if ([self.delegate respondsToSelector:@selector(columnMarginWaterFlowLayout:)]) {
        return [self.delegate columnMarginWaterFlowLayout:self];
    }
    return XMdefaultsColumnMargin;
}
/** 每一行的间距 */
-(CGFloat)rowMargin{
    if ([self.delegate respondsToSelector:@selector(RowMarginWaterFlowLayout:)]) {
        return [self.delegate RowMarginWaterFlowLayout:self];
    }
    return XMdefaultsRowMargin;
}
/** 每个item与边缘的间距 */
-(UIEdgeInsets)edgeInsets{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsWaterFlowLayout:)]) {
        return [self.delegate edgeInsetsWaterFlowLayout:self];
    }
    return XMdefaultsEdgeInsets;
}
/************************ 从代理方法取值  ^^^^^^^^   ***********************************/


-(NSMutableArray *)columnHeightArr
{
    if (!_columnHeightArr) {
        _columnHeightArr = [NSMutableArray array];
    }
    return _columnHeightArr;
}

-(NSMutableArray *)attrsArray{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

/** 初始化。对cell布局,reloadData会触发这个方法，重新布局 */
-(void)prepareLayout{
    [super prepareLayout];

    //初始内容的高度为0
    self.contentHeight = 0;
    //清楚之前的所有高度
    [self.columnHeightArr removeAllObjects];
    
    //初始化默认高度  每一列的初始高度都为上面的空隙
    for (NSInteger i=0; i<self.columnCount; i++) {
        NSInteger height = self.edgeInsets.top;
        [self.columnHeightArr addObject:@(height)];
    }
    
    //清楚之前的布局属性
    [self.attrsArray removeAllObjects];
    
    //创建每一个cell对应的布局属性==计算每个cell的位置坐标(只考虑一个组的情况)
    NSInteger Cellcount = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i=0; i<Cellcount; i++) {
        //创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //获取indexPath位置cell对应的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.attrsArray addObject:attrs];
        
    }
    
}
/** 决定cell的排布 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArray;
}

/** 返回indexPath位置cell对应的布局属性 */
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    //创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //collectionview的宽度
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    
    //设置布局属性的frame
    CGFloat CellWidth = (collectionViewWidth - self.edgeInsets.left - self.edgeInsets.right -(self.columnCount-1)*self.columnMargin)/self.columnCount;
    //因为是必须执行的代理方法，所以不用判断,如果调用框架的人不执行这个方法，则会导致程序崩溃
    CGFloat Cellheight = [self.delegate WaterFlowLayout:self HeightForItemAtIndex:indexPath.item itemWidth:CellWidth];
    //找出高度最短的那一列
    //这是下标
    NSInteger FlagColumn = 0;
    //设想第一列就是最短的高度
    CGFloat minColumnHeight = [self.columnHeightArr[0] doubleValue];
    for (NSInteger i=0; i<self.columnCount; i++) {
        //取第i列的高度
        CGFloat columnH = [self.columnHeightArr[i] doubleValue];
        if (columnH < minColumnHeight) {
            minColumnHeight = columnH;
            FlagColumn = i;
        }
    }
    CGFloat CellX = self.edgeInsets.left + FlagColumn*(CellWidth + self.columnMargin);
    CGFloat CellY = minColumnHeight;
    //下面表示不是第一行
    if (CellY != self.edgeInsets.top) {
        CellY += self.rowMargin;
    }
    attrs.frame = CGRectMake(CellX, CellY, CellWidth, Cellheight);
    //更新最短的那列的高度
    self.columnHeightArr[FlagColumn] = @(CGRectGetMaxY(attrs.frame));
    
    
    //记录内容的高度
    CGFloat columnHeight = [self.columnHeightArr[FlagColumn] doubleValue];
    
    if (self.contentHeight < columnHeight) {
        self.contentHeight = columnHeight;
    }
    return attrs;
}
/**  返回 collectionView的contentSize  */
-(CGSize)collectionViewContentSize{
    //找出高度最长的那一列
//    CGFloat maxColumnHeight = [self.columnHeightArr[0] doubleValue];
//    for (NSInteger i=1; i<self.columnCount; i++) {
//        //取第i列的高度
//        CGFloat columnH = [self.columnHeightArr[i] doubleValue];
//        if (columnH > maxColumnHeight) {
//            maxColumnHeight = columnH;
//        }
//    }
    return CGSizeMake(0, self.contentHeight+self.edgeInsets.bottom);
}



























































@end
