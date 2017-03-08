
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



/** 关键字。颜色模式的 */
#define XMkey @"xmkey"

/** 保存版本信息的key */
#define  XMVersion @"version"

//新闻URL
#define HTTP_NEWS @"http://v.juhe.cn/toutiao/index"
//新闻key
#define HTTP_NEWS_KEY @"15acbd82bc3becf4d919d3f538907f44"
//历史上今天URL
#define HTTP_TODAY @"http://api.juheapi.com/japi/toh"
//历史上今天KEY
#define HTTP_TODAY_KEY @"0bb76639f283bc8d1c281049f433bdff"
//电影的URL
#define HTTP_MOVIE @"https://api.douban.com/v2/movie/top250"
//段子的URl
#define HTTP_JOKE @"http://japi.juhe.cn/joke/content/list.from"
//段子的KEY
#define HTTP_JOKE_KEY @"7cfdf0564a7edb2aa9368ec57ed65ede"



//保存登录的key
#define XM_LgoinKey @"login"
//保存用户的key
#define XM_PhoneKey @"phone"

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

/** 获取段子数据的通知 */
UIKIT_EXTERN NSString *XMJokeDataNotification;
















