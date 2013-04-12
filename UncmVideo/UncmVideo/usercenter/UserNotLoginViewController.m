//
//  HomeViewController.m
//  Tuoshu
//
//  Created by yager on 13-3-16.
//  Copyright (c) 2013年 yager. All rights reserved.
//

//#import "HomeViewController.h"
//#import "CateListController.h"
//#import "AppDelegate.h"


//用户中心 未登录页面
#import "CommonHeadProtocol.h"
#import "UserNotLoginViewController.h"
#import "LoginViewController.h"
#import "UserCenterView.h"

@implementation UserNotLoginViewController

#pragma mark 设置页面
- (void)loadView {
    [super loadView];
    [self SET_HEADER_NAVIGATION];//统一设置头部导航条
    //针对不同的屏幕进行适配
    int delta = (int)([UIScreen mainScreen].bounds.size.height - 480.0);
    [self.view setBackgroundColor:RGBACOLOR(41, 41, 41, 1)];
    //右边的箭头
    ((UIImageView *) [self.view viewWithTag:12001]).image = [UIImage imageNamed:@"arrow_73_101"];
    //感叹号
    ((UIImageView *) [self.view viewWithTag:12002]).image = [UIImage imageNamed:@"gantan_icon_24_25.png"];
    //企业图标
    UIImageView *logoImgView = ((UIImageView *) [self.view viewWithTag:12003]);
    logoImgView.image = [UIImage imageNamed:@"ssports_logo.png"];
    int x = 226, y = 388+delta, w = 87, h = 27;
    logoImgView.frame = CGRectMake(x, y, w, h);
    //表格
    UserCenterView *userCenterView = [[UserCenterView alloc] initWithFrame:CGRectMake(10, 130, 300, 252)] ;
    [self.view addSubview:userCenterView];
}

//统一设置头部导航条
- (void)SET_HEADER_NAVIGATION {
    [self.navigationController.navigationBar
            setBackgroundImage:[UIImage imageNamed:@"navi_bg_height_1.png"]
                 forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setContentMode:UIViewContentModeScaleToFill];

    self.navigationItem.title = @"用户中心";

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
    UIButton *right_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    right_btn.frame = CGRectMake(0, 0, 48, 28);
    [right_btn setTitle:@"登陆" forState:UIControlStateNormal];
    right_btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    right_btn.titleLabel.textAlignment = (NSTextAlignment) UITextAlignmentCenter;
    [right_btn setBackgroundImage:[UIImage imageNamed:@"right_btn_48_28"] forState:UIControlStateNormal];
    [right_btn addTarget:self action:@selector(responseRight) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right_barBtn = [[[UIBarButtonItem alloc] initWithCustomView:right_btn] autorelease];
    self.navigationItem.rightBarButtonItem = right_barBtn;
}

#pragma mark 导航条
//点击右导航条触发的动作
- (void)responseRight {
    LoginViewController *controller = [[[LoginViewController alloc]
            initWithNibName:@"LoginViewController" bundle:nil] autorelease];
    [self.navigationController pushViewController:controller animated:YES];
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


@end
