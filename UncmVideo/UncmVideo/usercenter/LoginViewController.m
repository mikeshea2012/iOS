//
// Created by xinyingtiyu on 13-3-19.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "LoginViewController.h"
#import "RegistViewController.h"
#import "AppDelegate.h"
#import "LoginRequest.h"
#import "LoginResponse.h"
#import "LoginOrRegistRequest.h"
#import "LoginOrRegistResponse.h"
#import "UserInfo.h"
#import "UserLoginNotChargedViewController.h"
#import "MikeStringUtil.h"
#import "UserInfoDao.h"

@implementation LoginViewController {
#pragma mark 成员变量
    SuperResponse *g_response;
    NSString *g_phone_value;
    NSString *g_pwd_value;
    SuperRequest *g_request;
    NSMutableArray *g_dataArray;
}
@synthesize userPhone;

#pragma mark 设置页面
- (void)loadView {
    [super loadView];
    //针对不同的屏幕进行适配
    int delta = (int)([UIScreen mainScreen].bounds.size.height - 480.0);
    g_dataArray = [[NSMutableArray alloc] init];
    g_isChcked = true;
    [self SET_HEADER_NAVIGATION];//统一设置头部导航条
    [self.view setBackgroundColor:RGBACOLOR(41, 41, 41, 1)];
    //手机号
    g_userName = ((UITextField *) [self.view viewWithTag:1001]);
    g_userName.placeholder = @"请输入手机号";
    g_userName.delegate = self;
    //密码
    g_pwd = ((UITextField *) [self.view viewWithTag:1002]);
    g_pwd.delegate = self;
    g_pwd.placeholder = @"请输入密码";
    //自动登录
    UIImageView *autoLoginView = ((UIImageView *) [self.view viewWithTag:1003]);
    autoLoginView.image = [UIImage imageNamed:@"check_yes_23_23"];
    [autoLoginView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *recognizer = [[[UITapGestureRecognizer alloc]
            initWithTarget:self
                    action:@selector(autoLogin_action)] autorelease];
    [autoLoginView addGestureRecognizer:recognizer];
    //找回密码
    ((UILabel *) [self.view viewWithTag:1004]).textColor = RGBACOLOR(73, 151, 188, 1);
    //或快速注册
    UILabel *registLabel = ((UILabel *) [self.view viewWithTag:1005]);
    registLabel.userInteractionEnabled = YES;
    registLabel.textColor = RGBACOLOR(73, 151, 188, 1);
    recognizer = [[[UITapGestureRecognizer alloc]
            initWithTarget:self
                    action:@selector(regist_action)] autorelease];
    [registLabel addGestureRecognizer:recognizer];
    //登陆
    UIButton *chargedLoginBtn = (UIButton *) [self.view viewWithTag:1006];
    [chargedLoginBtn setBackgroundImage:[UIImage imageNamed:@"login_126_46"]
                               forState:UIControlStateNormal];
    [chargedLoginBtn addTarget:self action:@selector(login)
              forControlEvents:UIControlEventTouchUpInside];
    //企业图标
    UIImageView *logoImgView = ((UIImageView *) [self.view viewWithTag:1008]);
    logoImgView.image = [UIImage imageNamed:@"ssports_logo.png"];
    int x = 226, y = 388+delta, w = 87, h = 27;
    logoImgView.frame = CGRectMake(x, y, w, h);
}

//统一设置头部导航条
- (void)SET_HEADER_NAVIGATION {
    [self.navigationController.navigationBar
            setBackgroundImage:[UIImage imageNamed:@"navi_bg_height_1.png"]
                 forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setContentMode:UIViewContentModeScaleToFill];
    self.navigationItem.title = @"登陆";
    //part1:导航栏-->  1.1 左边的导航条
    UIButton *left_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    left_btn.frame = CGRectMake(0, 0, 48, 28);
    [left_btn setTitle:@"取消" forState:UIControlStateNormal];
    left_btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    left_btn.titleLabel.textAlignment = (NSTextAlignment) UITextAlignmentCenter;
    [left_btn setBackgroundImage:[UIImage imageNamed:@"right_btn_48_28"] forState:UIControlStateNormal];
    [left_btn addTarget:self action:@selector(responseLeft) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left_barBtn = [[[UIBarButtonItem alloc] initWithCustomView:left_btn] autorelease];
    self.navigationItem.leftBarButtonItem = left_barBtn;

    //part1:导航栏--> 1.3右边的导航条
    g_right_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    g_right_btn.frame = CGRectMake(0, 0, 60, 28);
    [g_right_btn setHidden:YES];
    [g_right_btn setBackgroundImage:[UIImage imageNamed:@"goging_49_18.png"] forState:UIControlStateNormal];
    [g_right_btn addTarget:self action:@selector(finishedInput:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right_barBtn = [[[UIBarButtonItem alloc] initWithCustomView:g_right_btn] autorelease];

    //完成输入--汉字提示
    UILabel *label_gameCenter = [[[UILabel alloc] init] autorelease];
    label_gameCenter.text = @" 完成输入";
    [label_gameCenter setTextAlignment:NSTextAlignmentLeft]; //字体位置，居左还是居中还是居右
    [label_gameCenter setFont:[UIFont systemFontOfSize:13]]; //字体
    [label_gameCenter setTextColor:[UIColor whiteColor]];   //文字颜色
    label_gameCenter.frame = CGRectMake(2, 0, 60, 28);
    label_gameCenter.backgroundColor = [UIColor clearColor];
    [right_barBtn.customView addSubview:label_gameCenter];

    self.navigationItem.rightBarButtonItem = right_barBtn;


    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(finishedInput:)] autorelease];
    [self.view addGestureRecognizer:singleTap];
}

//登陆操作
-(void)login{
    //手机号码
    NSString *phoneNum = nil;
    UITextField *phoneNum_text = (UITextField *) [self.view viewWithTag:1001];
    phoneNum = phoneNum_text.text;
    NSLog(@"phoneNum=%@",phoneNum);
    //密码
    NSString *pwd = nil;
    UITextField *pwd_text = (UITextField *) [self.view viewWithTag:1002];
    pwd = pwd_text.text;
    if ([MikeStringUtil isEmptyOrNull:phoneNum]){
        [self showAlertWithTitle:@"提示:" message:@"请输入手机号码"];
        return;
    }
    if (![MikeStringUtil isMobileNumber:phoneNum]){
        [self showAlertWithTitle:@"提示:" message:@"请输入由11位数字组成的正确格式的手机号码"];
        return;
    }
    if ([MikeStringUtil isEmptyOrNull:pwd]){
        [self showAlertWithTitle:@"提示:" message:@"请输入密码"];
        return;
    }
    if ([pwd length] < 6 || [pwd length] > 16){
        [self showAlertWithTitle:@"提示:" message:@"请输入6-16位数字或字母"];
        return;
    }
    LoginOrRegistRequest *req = [[LoginOrRegistRequest alloc] init];
    req.methodName = @"RequestLogin";
    req.userName = phoneNum;
    self.userPhone = req.userName;
    req.password = pwd;
    g_request = req;
    g_phone_value = phoneNum;
    g_pwd_value = pwd;
    [self startHttpRequest];
}

//完成输入，键盘收起
- (void)finishedInput:(id)respd {
    [g_userName resignFirstResponder];
    [g_pwd resignFirstResponder];
}

//“自动登陆”按钮选择
- (void)autoLogin_action {
    g_isChcked = !g_isChcked;
    UIImageView *autoLoginView = ((UIImageView *) [self.view viewWithTag:1003]);
    if (g_isChcked) {
        autoLoginView.image = [UIImage imageNamed:@"check_yes_23_23"];
    } else {
        autoLoginView.image = [UIImage imageNamed:@"check_no_23_23"];
    }
}

//弹出提示信息
- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)msg{
    UIAlertView *promptAlert = [[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:nil] autorelease];
    [NSTimer scheduledTimerWithTimeInterval:0.5f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:NO];
    [promptAlert show];
}
//提示信息的定时消失机制
- (void)timerFireMethod:(NSTimer*)theTimer{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
}


//“注册”按钮选择
- (void)regist_action {
    RegistViewController *controller = [[[RegistViewController alloc]
            initWithNibName:@"RegistViewController" bundle:nil] autorelease];
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark 联网部分
//开始联网
- (void)startHttpRequest {
    [self startHttpJsonPost:g_request];
}

//处理错误应答
- (void)printError {
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 252, 120)] autorelease];
    imageView.image = [UIImage imageNamed:@"network_error_252_120.png"];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
}

//将返回的成功数据进行处理
- (void)printResponse:(NSString *)receiveStr {
    NSLog(@"responseStr:%@",receiveStr);
    if ([g_request isKindOfClass:[LoginOrRegistRequest class]]) {
        LoginOrRegistResponse *respn = [(LoginOrRegistResponse *) [[LoginOrRegistResponse alloc] initWithJsonString:receiveStr] autorelease];
        if ([respn.returnCode isEqualToString:@"10001"]) { //请求成功
            //进入登陆成功页面
            AppDelegate *myApp = (AppDelegate *) [UIApplication sharedApplication].delegate;
            UserInfo *userInfo = [[[UserInfo alloc] init] autorelease];
            userInfo.UUID = respn.userID;
            userInfo.username = respn.userName;
            myApp.userInfo = userInfo;

            //如果是自动登陆
            UserInfoDao *userInfoDao = [[[UserInfoDao alloc] init] autorelease];
            if (g_isChcked){
               UserInfo *userInfoBean = [[[UserInfo alloc] init] autorelease];
               userInfoBean.phone = g_phone_value;
               userInfoBean.passwd = g_pwd_value;
               [userInfoDao updateOrInsertTable:userInfoBean];
            }else{
                [userInfoDao eraseDBByTableName];
            }
            UserLoginNotChargedViewController *controller = [[[UserLoginNotChargedViewController alloc]
                    initWithNibName:@"User_login_notcharged_ViewController" bundle:nil] autorelease];
            controller.userPhone = self.userPhone;
            [self.navigationController pushViewController:controller animated:YES];
        } else {
            NSLog(@"请求失败");
        }
    }
}

#pragma mark 导航条
- (void)responseRight {
}

//点击左导航条触发的动作
- (void)responseLeft {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)gotoFP {
}

- (void)gotoSubs {
}

- (void)gotoSubs2 {
}

#pragma mark 处理输入法
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [g_right_btn setHidden:NO];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [g_right_btn setHidden:YES];
}


#pragma mark 析构函数部分
- (void)dealloc {
    [g_phone_value release];
    [g_pwd_value release];
    [g_response release];
    [g_request release];
    [g_dataArray release];
    [super dealloc];
}


@end