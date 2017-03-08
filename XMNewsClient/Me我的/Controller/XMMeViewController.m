//
//  XMMeViewController.m
//  XMNewsClient
//
//  Created by montnets on 2017/2/23.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMMeViewController.h"
#import "XMLoginController.h"
#import "XMNavigationViewController.h"
#import "XMHistoryViewController.h"

@interface XMMeViewController ()<UIActionSheetDelegate,
                                UIImagePickerControllerDelegate,
                                UINavigationControllerDelegate,
                                UITableViewDelegate,
                                UITableViewDataSource>

/** 用户头像 */
@property (nonatomic,weak) UIImageView *imageViewXm;
/** 头像路径 */
@property (nonatomic, copy) NSString *headImagePath;

@property (nonatomic,weak) UITableView *tableView;

/** 内容 */
@property (nonatomic,strong) NSArray *ConArray;

@end

@implementation XMMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    self.ConArray = @[@"历史上的今天",@"离线视频",@"我的订单",@"我的收藏",@"清空缓存"];
    [self setRightnavgiationBar];
    [self createTopView];
    [self tableView];
}

-(void)setRightnavgiationBar{
    UIBarButtonItem *rightItem = [UIBarButtonItem barButtonWithImage:[UIImage imageNamed:@"mine-moon-icon"] HeightImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(RightBarClick) ConteollEvent:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightItem;
}
/** 切换白天夜间模式 */
-(void)RightBarClick{
    NSString *str = [XMOpreation readInfoWithKey:XMkey];
    if ([str isEqualToString:@"night"]) {
        [XMOpreation saveInfo:@"white" WithKey:XMkey];
    }else{
        [XMOpreation saveInfo:@"night" WithKey:XMkey];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:XMLeftViewNightTypeNotification object:nil];
}

/** 顶部的视图控件 */
-(void)createTopView{
    UIView *topView = [[UIView alloc]init];
    topView.frame = CGRectMake(0, 64, XMScreenW, 100);
    [self.view addSubview:topView];
    topView.layer.borderWidth = 1;
    topView.layer.borderColor=[UIColor grayColor].CGColor;
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.X = 15;
    imageView.Y = 10;
    imageView.width = 80;
    imageView.height = 80;
    imageView.backgroundColor = [UIColor greenColor];
    imageView.layer.cornerRadius = imageView.width*0.5;
    imageView.layer.masksToBounds = YES;
    imageView.image = [UIImage imageNamed:@"personal_head_icon"];
    [topView addSubview:imageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tap];
    self.imageViewXm = imageView;
    
    UIButton *phoneNum = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneNum.X = 100;
    phoneNum.Y = 35;
    phoneNum.width = 150;
    phoneNum.height = 30;
    if (![[XMOpreation readInfoWithKey:XM_LgoinKey] isEqualToString:@""]) {
        NSString *phoneNumber = [XMOpreation readInfoWithKey:XM_PhoneKey];
        [phoneNum setTitle:phoneNumber forState:UIControlStateNormal];
    }else{
        [phoneNum setTitle:@"点击登录" forState:UIControlStateNormal];
        [phoneNum addTarget:self action:@selector(ButtonToLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    [phoneNum setBackgroundColor:[UIColor redColor]];
    [topView addSubview:phoneNum];
}

-(void)tapImageView{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        __weak typeof(self)weakSelf = self;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [self addActionTarget:alert title:@"从相册中选择" color:[UIColor greenColor] action:^(UIAlertAction *action) {
            [weakSelf selectPhotoFormAlbum];
        }];
        [self addActionTarget:alert title:@"打开相机" color: [UIColor greenColor] action:^(UIAlertAction *action) {
            [weakSelf openCamera];
        }];
        [self addCancelActionTarget:alert title:@"取消"];
        
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        UIActionSheet *sheetView = [[UIActionSheet alloc]initWithTitle: nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册中选择",@"打开相机", nil];
        [sheetView showInView:self.view];
    }
}
/** 从相册中选择  */
-(void)selectPhotoFormAlbum{
    XMLogFun;
    UIImagePickerController *pickerVC = [[UIImagePickerController alloc]init];
    pickerVC.delegate = self ;
    
    pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pickerVC animated:YES completion:nil];
    
}
/** 打开相机 */
-(void)openCamera{
    XMLogFun;
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate  = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        XMLog(@"模拟器无法打开相机");
    }
    [self presentViewController:picker animated:YES completion:nil];
}
/**
 *  获取图片并显示
 *
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *imageNew = [self imageScaleToSize:info[UIImagePickerControllerOriginalImage] scaledToSize:CGSizeMake(400, 400)];
    self.imageViewXm.image = imageNew;
}

//压缩图片
- (UIImage *)imageScaleToSize:(UIImage *)image scaledToSize:(CGSize)size
{
    CGFloat oriWidth = image.size.width;
    CGFloat oriHeight = image.size.height;
    if (oriWidth <= size.width && oriHeight <= size.height) {
        return image;
    }
    if (size.height == 0 || size.width == 0) {
        return image;
    }
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
/** 弹出登录界面 */
-(void)ButtonToLogin{
    XMLogFun;
    XMLoginController *loginVC = [[XMLoginController alloc]init];
    
    XMNavigationViewController *nav = [[XMNavigationViewController alloc]initWithRootViewController:loginVC];
    
    //从跟控制器模态弹出，就不会出现警告
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window.rootViewController presentViewController:nav animated:YES completion:nil];
}


- (void)addActionTarget:(UIAlertController *)alertController title:(NSString *)title color:(UIColor *)color action:(void(^)(UIAlertAction *action))actionTarget
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        actionTarget(action);
    }];
    
    [action setValue:color forKey:@"_titleTextColor"];
    
    [alertController addAction:action];
}
// 取消按钮
-(void)addCancelActionTarget:(UIAlertController*)alertController title:(NSString *)title
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    [action setValue:[UIColor greenColor] forKey:@"_titleTextColor"];
    [alertController addAction:action];
}

/** --------------------------------------------------------------------------- **/

-(UITableView *)tableView{
    if (!_tableView) {
        UITableView *table=[[UITableView alloc]initWithFrame:CGRectMake(0, 180, XMScreenW, 200)];
        table.delegate=self;
        table.dataSource=self;
        //禁止滑动
        [table setScrollEnabled:NO];
        table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Mecell"];
        [self.view addSubview:table];
        _tableView=table;
    }
    return _tableView;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ConArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Mecell"];
    
    cell.textLabel.text = self.ConArray[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        XMHistoryViewController *history = [[XMHistoryViewController alloc]init];
        [self.navigationController pushViewController:history animated:YES];
    }
}





















@end
