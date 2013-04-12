//
// Created by xinyingtiyu on 13-3-19.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NoTableNetConnViewController.h"
#import "CommonHeadProtocol.h"
#import "RegistViewController.h"
#import "LoginRequest.h"
#import "LoginResponse.h"
#import "LoginOrRegistRequest.h"
#import "LoginOrRegistResponse.h"
#import "MikeStringUtil.h"

@implementation RegistViewController {
#pragma mark 成员变量
    SuperResponse *g_response;
    SuperRequest *g_request;
//    NSURL *testUrl ;
    NSMutableArray *g_dataArray;
}

#pragma mark 设置页面
- (void)loadView {
    [super loadView];
    //针对不同的屏幕进行适配
    int delta = (int)([UIScreen mainScreen].bounds.size.height - 480.0);
    g_isChcked = YES;

    [self SET_HEADER_NAVIGATION];//统一设置头部导航条
    [self.view setBackgroundColor:RGBACOLOR(41, 41, 41, 1)];
    //手机号
    g_userName = ((UITextField *) [self.view viewWithTag:1001]);
    g_userName.placeholder = @"11位手机号码";
    g_userName.delegate = self;
    //密码
    g_pwd = ((UITextField *) [self.view viewWithTag:1002]);
    g_pwd.placeholder = @"6-16位数字或字母";
    g_pwd.delegate = self;
    //同意
    UIImageView *autoLoginView = ((UIImageView *) [self.view viewWithTag:1003]);
    autoLoginView.image = [UIImage imageNamed:@"check_yes_23_23"];
    [autoLoginView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *recognizer = [[[UITapGestureRecognizer alloc]
            initWithTarget:self
                    action:@selector(agree_logo_action)] autorelease];
    [autoLoginView addGestureRecognizer:recognizer];
    //使用协议
    UILabel *agreeLabel = ((UILabel *) [self.view viewWithTag:1004]);
    agreeLabel.userInteractionEnabled = YES;
    agreeLabel.textColor = RGBACOLOR(73, 151, 188, 1);
    recognizer = [[[UITapGestureRecognizer alloc]
            initWithTarget:self
                    action:@selector(agree_action)] autorelease];
    [agreeLabel addGestureRecognizer:recognizer];
    //注册
    UIButton *regBtn = (UIButton *) [self.view viewWithTag:1006];
    [regBtn setBackgroundImage:[UIImage imageNamed:@"login_126_46"]
                      forState:UIControlStateNormal];
    [regBtn addTarget:self action:@selector(regist) forControlEvents:(UIControlEvents) UIControlEventTouchUpInside];
    //企业图标
    UIImageView *logoImgView = ((UIImageView *) [self.view viewWithTag:1008]);
    logoImgView.image = [UIImage imageNamed:@"ssports_logo.png"];
    int x = 226, y = 388+delta, w = 87, h = 27;
    logoImgView.frame = CGRectMake(x, y, w, h);


}


//注册操作
-(void)regist{
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
    req.methodName = @"RequestRegister";
    req.userName = phoneNum;
    req.password = pwd;
    g_request = req;

    [self startHttpRequest];
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



//统一设置头部导航条
- (void)SET_HEADER_NAVIGATION {
    [self.navigationController.navigationBar
            setBackgroundImage:[UIImage imageNamed:@"navi_bg_height_1.png"]
                 forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setContentMode:UIViewContentModeScaleToFill];
    self.navigationItem.title = @"注册";
    //part1:导航栏-->  1.1 左边的导航条
    UIButton *left_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    left_btn.frame = CGRectMake(0, 0, 61, 30);
    [left_btn setTitle:@"返回" forState:UIControlStateNormal];
    left_btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    left_btn.titleLabel.textAlignment = (NSTextAlignment) UITextAlignmentCenter;
    [left_btn setBackgroundImage:[UIImage imageNamed:@"back_61_30"] forState:UIControlStateNormal];
    [left_btn addTarget:self action:@selector(responseLeft) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left_barBtn = [[[UIBarButtonItem alloc] initWithCustomView:left_btn] autorelease];
    self.navigationItem.leftBarButtonItem = left_barBtn;

    //part1:导航栏--> 1.3右边的导航条-->关于我们
    g_right_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    g_right_btn.frame = CGRectMake(0, 0, 60, 28);
    [g_right_btn setHidden:YES];
    [g_right_btn setBackgroundImage:[UIImage imageNamed:@"goging_49_18.png"] forState:UIControlStateNormal];
    [g_right_btn addTarget:self action:@selector(finishedInput:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right_barBtn = [[[UIBarButtonItem alloc] initWithCustomView:g_right_btn] autorelease];

    //完成输入--汉字提示
    UILabel *label_gameCenter = [[[UILabel alloc] init] autorelease];
    label_gameCenter.text = @" 完成输入";
    label_gameCenter.textAlignment = (NSTextAlignment) UITextAlignmentCenter;
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

//完成输入 按钮
- (void)finishedInput:(id)respd {
    [g_userName resignFirstResponder];
    [g_pwd resignFirstResponder];
}

//同意自动登陆
- (void)agree_logo_action {
    g_isChcked = !g_isChcked;
    UIImageView *autoLoginView = ((UIImageView *) [self.view viewWithTag:1003]);
    if (g_isChcked) {
        autoLoginView.image = [UIImage imageNamed:@"check_yes_23_23"];
    } else {
        autoLoginView.image = [UIImage imageNamed:@"check_no_23_23"];
    }
}

//
- (void)agree_action {
    NSLog(@"agree_action todo ...");
}

#pragma mark 联网部分
//开始联网
- (void)startHttpRequest {
    [self startHttpJsonPost:g_request];
}

//将返回的成功数据进行处理
- (void)printResponse:(NSString *)receiveStr {
    NSLog(@"response:%@",receiveStr);
    if ([g_request isKindOfClass:[LoginOrRegistRequest class]]) {
        LoginOrRegistResponse *respn = [(LoginOrRegistResponse *) [[LoginOrRegistResponse alloc] initWithJsonString:receiveStr] autorelease];
        if ([respn.returnCode isEqualToString:@"10001"]) { //请求成功
            NSLog(@"请求成功");
            [self showAlertWithTitle:@"" message:@"注册成功,请使用您的用户名和密码进行登陆"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSString *errMsg = [[[NSString alloc] initWithFormat:@"注册失败:%@", respn.returnMsg] autorelease];
            [self showAlertWithTitle:@"" message: errMsg ];
        }
    }
}

//处理错误应答
- (void)printError {
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
    [g_response release];
    [g_request release];
    [g_dataArray release];
    [super dealloc];
}

@end