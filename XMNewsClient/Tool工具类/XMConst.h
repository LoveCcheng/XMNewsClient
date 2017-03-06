
#import <UIKit/UIKit.h>

/** 新闻的不同类型 */
typedef NS_ENUM(NSInteger,XMNewType){
    XMNewTypeTop,
    XMNewTypeShehui,
    XMNewTypeGuonei,
    XMNewTypeGuoji,
    XMNewTypeYule,
    XMNewTypeTiyu,
    XMNewTypeJunshi,
    XMNewTypeKeji,
    XMNewTypeCaijing,
    XMNewTypeShishang
};



/** 点击导航栏左边按钮发送的通知 */
UIKIT_EXTERN NSString *XMLeftItemClickNoti;

/** 左边视图显示完毕的通知 */
UIKIT_EXTERN NSString *XMLeftViewShowNotification;

/** 左边视图隐藏完毕的通知 */
UIKIT_EXTERN NSString *XMLeftViewHideNotification;

/** 左边视图点击选项的通知 */
UIKIT_EXTERN NSString *XMLeftViewSelectRowNotification;

/** 左边视图的夜间模式功能 */
UIKIT_EXTERN NSString *XMLeftViewNightTypeNotification;

/** 获取电影数据的通知 */
UIKIT_EXTERN NSString *XMMovieDataNotification;

/** 获取新闻数据的通知 */
UIKIT_EXTERN NSString *XMNewsDataNotification;

/** 获取历史上今天数据的通知 */
UIKIT_EXTERN NSString *XMHistoryDataNotification;
















