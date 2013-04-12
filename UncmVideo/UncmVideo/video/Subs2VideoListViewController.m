//
// Created by xinyingtiyu on 13-3-1.
//
// To change the template use AppCode | Preferences | File Templates.
//
#import "STableViewController.h"
#import "CommonHeadProtocol.h"
#import "Subs2VideoListViewController.h"
#import "VideoPlayViewController.h"
#import "FirstPageViewController.h"
#import "UserNotLoginViewController.h"
#import "MagazineViewController.h"
#import "DemoTableHeaderView.h"
#import "DemoTableFooterView.h"
#import "SubsVideoListViewController.h"
#import "SuperResponse.h"
#import "SuperRequest.h"
#import "QueryVideoRequest.h"
#import "QueryVideoResponse.h"
#import "QueryVideoBean.h"
#import "CommonHeaderView.h"
#import "HeaderViewInfoBean.h"
#import "MikeStringUtil.h"
#import "GlobalSetting.h"

@implementation Subs2VideoListViewController {
#pragma mark 成员变量
    NSMutableData *receiveData;
    SuperResponse *g_response;
    SuperRequest *g_request;
    NSMutableArray *g_dataArray;
}

#pragma mark 设置页面
- (void)viewDidLoad {
    [super viewDidLoad];
    //针对不同的屏幕进行适配
    int delta = (int)([UIScreen mainScreen].bounds.size.height - 480.0);
    g_dataArray = [[NSMutableArray alloc] init];

    [self.view setBackgroundColor:RGBACOLOR(41, 41, 41, 1)];
    [self SET_HEADER_NAVIGATION];//统一设置头部导航条
    self.tableView.frame = CGRectMake(10, 40, 300, 380+delta);
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    //企业图标 226,388,87,27
    int x = 226, y = 388+delta, w = 87, h = 27;
    UIImageView *logoImgView = [[[UIImageView alloc] initWithImage:
            [UIImage imageNamed:@"ssports_logo.png"]] autorelease];
    logoImgView.frame = CGRectMake(x, y, w, h);
    [self.view addSubview:logoImgView];

    // set the custom view for "pull to refresh". See DemoTableHeaderView.xib.
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableHeaderView" owner:self options:nil];
    DemoTableHeaderView *headerView = (DemoTableHeaderView *) [nib objectAtIndex:0];
    self.headerView = headerView;

    if ([GlobalSetting is_in_debug_mode]){//如果处于调试模式
        NSString *respStr = @"{\"to\":0,\"returnCode\":\"10001\",\"magazineBeans\":null,\"magazineResourceBeans\":null,\"returnMsg\":\"请求成功！\",\"totalNumber\":10,\"from\":0,\"videoBeans\":[{\"vc2title\":\"18\",\"vc2videourlunited\":\"http://video.ssports.streamocean.com/vod/69D294D0-0E29-7EAA-0C12-3198C8D17D51?fmt=x264_1534K_flv&cpid=xinying\",\"vc2summary\":\"发生股份围绕其感情而个人供热阿萨德噶是打发斯蒂芬现在的发生股份围绕其感情而个人供热阿萨德噶是打发斯蒂芬现在的\",\"vc2thumbpicurl\":\"http://161.2.1.235/images/resources/2012/1212/1ef80364-f7c0-44bd-93e3-c447c0fc840b.jpg\"},{\"vc2title\":\"16\",\"vc2videourlunited\":\"2222222222222222222222222222222222\",\"vc2summary\":null,\"vc2thumbpicurl\":\"http://161.2.1.235/images/resourcesnull\"},{\"vc2title\":\"15\",\"vc2videourlunited\":\"http://bj-m.ml.streamocean.net:80/vod/0FD127DE-59A2-D61A-5090-0A4108EAADE4?fmt=x264_1562K_flv&cpid=xinying\",\"vc2summary\":\"可的发神经了可适当法减肥了卡三等奖发生的仿盛大\",\"vc2thumbpicurl\":\"http://161.2.1.235/images/resources/2013/0403/4522c66f-ee37-40ce-99b8-801447474fa8.jpg\"},{\"vc2title\":\"19\",\"vc2videourlunited\":\"http://111111111111111111111111111111111111\",\"vc2summary\":null,\"vc2thumbpicurl\":\"http://161.2.1.235/images/resources/2013/0131/85d65e0e-8d1c-4b37-8b3b-adc633962543.jpg\"},{\"vc2title\":\"123\",\"vc2videourlunited\":null,\"vc2summary\":null,\"vc2thumbpicurl\":\"http://161.2.1.235/images/resourcesnull\"}]}";
        g_request = [[QueryVideoRequest alloc] init];
        [self printResponse:respStr];
    }else{
        //开始联网。。。
        [self startHttpRequest];
    }
}

//统一设置头部导航条
- (void)SET_HEADER_NAVIGATION {
    //表头的设置
    CommonHeaderView *commonHeaderView = [[[CommonHeaderView alloc] initWitHighlightIndex:3] autorelease];
    commonHeaderView.delegate = self;
    [commonHeaderView setNavi:[[[HeaderViewInfoBean alloc] initWithTitle:@"英超视频" leftBtnImgName:@"magzine_37_28" leftBtnImgName:@"usercenter_38_28"] autorelease]];
    [self.view addSubview:commonHeaderView];
}

#pragma mark 联网部分
//开始联网。。。
- (void)startHttpRequest {
    QueryVideoRequest *req = [[QueryVideoRequest alloc] init];
    req.startNUM = @"0";
    req.endNUM = @"5";
    req.methodName = @"RequestQueryVideo";
    g_request = req;
    [self startHttpJsonPost:req];
}

//处理错误应答
- (void)printError {
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 252, 120)] autorelease];
    imageView.image = [UIImage imageNamed:@"network_error_252_120.png"];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
}

//处理成功应答
- (void)printResponse:(NSString *)receiveStr {
    NSLog(@"responseStr:%@",receiveStr);
    if ([g_request isKindOfClass:[QueryVideoRequest class]]) {
        QueryVideoResponse *respn = [(QueryVideoResponse *) [[QueryVideoResponse alloc] initWithJsonString:receiveStr] autorelease];
        if ([respn.returnCode isEqualToString:@"10001"]) { //请求成功
            NSLog(@"请求成功");
            if([g_dataArray count] > 0){
                [g_dataArray removeAllObjects];
            }
            for (NSDictionary *dictionary in respn.videoBeans) {
                [g_dataArray addObject:[QueryVideoBean initWithDic:dictionary]];
            }
            [self.tableView reloadData];
        } else {
            NSLog(@"请求失败");
        }
    }
}

#pragma mark - 顶部刷新
- (void)addItemsOnTop { //头部更新
    [self refreshCompleted];
    if (![GlobalSetting is_in_debug_mode]){//如果不处于调试模式
        [self startHttpRequest];
    }
}

#pragma mark -   表格部分
//点击某行记录会触发的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QueryVideoBean *videoBean = [g_dataArray objectAtIndex:(NSUInteger) indexPath.row];
    if (nil == videoBean || videoBean.vc2videourlunited == nil) {
        return;
    }
    VideoPlayViewController *controller = [[[VideoPlayViewController alloc] init] autorelease];
    controller.videoUrl = videoBean.vc2videourlunited;
    [self.navigationController pushViewController:controller animated:NO];
}

//绘制表格
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FP3TableCellView" owner:self options:nil];
    UITableViewCell *cell = (UITableViewCell *) [nib objectAtIndex:0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    QueryVideoBean *videoBean = [g_dataArray objectAtIndex:(NSUInteger) indexPath.row];
    if (![MikeStringUtil isEmptyOrNull:videoBean.vc2title]){
        UILabel *titleLabel = (UILabel *) [cell viewWithTag:7001];//标题
        titleLabel.text = videoBean.vc2title;
    }
    if (![MikeStringUtil isEmptyOrNull:videoBean.vc2summary]){
        UILabel *descLabel = (UILabel *) [cell viewWithTag:7003];//描述
        descLabel.text = videoBean.vc2summary;
    }

    UIImageView *imageView = (UIImageView *) [cell viewWithTag:7002];
    NSString *vc2PicUrl = videoBean.vc2thumbpicurl;
    NSData *imgData = nil;
    if (![MikeStringUtil isEmptyOrNull:vc2PicUrl]) {
        NSLog(@"%@",vc2PicUrl);
        if (![GlobalSetting is_in_debug_mode]){//如果不处于调试模式
           imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:vc2PicUrl]];
        }
    }
    if (imgData != nil) {
        imageView.image = [UIImage imageWithData:imgData];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return [g_dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int result = 105;
    return result;
}

#pragma mark 导航条及头部选项
//点击右导航条触发的动作
- (void)responseRight {

    UserNotLoginViewController *controller = [[[UserNotLoginViewController alloc]
            initWithNibName:@"User_notloginViewController" bundle:nil] autorelease];
    [self.navigationController pushViewController:controller animated:YES];
}

//点击左导航条触发的动作
- (void)responseLeft {
    MagazineViewController *controller = [[[MagazineViewController alloc] init] autorelease];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)gotoSubs2 {
}

- (void)gotoFP {
    FirstPageViewController *controller = [[[FirstPageViewController alloc] init] autorelease];
    [self.navigationController pushViewController:controller animated:NO];
}

- (void)gotoSubs {
    SubsVideoListViewController *controller = [[[SubsVideoListViewController alloc] init] autorelease];
    [self.navigationController pushViewController:controller animated:NO];
}

#pragma mark 析构函数部分
- (void)dealloc {
//    [g_tableView release];
    [receiveData release];
    [g_response release];
    [g_request release];
    [g_dataArray release];
    [super dealloc];
}

@end