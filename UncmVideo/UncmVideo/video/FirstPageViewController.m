#import "FirstPageViewController.h"
#import "VideoPlayViewController.h"
#import "SubsVideoListViewController.h"
#import "MagazineViewController.h"
#import "DemoTableHeaderView.h"
#import "BaseRequest.h"
#import "SuperResponse.h"
#import "VideoListRequest.h"
#import "VideoBean.h"
#import "VideoListResponse.h"
#import "AppDelegate.h"
#import "Subs2VideoListViewController.h"
#import "UserInfo.h"
#import "UserLoginNotChargedViewController.h"
#import "CommonHeaderView.h"
#import "HeaderViewInfoBean.h"
#import "UserNotLoginViewController.h"
#import "UserInfoDao.h"
#import "GlobalSetting.h"
#import "ImageDownloader.h"


@implementation FirstPageViewController {
#pragma mark 成员变量
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

    //放置联网错误图片
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 252, 120)] autorelease];
    imageView.tag = 9999;
    imageView.image = [UIImage imageNamed:@"network_error_252_120.png"];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    [imageView setUserInteractionEnabled:NO];
    UITapGestureRecognizer *recognizer = [[[UITapGestureRecognizer alloc]
            initWithTarget:self
                    action:@selector(startHttpRequest)] autorelease];
    [imageView addGestureRecognizer:recognizer];
    [imageView setHidden:YES];

    if ([GlobalSetting is_in_debug_mode]){//如果处于调试模式
        NSString *respStr = @"{\"timestamp\":\"1365582000\",\"returnCode\":\"10001\",\"returnMsg\":\"请求成功！\",\"videos\":[{\"team1Name\":\"西布朗\",\"team2Id\":\"91\",\"vDesc\":\"\",\"vPic\":\"\",\"team1ImageUrl\":\"http://161.2.1.205:8088/ssports_app/images/westbromwich1.png\",\"vStatus\":\"started\",\"team2Name\":\"曼联\",\"team2ImageUrl\":\"http://122.200.86.243:8088/ssports_app/images/manchesterunited.png\",\"vStart\":\"2013-04-09 17:41:11\",\"team1Id\":\"90\",\"vPic2\":\"http://bj-t.ml.streamocean.net:8088/console/null\",\"vName\":\"njtv-400k\",\"vUrl\":\"http://bj-t.ml.streamocean.net:8088/portal/noc/real/chinaunicome?vid=24&shifttime=1365500471&shiftend=1366191671\",\"videoId\":\"a8ac1221-8acb-451c-8f67-b906480aa72c\",\"start_time\":\"17:41\",\"vEnd\":\"2013-04-17 17:41:11\",\"start_date\":\"Apr 09,2013\"},{\"team1Name\":\"埃弗顿\",\"team2Id\":\"101\",\"vDesc\":\"testasdfasdfasdfasdfasdf=======================!!\",\"vPic\":\"http://bj-t.ml.streamocean.net:8088/console/upload/201303/14_809806.jpg\",\"team1ImageUrl\":\"http://122.200.86.243:8088/ssports_app/images/everton.png\",\"vStatus\":\"started\",\"team2Name\":\"曼城\",\"team2ImageUrl\":\"http://122.200.86.243:8088/ssports_app/images/manchestercity.png\",\"vStart\":\"2013-04-01 20:20:43\",\"team1Id\":\"95\",\"vPic2\":\"http://bj-t.ml.streamocean.net:8088/console/upload/201303/14_443812.jpg\",\"vName\":\"埃弗顿 VS 曼城\",\"vUrl\":\"http://bj-t.ml.streamocean.net:8088/portal/noc/real/chinaunicome?vid=18981&shifttime=1364818843&shiftend=1364826043\",\"videoId\":\"3bd6b21c-8527-4cd8-a62c-3ed5e37e8366\",\"start_time\":\"20:20\",\"vEnd\":\"2013-04-01 22:20:43\",\"start_date\":\"Apr 01,2013\"}]}";
//        NSString *respStr = @"{\"timestamp\":\"1365582000\",\"returnCode\":\"10001\",\"returnMsg\":\"请求成功！\",\"videos\":[{\"team1Name\":\"西布朗\",\"team2Id\":\"91\",\"vDesc\":\"\",\"vPic\":\"\",\"team1ImageUrl\":\"http://122.200.86.243:8088/ssports_app/images/westbromwich.png\",\"vStatus\":\"started\",\"team2Name\":\"曼联\",\"team2ImageUrl\":\"http://122.200.86.243:8088/ssports_app/images/manchesterunited.png\",\"vStart\":\"2013-04-09 17:41:11\",\"team1Id\":\"90\",\"vPic2\":\"http://bj-t.ml.streamocean.net:8088/console/null\",\"vName\":\"njtv-400k\",\"vUrl\":\"http://bj-t.ml.streamocean.net:8088/portal/noc/real/chinaunicome?vid=24&shifttime=1365500471&shiftend=1366191671\",\"videoId\":\"a8ac1221-8acb-451c-8f67-b906480aa72c\",\"start_time\":\"17:41\",\"vEnd\":\"2013-04-17 17:41:11\",\"start_date\":\"Apr 09,2013\"},{\"team1Name\":\"埃弗顿\",\"team2Id\":\"101\",\"vDesc\":\"testasdfasdfasdfasdfasdf=======================!!\",\"vPic\":\"http://bj-t.ml.streamocean.net:8088/console/upload/201303/14_809806.jpg\",\"team1ImageUrl\":\"http://122.200.86.243:8088/ssports_app/images/everton.png\",\"vStatus\":\"started\",\"team2Name\":\"曼城\",\"team2ImageUrl\":\"http://122.200.86.243:8088/ssports_app/images/manchestercity.png\",\"vStart\":\"2013-04-01 20:20:43\",\"team1Id\":\"95\",\"vPic2\":\"http://bj-t.ml.streamocean.net:8088/console/upload/201303/14_443812.jpg\",\"vName\":\"埃弗顿 VS 曼城\",\"vUrl\":\"http://bj-t.ml.streamocean.net:8088/portal/noc/real/chinaunicome?vid=18981&shifttime=1364818843&shiftend=1364826043\",\"videoId\":\"3bd6b21c-8527-4cd8-a62c-3ed5e37e8366\",\"start_time\":\"20:20\",\"vEnd\":\"2013-04-01 22:20:43\",\"start_date\":\"Apr 01,2013\"}]}";
        g_request = [[VideoListRequest alloc] init];
        [self printResponse:respStr];
    }else{
        //开始联网。。。
        [self startHttpRequest];
    }
}

//统一设置头部导航条
- (void)SET_HEADER_NAVIGATION {
    //表头的设置
    CommonHeaderView *commonHeaderView = [[[CommonHeaderView alloc] initWitHighlightIndex:1] autorelease];
    commonHeaderView.delegate = self;
    NSString *titleName = @"英超视频";
    if ([GlobalSetting is_in_debug_mode]){
        titleName = @"英超视频_测试版本";
    }
    [commonHeaderView setNavi:[[[HeaderViewInfoBean alloc] initWithTitle:titleName leftBtnImgName:@"magzine_37_28" leftBtnImgName:@"usercenter_38_28"] autorelease]];
    [self.view addSubview:commonHeaderView];
}

#pragma mark 联网部分
//开始联网
- (void)startHttpRequest {
    VideoListRequest *req = [[VideoListRequest alloc] init];
    req.methodName = @"RequestListVideo";
    req.type = @"live"; //直播视频
    g_request = req;
    [self startHttpJsonPost:req];
}

//处理错误应答
- (void)printError {
    [self stopActivity];
    if ([self.view viewWithTag:9999] != nil){
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:9999];
        [imageView setHidden:NO];
        [imageView setUserInteractionEnabled:YES];

    }
}

//处理成功应答
- (void)printResponse:(NSString *)receiveStr {
    NSLog(@"responseStr:%@", receiveStr);
    if ([g_request isKindOfClass:[VideoListRequest class]]) {
        VideoListResponse *respn = [(VideoListResponse *) [[VideoListResponse alloc] initWithJsonString:receiveStr] autorelease];
        if ([respn.returnCode isEqualToString:@"10001"]) { //请求成功
            if([g_dataArray count] > 0){
                [g_dataArray removeAllObjects];
            }
            for (NSDictionary *dictionary in respn.videos) {
                VideoBean *videoBean = [VideoBean initWithDic:dictionary];
                videoBean.vDesc = nil;
                videoBean.vStatus = @"not_start";
                [g_dataArray addObject:videoBean];
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

#pragma mark 表格部分
//点击某行记录会触发的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoBean *videoBean = [g_dataArray objectAtIndex:(NSUInteger) indexPath.row];
    if (nil == videoBean || videoBean.vUrl == nil) {
        return;
    }
    VideoPlayViewController *controller = [[[VideoPlayViewController alloc] init] autorelease];
    controller.videoUrl = videoBean.vUrl;
    [self.navigationController pushViewController:controller animated:NO];
}

//绘制单元格
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoBean *videoBean = [g_dataArray objectAtIndex:(NSUInteger) indexPath.row];
    NSString *nibName = @"FPTableNoDescCellView";
    if (videoBean.vDesc != nil && ![@"" isEqualToString:videoBean.vDesc]) { //有描述
        nibName = @"FPTableCellView";
    }
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    UITableViewCell *cell = (UITableViewCell *) [nib objectAtIndex:0];
    if (videoBean.vDesc != nil && ![@"" isEqualToString:videoBean.vDesc]) { //有描述
        UILabel *descLabel = (UILabel *) [cell viewWithTag:7007];//描述
        descLabel.text = videoBean.vDesc;
    }

    UIImageView *statusImgView = (UIImageView *) [cell viewWithTag:7004];//比赛状态图标
    UILabel *statusLabel = (UILabel *) [cell viewWithTag:7012];//比赛状态，已结束 | 直播中 | 未开始
    UIImageView *bgImgView = (UIImageView *) [cell viewWithTag:7008];//背景
    bgImgView.image = [UIImage imageNamed:@"cell_grey_no_word_300_62.png"];
    if ([@"finished" isEqualToString:videoBean.vStatus]) {
        statusLabel.text = @"已结束";
        statusImgView.image = [UIImage imageNamed:@"finish_49_18.png"];
        if (videoBean.vDesc != nil && ![@"" isEqualToString:videoBean.vDesc]) { //有描述
            bgImgView.image = [UIImage imageNamed:@"cell_grey_has_word_300_101.png"];
        }
    } else {
        bgImgView.image = [UIImage imageNamed:@"cell_no_word_300_62.png"];
        if (videoBean.vDesc != nil && ![@"" isEqualToString:videoBean.vDesc]) { //有描述
            bgImgView.image = [UIImage imageNamed:@"cell_has_word_300_101.png"];
        }

        if ([@"started" isEqualToString:videoBean.vStatus]) {
            statusLabel.text = @"未开始";
            statusImgView.image = [UIImage imageNamed:@"before_49_18.png"];
        } else {
            statusLabel.text = @"直播中";
            statusImgView.image = [UIImage imageNamed:@"goging_49_18.png"];
        }
    }

    UILabel *homeNameLabel = (UILabel *) [cell viewWithTag:7001];//主队名称
    homeNameLabel.text = videoBean.team1Name;
    UILabel *timeLabel = (UILabel *) [cell viewWithTag:7003];//比赛时间
    timeLabel.text = videoBean.start_time;
    UILabel *dateLabel = (UILabel *) [cell viewWithTag:7011];//比赛日期
    dateLabel.text = videoBean.start_date;
    UIImageView *homeImgView = (UIImageView *) [cell viewWithTag:7002];//主队图标
//    if (![GlobalSetting is_in_debug_mode]){//如果不处于调试模式
        int tag_int = 10 * indexPath.row + 100000 + 1;
        homeImgView.tag = tag_int;
        NSString *tag_str = [[[NSString alloc] initWithFormat:@"%d", tag_int] autorelease];
        [self fireImageDownloadWithUrlStr:videoBean.team1ImageUrl tagStr:tag_str];
//    }

    UILabel *guestNameLabel = (UILabel *) [cell viewWithTag:7006];//客队名称
    guestNameLabel.text = videoBean.team2Name;
    UIImageView *guestImgView = (UIImageView *) [cell viewWithTag:7005];//客队图标
//    if (![GlobalSetting is_in_debug_mode]){//如果不处于调试模式
        tag_int = 10 * indexPath.row + 100000 + 2;
        guestImgView.tag = tag_int;
        tag_str = [[[NSString alloc] initWithFormat:@"%d", tag_int] autorelease];
        [self fireImageDownloadWithUrlStr:videoBean.team2ImageUrl tagStr:tag_str];
//    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)fireImageDownloadWithUrlStr:(NSString *)urlStr tagStr:(NSString *)tagStr{
    ImageDownloader *downloader = [[[ImageDownloader alloc] initWithURLString:urlStr] autorelease];
    downloader.delegate = self;
    downloader.delPara = tagStr;
    NSOperationQueue* queue = [[[NSOperationQueue alloc] init] autorelease];
    [queue addOperation:downloader];
}

- (void)imageDidFinished:(UIImage *)image para:(NSObject *)obj{
    NSString *tag_str = (NSString *)obj;//附带的参数；
    int tag_int = [tag_str intValue];
    UIImageView *imageView = (UIImageView *) [self.view viewWithTag:tag_int];
    imageView.image = image;
}
- (void)imageDidErrorFinished:(UIImage *)image para:(NSObject *)obj{
    NSString *tag_str = (NSString *)obj;//附带的参数；首次上传江苏联通ios代码
    int tag_int = [tag_str intValue];
    UIImageView *imageView = (UIImageView *) [self.view viewWithTag:tag_int];
    imageView.image = [UIImage imageNamed:@"magazine_default_error.jpg"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return [g_dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int result = 65;
    if (nil != g_dataArray && [g_dataArray count] > indexPath.row) {
        VideoBean *videoBean = [g_dataArray objectAtIndex:(NSUInteger) indexPath.row];
        if (nil != videoBean && nil != videoBean.vDesc && ![@"" isEqualToString:videoBean.vDesc]) {
            result = 105;
        }
    }
    return result;
}

#pragma mark 导航条
//点击右导航条触发的动作
- (void)responseRight {
    UserInfoDao *userInfoDao = [[[UserInfoDao alloc] init] autorelease];
    NSMutableArray *resultArr = userInfoDao.queryDataFromDB;
    if (nil == resultArr || [resultArr count] == 0){
        UserNotLoginViewController *controller = [[[UserNotLoginViewController alloc]
                initWithNibName:@"User_notloginViewController" bundle:nil] autorelease];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        UserInfo *userInfo = [resultArr objectAtIndex:0];
        UserLoginNotChargedViewController *controller = [[[UserLoginNotChargedViewController alloc]
                initWithNibName:@"User_login_notcharged_ViewController" bundle:nil] autorelease];
        controller.userPhone = userInfo.phone;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

//点击左导航条触发的动作
- (void)responseLeft {
    MagazineViewController *controller = [[[MagazineViewController alloc] init] autorelease];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)gotoFP {
}

- (void)gotoSubs {
    NSLog(@"直播回看");
    SubsVideoListViewController *controller = [[[SubsVideoListViewController alloc] init] autorelease];
    [self.navigationController pushViewController:controller animated:NO];
}

- (void)gotoSubs2 {
    NSLog(@"视频集锦");
    Subs2VideoListViewController *controller = [[[Subs2VideoListViewController alloc] init] autorelease];
    [self.navigationController pushViewController:controller animated:NO];
}

#pragma mark 析构函数部分
- (void)dealloc {
//    [g_tableView release];
    [g_response release];
    [g_request release];
    [g_dataArray release];
    [super dealloc];
}

@end