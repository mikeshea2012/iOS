//
// Created by xinyingtiyu on 13-3-20.
//
// To change the template use AppCode | Preferences | File Templates.
//



#import "MagazinePageViewController.h"
#import "SuperRequest.h"
#import "MagzineDetailListRequest.h"
#import "MagazineDetailListResponse.h"
#import "FileUtil.h"
#import "MagazineBean.h"
#import "MagazineDetailDao.h"
#import "MagazineDetailBean.h"
#import "AppDelegate.h"

@implementation MagazinePageViewController {
    NSMutableData *receiveData;
    SuperRequest *g_request;
//    NSURL *testUrl;
}

@synthesize magazine_issueNo, serverBookId,magazineName;


//统一设置头部导航条
- (void)SET_HEADER_NAVIGATION {
    [self.navigationController.navigationBar
            setBackgroundImage:[UIImage imageNamed:@"navi_bg_height_1.png"]
                 forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setContentMode:UIViewContentModeScaleToFill];
    self.navigationItem.title = self.magazineName;
    //part1:导航栏-->  1.1 左边的导航条
    UIButton *left_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    left_btn.frame = CGRectMake(0, 0, 61, 30);
    [left_btn setTitle:@"返回" forState:UIControlStateNormal];
    [left_btn setBackgroundImage:[UIImage imageNamed:@"back_61_30"] forState:UIControlStateNormal];
    [left_btn addTarget:self action:@selector(responseLeft:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left_barBtn = [[[UIBarButtonItem alloc] initWithCustomView:left_btn] autorelease];
    self.navigationItem.leftBarButtonItem = left_barBtn;
}


//设置页面
- (void)loadView {
    [super loadView];
    int pagNumber = 0;
    if (magazine_issueNo == 21) {
        pagNumber = 5;
    }
    if (magazine_issueNo == 22) {
        pagNumber = 8;
    }
    [self SET_HEADER_NAVIGATION];//统一设置头部导航条

    //进行联网操作
    NSLog(@"开始联网操作...");
    [self startHttpRequest];
}

- (void)startHttpRequest {
    NSLog(@"startHttpRequest");
    MagzineDetailListRequest *req = [[MagzineDetailListRequest alloc] init];
    req.methodName = @"RequestListTbMobilBookResource"; //  杂志资源列表
    req.magzineID = self.serverBookId;
    g_request = req;
    [self startHttpJsonPost:req];
    [self showActivity];
}

- (void)startHttpJsonPost:(SuperRequest *)req {
    NSLog(@"startHttpJsonPost");
    NSString *jsonStr = req.getJsonStr;
    //第二步，创建请求
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *str_srvUrl = app.str_serviceUrl;
    NSURL *svcUrl = [NSURL URLWithString:str_srvUrl];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:svcUrl
                                                                 cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:20] autorelease];
    [request setHTTPMethod:@"POST"];
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    receiveData = [[NSMutableData alloc] init];
    [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
}

//点击左导航条触发的动作
- (void)responseLeft:(id)button {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 将返回的数据打印出来
- (void)printResponse:(NSString *)receiveStr {
    NSLog(@"-[MagazinePageViewController printResponse:].....");
    if ([g_request isKindOfClass:[MagzineDetailListRequest class]]) {
        MagazineDetailListResponse *respn = [(MagazineDetailListResponse *) [[MagazineDetailListResponse alloc]
                initWithJsonString:receiveStr] autorelease];
        if (nil != respn && respn.MagazineBeans != nil && [respn.MagazineBeans count] > 0) {
            //如果联网成功，首先更新数据库
            MagazineDetailDao *magazineDetailDao = [[[MagazineDetailDao alloc] init] autorelease];
            MagazineDetailBean *magazineDetailBean = [[[MagazineDetailBean alloc] init]autorelease] ;
            magazineDetailBean.bookId = self.serverBookId;
            magazineDetailBean.bookDetailJsonStr = receiveStr;
            [magazineDetailDao updateOrInsertTable:magazineDetailBean];

            UIScrollView *scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 418)] autorelease];
            scrollView.contentSize = CGSizeMake(320 * [respn.MagazineBeans count], 418);
            scrollView.pagingEnabled = YES;
            //隐藏滚动条
            scrollView.showsHorizontalScrollIndicator = NO;
            scrollView.showsVerticalScrollIndicator = NO;
            //关闭翻滚到顶部
            scrollView.scrollsToTop = NO;
            int i = 0;
            for (NSDictionary *beanDict  in respn.MagazineBeans) {
                i++;
                NSString *vc2PicUrl = [beanDict objectForKey:@"vc2PicUrl"];
                NSString *numBookId = [beanDict objectForKey:@"numBookId"];
                NSLog(@"numBookId=%@,vc2PicUrl=%@", numBookId,vc2PicUrl);
                NSData *imgData = nil;
                if (nil != vc2PicUrl) {
                    imgData = [self getImageDataFromURL:vc2PicUrl];
                }
                UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(320 * (i - 1), 0, 320, 418)] autorelease];
                if (imgData == nil){
                    imageView.image = [UIImage imageNamed:@"21_1_320_418.jpg"];
                }else{
                    imageView.image = [UIImage imageWithData:imgData];
                    //将文件保存到文件系统
                    [FileUtil writeImageData:imgData ToFileWithName:[[[NSString alloc] initWithFormat:@"%@_%d",numBookId,i] autorelease]];
                }
                [scrollView addSubview:imageView];
            }
            [self.view addSubview:scrollView];

        }
        NSLog(@"respn");
    }
}

- (NSData *)getImageDataFromURL:(NSString *)fileUrl {
    NSLog(@"getImageFromURL");
    UIImage *result;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileUrl]];
    return data;
}


//接收到服务器回应的时候调用此方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [receiveData setLength:0];
}

//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"didReceiveData");
    [receiveData appendData:data];
}

//数据传完之后调用此方法
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    [self stopActivity];//停止联网状态轮
    NSString *receiveStr = [[[NSString alloc] initWithData:receiveData encoding:NSUTF8StringEncoding] autorelease];
    [self printResponse:receiveStr];
}

//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self stopActivity];
    NSLog(@"didFailWithError:%@", [error localizedDescription]);

    //如果联网失败，首先读取数据库的值
    MagazineDetailDao *magazineDetailDao = [[[MagazineDetailDao alloc] init] autorelease];
    MagazineDetailBean *magazineDetailBean =  [magazineDetailDao queryDataFromDBById:self.serverBookId];
    if (nil == magazineDetailBean || magazineDetailBean.bookDetailJsonStr == nil){
        return;
    }
    NSString *receiveStr = magazineDetailBean.bookDetailJsonStr;
        MagazineDetailListResponse *respn = [(MagazineDetailListResponse *) [[MagazineDetailListResponse alloc]
                initWithJsonString:receiveStr] autorelease];
        if (nil != respn && respn.MagazineBeans != nil && [respn.MagazineBeans count] > 0) {

            UIScrollView *scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 418)] autorelease];
            scrollView.contentSize = CGSizeMake(320 * [respn.MagazineBeans count], 418);
            scrollView.pagingEnabled = YES;
            //隐藏滚动条
            scrollView.showsHorizontalScrollIndicator = NO;
            scrollView.showsVerticalScrollIndicator = NO;
            //关闭翻滚到顶部
            scrollView.scrollsToTop = NO;
            int i = 0;
            for (NSDictionary *beanDict  in respn.MagazineBeans) {
                i++;
                NSString *vc2PicUrl = [beanDict objectForKey:@"vc2PicUrl"];
                NSString *numBookId = [beanDict objectForKey:@"numBookId"];
                NSLog(@"numBookId=%@,vc2PicUrl=%@", numBookId,vc2PicUrl);
                UIImage *img = nil;
                //从本地获取
                NSString *fileName = [[[NSString alloc] initWithFormat:@"%@_%d",numBookId,i] autorelease];
                img = [FileUtil loadImgDateFromFile:fileName];

                UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(320 * (i - 1), 0, 320, 418)] autorelease];
                if (img == nil){
                    return;
                }else{
                    imageView.image = img;
                }
                [scrollView addSubview:imageView];
            }
            [self.view addSubview:scrollView];

        }
        NSLog(@"respn");


}


//显示联网状态
-(void)showActivity{
    UIActivityIndicatorView *indicatorView = [[[UIActivityIndicatorView alloc]
            initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    indicatorView.frame = CGRectMake(0, 0, 100, 100);
    indicatorView.center = self.view.center;
    [self.view addSubview:indicatorView];
    [indicatorView startAnimating];
    indicatorView.tag = 7180;
}

//停止联网状态
-(void)stopActivity{
    id view = [self.view viewWithTag:7180];
    if (nil == view){
        return;
    }
    UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)view;
    if (nil == indicatorView){
        return;
    }
    if ([indicatorView isAnimating]){
        [indicatorView stopAnimating];
    }
}

- (void)dealloc {
    [g_request release];
    [receiveData release];
    [serverBookId release];
    [super dealloc];
}



@end