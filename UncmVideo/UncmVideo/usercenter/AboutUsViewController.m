//
// Created by xinyingtiyu on 13-3-19.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "AboutUsViewController.h"


@implementation AboutUsViewController
@synthesize fromStr;

//点击左导航条触发的动作
- (void)responseLeft:(id)button {
    [self.navigationController popViewControllerAnimated:YES];
}

//统一设置头部导航条
- (void)SET_HEADER_NAVIGATION {
    [self.navigationController.navigationBar
            setBackgroundImage:[UIImage imageNamed:@"navi_bg_height_1.png"]
                 forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setContentMode:UIViewContentModeScaleToFill];

    self.navigationItem.title = self.fromStr;

    //part1:导航栏-->  1.1 左边的导航条
    UIButton *left_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    left_btn.frame = CGRectMake(0, 0, 61, 30);
    [left_btn setTitle:@"  用户中心" forState:UIControlStateNormal];
    left_btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    left_btn.titleLabel.textAlignment = (NSTextAlignment) UITextAlignmentRight;
    [left_btn setBackgroundImage:[UIImage imageNamed:@"back_61_30"] forState:UIControlStateNormal];
    [left_btn addTarget:self action:@selector(responseLeft:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left_barBtn = [[[UIBarButtonItem alloc] initWithCustomView:left_btn] autorelease];
    self.navigationItem.leftBarButtonItem = left_barBtn;
}

//设置页面
- (void)loadView {
    [super loadView];
    //针对不同的屏幕进行适配
    int delta = (int)([UIScreen mainScreen].bounds.size.height - 480.0);
    [self SET_HEADER_NAVIGATION];//统一设置头部导航条
    [self.view setBackgroundColor:RGBACOLOR(41, 41, 41, 1)];
    //企业图标
    UIImageView *logoImgView = ((UIImageView *) [self.view viewWithTag:13002]);
    logoImgView.image = [UIImage imageNamed:@"ssports_logo.png"];
    int x = 226, y = 388+delta, w = 87, h = 27;
    logoImgView.frame = CGRectMake(x, y, w, h);

    UIImageView *steamLogo =  ((UIImageView *) [self.view viewWithTag:13001]);
    x = 13, y = 388+delta, w = 87, h = 27;
    steamLogo.image = [UIImage imageNamed:@"streamocean_logo_104_36.png"];
    steamLogo.frame = CGRectMake(x, y, w, h);

    ((UITextView *) [self.view viewWithTag:13003]).backgroundColor = [UIColor clearColor];


//     UITableViewCell *cellView = (UITableViewCell *)[self.view viewWithTag:888];
//    cellView.frame = CGRectMake(0, 240, 100, 200);
//    [cellView setBackgroundColor:[UIColor redColor]];
//    [self.view addSubview:cellView];

//    UIView *allTestView = [[[UIView alloc] initWithFrame:CGRectMake(0, 200, 100, 200)] autorelease];
//    allTestView.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:allTestView];
//    NSArray *viewArray = [[NSBundle mainBundle] loadNibNamed:@"CommonItems"
//                                                     owner:self
//                                                   options:NULL] ;
//    UIView *topView = [viewArray objectAtIndex:0];
//    [topView setBackgroundColor:[UIColor clearColor]];
//    UIView *cellView = [topView viewWithTag:7011];
//    cellView.frame = CGRectMake(0, 200, 100, 200);
//    cellView.backgroundColor = [UIColor yellowColor];
//    [allTestView addSubview:cellView];
//    if(testView == nil){
//        NSLog(@"testView == nil");
//    }else{
//        NSLog(@"testView != nil");
//    }



//    [self.view addSubview:testView];

}


@end