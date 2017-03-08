//
//  XMLoginController.m
//  XMNewsClient
//
//  Created by montnets on 2017/3/7.
//  Copyright © 2017年 montnets. All rights reserved.
//

#import "XMLoginController.h"
#import <SMS_SDK/SMSSDK.h>

@interface XMLoginController ()

@property (nonatomic,weak) UITextField *phonenumText;
@property (nonatomic,weak) UITextField *YzmnumText;

@end

@implementation XMLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftBarItem];
    [self createUI];
}

-(void)setLeftBarItem{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)leftButtonClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)createUI{
    UITextField *phoneText = [[UITextField alloc]init];
    phoneText.X = 80;
    phoneText.Y = 150;
    phoneText.width = XMScreenW - 2*80;
    phoneText.height = 40;
    phoneText.backgroundColor = [UIColor grayColor];
    phoneText.placeholder = @"请输入手机号";
    [self.view addSubview:phoneText];
    self.phonenumText = phoneText;
    
    UITextField *YzmText = [[UITextField alloc]init];
    YzmText.X = 80;
    YzmText.Y = 200;
    YzmText.width = XMScreenW - 2*80;
    YzmText.height = 40;
    YzmText.backgroundColor = [UIColor grayColor];
    YzmText.placeholder = @"请输入验证码";
    [self.view addSubview:YzmText];
    self.YzmnumText = YzmText;
    
    UIButton *butLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    butLogin.X = XMScreenW*0.5-40;
    butLogin.Y = 250;
    butLogin.width = 80;
    butLogin.height = 40;
    [butLogin setTitle:@"登录" forState:UIControlStateNormal];
    butLogin.backgroundColor = [UIColor redColor];
    [butLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [butLogin addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butLogin];
    
    UIButton *butgetYzm = [UIButton buttonWithType:UIButtonTypeCustom];
    butgetYzm.X = XMScreenW*0.5-50;
    butgetYzm.Y = 300;
    butgetYzm.width = 100;
    butgetYzm.height = 40;
    [butgetYzm setTitle:@"获取验证码" forState:UIControlStateNormal];
    butgetYzm.backgroundColor = [UIColor redColor];
    [butgetYzm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [butgetYzm addTarget:self action:@selector(YzmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butgetYzm];
}
/** 提交验证码 */
-(void)loginButtonClick{
    XMLogFun;
    if (self.phonenumText.text.length != 11) {
        [self showAlertMessage:@"手机号有误"];
        return;
    }
    if (self.YzmnumText.text.length == 0) {
        [self showAlertMessage:@"验证码不能为空"];
        return;
    }
    /**
     * @from                    v1.1.1
     * @brief                   提交验证码(Commit the verification code)
     *
     * @param code              验证码(Verification code)
     * @param phoneNumber       电话号码(The phone number)
     * @param zone              区域号，不要加"+"号(Area code)
     * @param result            请求结果回调(Results of the request)
     */
    [SMSSDK commitVerificationCode:self.YzmnumText.text phoneNumber:self.phonenumText.text zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
        if (!error) {
            XMLog(@"login success");
            [XMOpreation showCustomMessage:@"登录成功"];
            [XMOpreation saveInfo:@"login success" WithKey:XM_LgoinKey];
            [XMOpreation saveInfo:self.phonenumText.text WithKey:XM_PhoneKey];
            [self leftButtonClick];
        }else{
            XMLog(@"login error %@",error);
        }
    }];
}

/** 获取验证码 */
-(void)YzmButtonClick{
    XMLogFun;
    /**
     *  @from                    v1.1.1
     *  @brief                   获取验证码(Get verification code)
     *
     *  @param method            获取验证码的方法(The method of getting verificationCode)
     *  @param phoneNumber       电话号码(The phone number)
     *  @param zone              区域号，不要加"+"号(Area code)
     *  @param customIdentifier  自定义短信模板标识 该标识需从官网http://www.mob.com上申请，审核通过后获得。(Custom model of SMS.  The identifier can get it  from http://www.mob.com  when the application had approved)
     *  @param result            请求结果回调(Results of the request)
     */
    XMLog(@"==%@",self.phonenumText.text);
    if (self.phonenumText.text.length != 11) {
        [self showAlertMessage:@"手机号有误"];
        return;
    }
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phonenumText.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            XMLog(@"获取验证码成功");
        }else{
            XMLog(@"获取验证码失败--%@",error);
        }
    }];

}


/** 用alelt弹出提示信息 */
-(void)showAlertMessage:(NSString *)message{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES
                                                                               completion:nil];
}














































@end
