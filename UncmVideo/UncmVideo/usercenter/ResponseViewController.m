//
// Created by xinyingtiyu on 13-3-19.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <QuartzCore/QuartzCore.h>
#import "ResponseViewController.h"
#import "SuperResponse.h"
#import "SuperRequest.h"
#import "SuggestRequest.h"
#import "SuggestResponse.h"

@implementation ResponseViewController {
#pragma mark 成员变量
    SuperResponse *g_response;
    SuperRequest *g_request;
    NSMutableArray *g_dataArray;
}

@synthesize fromString;

#pragma mark 设置页面
- (void)loadView {
    [super loadView];
    [self SET_HEADER_NAVIGATION];//统一设置头部导航条

    g_response_key;

    [self.view setBackgroundColor:RGBACOLOR(41, 41, 41, 1)];
    //输入
    g_textView = ((UITextView *) [self.view viewWithTag:14003]);
    g_textView.delegate = self;
    g_textView.layer.cornerRadius = 5;
    g_textView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
    //提交
    UIButton *btn = (UIButton *) [self.view viewWithTag:14002];
    [btn addTarget:self action:@selector(startHttpRequest) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"login_126_46"]
                   forState:UIControlStateNormal];
    //右边的箭头
    ((UIImageView *) [self.view viewWithTag:14001]).image = [UIImage imageNamed:@"ssports_logo.png"];

}

//统一设置头部导航条
- (void)SET_HEADER_NAVIGATION {
    [self.navigationController.navigationBar
            setBackgroundImage:[UIImage imageNamed:@"navi_bg_height_1.png"]
                 forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setContentMode:UIViewContentModeScaleToFill];
    self.navigationItem.title = self.fromString;
    //part1:导航栏-->  1.1 左边的导航条
    UIButton *left_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    left_btn.frame = CGRectMake(0, 0, 61, 30);
    [left_btn setTitle:@"  用户中心" forState:UIControlStateNormal];
    left_btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
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

- (void)alertWithTitle:(NSString *)title msg:(NSString *)msg {
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:title
                                                     message:msg
                                                    delegate:self cancelButtonTitle:@"确定"
                                           otherButtonTitles:nil] autorelease];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)finishedInput:(id)respd {
    [g_textView resignFirstResponder];
}

#pragma mark 联网部分
//开始联网。。。
- (void)startHttpRequest {
    SuggestRequest *req = [[SuggestRequest alloc] init];
    req.methodName = @"RequestSaveSuggest";
    req.userID = @"75";
    req.suggestContent = g_textView.text;
    g_request = req;
    [self startHttpJsonPost:req];
}

//将返回的成功数据进行处理
- (void)printResponse:(NSString *)receiveStr {
    if ([g_request isKindOfClass:[SuggestRequest class]]) {
        SuggestResponse *respn = [(SuggestResponse *) [[SuggestResponse alloc] initWithJsonString:receiveStr] autorelease];
        if ([respn.returnCode isEqualToString:@"10001"]) { //请求成功
            [self alertWithTitle:@"建议提交成功" msg:@"非常感谢您对我们工作的支持"];
        } else {
            NSLog(@"请求失败");
        }
    }
}

//处理错误应答
- (void)printError {
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 252, 120)] autorelease];
    imageView.image = [UIImage imageNamed:@"network_error_252_120.png"];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
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