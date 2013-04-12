//
// Created by xinyingtiyu on 13-3-19.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UserLoginNotChargedViewController.h"
#import "FirstPageViewController.h"
#import "UserCenterView.h"
#import "UserInfoDao.h"

@implementation UserLoginNotChargedViewController

@synthesize userPhone;

#pragma mark 设置页面
- (void)loadView {
    [super loadView];
    [self SET_HEADER_NAVIGATION];//统一设置头部导航条
    //针对不同的屏幕进行适配
    int delta = (int)([UIScreen mainScreen].bounds.size.height - 480.0);
    [self.view setBackgroundColor:RGBACOLOR(41, 41, 41, 1)];
    //表格
    UserCenterView *userCenterView = [[[UserCenterView alloc] initWithFrame:CGRectMake(10, 130, 300, 252)] autorelease];
    [self.view addSubview:userCenterView];
    //企业图标
    UIImageView *logoImgView = ((UIImageView *) [self.view viewWithTag:1005]);
    logoImgView.image = [UIImage imageNamed:@"ssports_logo.png"];
    int x = 226, y = 388+delta, w = 87, h = 27;
    logoImgView.frame = CGRectMake(x, y, w, h);
    //用户名(手机号码)
    UIButton *cellBtn = (UIButton *) [self.view viewWithTag:1002];
    cellBtn.titleLabel.text = self.userPhone;
    //为注销按钮添加功能页面
    UILabel *writeOffLabel = (UILabel *) [self.view viewWithTag:1003];
    writeOffLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(writeOff)] autorelease];
    [writeOffLabel addGestureRecognizer:singleTap];


}

//注销
-(void)writeOff{
    UserInfoDao *userInfoDao = [[[UserInfoDao alloc] init] autorelease];
    [userInfoDao eraseDBByTableName];
    [self showAlertWithTitle:@"提示:" message:@"注销成功"];
    FirstPageViewController *controller = [[[FirstPageViewController alloc] init] autorelease];
    [self.navigationController pushViewController:controller animated:YES];
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

    self.navigationItem.title = @"个人中心";

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

}

#pragma mark 导航条
//点击右导航条触发的动作
- (void)responseRight {
}

//点击左导航条触发的动作
- (void)responseLeft {
    FirstPageViewController *controller = [[[FirstPageViewController alloc] init] autorelease];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)gotoFP {
}

- (void)gotoSubs {
}

- (void)gotoSubs2 {
}


@end