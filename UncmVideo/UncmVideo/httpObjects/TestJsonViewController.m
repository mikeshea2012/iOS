//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "TestJsonViewController.h"
#import "LiveDayRequest.h"
#import "SuperResponse.h"
#import "LiveDayResponse.h"
#import "LoginRequest.h"
#import "BaseRequest.h"
#import "LoginResponse.h"
#import "VideoListRequest.h"
#import "VideoListResponse.h"
#import "MagzineListRequest.h"
#import "MagazineListResponse.h"
#import "VideoUrlRequest.h"
#import "VideoUrlResponse.h"
#import "AboutUsRequest.h"
#import "AboutUsResponse.h"
#import "UserFeeInfoRequest.h"
#import "UserFeeInfoResponse.h"
#import "UserInfo.h"
#import "LoginOrRegistRequest.h"
#import "LoginOrRegistResponse.h"
#import "SuggestRequest.h"
#import "SuggestResponse.h"
#import "VideoBean.h"
#import "JSON.h"
#import "MagazineBean.h"
#import "MagzineDetailListRequest.h"
#import "MagazineDetailListResponse.h"
#import "MagazineResourceBean.h"
#import "AppDelegate.h"

@implementation TestJsonViewController {
    NSMutableData *receiveData;
    SuperResponse *g_response;
    SuperRequest *g_request;
//    NSURL *testUrl ;
}
+(NSString *)getUserFeeInfoTestRespStr{ //getUserFeeInfo的应答string
    NSString *result = nil;

    result =@""
            "{"

            " \"userInfo\":{\n"
            " \t\"UUID\":\"1011\",\n"
            "\t\"username\":\"admin\",\n"
            "\t\"phone\":\"18911111111\",\n"
            "\t\"email\":\"122@qq.com\",\n"
            "\t\"passwd\":\"123\",\n"
            "\t\"addtime\":\"2013-01-23\",\n"
            "\t\"regtype\":\"1\"\n"
            "\n"
            "\t\"operatorid\":\"10111111\",\n"
            "    \"paytype\":\"1\",\n"
//            "    \"ispay\":\"1\",\n"
            "    \"ispay\":\"0\",\n"
            "    \"paytime\":\"2013-01-23\"\n"
            " }\n"
            "}";

    return result;
}
+(NSString *)getLoginTestRespStr{ //login的应答string
    NSString *result = nil;

    result =@""
            "{\n"
            "\"result\":\"登陆成功\"\n"
            "\"loginStatus\":\"1\",\n"
            "\"userID\":\"1011\",\n"
            "\"userName\":\"admin\"\n"
            "}";

    return result;
}
//首页第一个tab的应答string
+(NSString *)getFP1TestRespStr{
    NSString *result = nil;

    result = @""
            "{\n"
            "   \"timestamp\" : \"1364982403\",\n"
            "   \"returnCode\" : \"10001\",\n"
            "   \"returnMsg\" : \"请求成功！\",\n"
            "   \"videos\" :\n"
            "      [\n"
            "         {\n"
            "            \"team2Id\" : \"101\",\n"
            "            \"vDesc\" : \"testasdfasdfasdfasdfasdf=======================!!\",\n"
            "            \"vPic\" : \"http://bj-t.ml.streamocean.net:8088/console/upload/201303/14_809806.jpg\",\n"
            "            \"vStatus\" : \"finished\",\n"
            "            \"vUrl\" : \"http://bj-t.ml.streamocean.net:8088/portal/noc/real/chinaunicome?vid=18981&shifttime=1364818843&shiftend=1364826043\",\n"
            "            \"videoId\" : \"3bd6b21c-8527-4cd8-a62c-3ed5e37e8366\",\n"
            "            \"vStart\" : \"2013-04-01 20:20:43\",\n"
            "            \"team1Id\" : \"95\",\n"
            "            \"vPic2\" : \"http://bj-t.ml.streamocean.net:8088/console/upload/201303/14_443812.jpg\",\n"
            "            \"vName\" : \"埃弗顿 VS 曼城\",\n"
            "            \"vEnd\" : \"2013-04-01 22:20:43\"\n"
            "         },\n"
            "         {\n"
            "            \"team2Id\" : \"100\",\n"
            "            \"vDesc\" : \"测试1jkhkjhkjh\",\n"
            "            \"vPic\" : \"http://bj-t.ml.streamocean.net:8088/console/upload/201303/14_786464.jpg\",\n"
            "            \"vStatus\" : \"finished\",\n"
            "            \"vUrl\" : \"http://bj-t.ml.streamocean.net:8088/portal/noc/real/chinaunicome?vid=18981&shifttime=1364404241&shiftend=1364413241\",\n"
            "            \"videoId\" : \"be585b6b-4c66-4e71-9c3d-94f0cbf4591a\",\n"
            "            \"vStart\" : \"2013-03-28 01:10:41\",\n"
            "            \"team1Id\" : \"91\",\n"
            "            \"vPic2\" : \"http://bj-t.ml.streamocean.net:8088/console/upload/201303/14_377362.jpg\",\n"
            "            \"vName\" : \"曼联 VS 雷丁\",\n"
            "            \"vEnd\" : \"2013-03-28 03:40:41\"\n"
            "         }\n"
            "      ]\n"
            "}";

    return result;
}

#pragma mark - 将返回的数据打印出来
-(void)printResponse:(NSString *)receiveStr{
    NSLog(@"debug_Response:%@", receiveStr);
    if ([g_request isKindOfClass:[LoginRequest class]]){
        LoginResponse *respn = [(LoginResponse *) [[LoginResponse alloc] initWithJsonString:receiveStr] autorelease];
        NSLog(@"LoginResponse:%@", [respn.defaultSearchWords description]);
        NSLog(@"LoginResponse:%@", [respn.defaultSearchWords description]);
    }
    if ([g_request isKindOfClass:[VideoListRequest class]]){
        VideoListResponse *respn = [(VideoListResponse *) [[VideoListResponse alloc] initWithJsonString:receiveStr] autorelease];
        NSLog(@"VideoListResponse.timestamp:%@", [respn.timestamp description]);
        NSLog(@"VideoListResponse.videos:%@,count=%d",
                [respn.videos description],[respn.videos count]);
        NSArray *arr = respn.videos;
        for (NSDictionary *beanDict in arr){
            NSLog(@"beanDict description=%@", [beanDict JSONRepresentation]);
            VideoBean *bean = [[[VideoBean alloc] initWithJsonStr:[beanDict JSONRepresentation]] autorelease];
            NSLog(@"desc=%@",bean.vDesc);
        }
    }
    if ([g_request isKindOfClass:[LiveDayRequest class]]){
        LiveDayResponse *respn = [(LiveDayResponse *) [[LiveDayResponse alloc] initWithJsonString:receiveStr] autorelease];
        NSLog(@"LiveDayResponse:%@", [respn.dateList description]);
    }
    if ([g_request isKindOfClass:[MagzineListRequest class]]){
        MagazineListResponse *respn = [(MagazineListResponse *) [[MagazineListResponse alloc] initWithJsonString:receiveStr] autorelease];
        NSLog(@"MagazineListResponse.totalNumber:%@", respn.totalNumber);
        NSLog(@"MagazineListResponse.from:%@", respn.from);
        NSLog(@"MagazineListResponse.to:%@", respn.to);

        NSLog(@"MagazineListResponse.MagazineBeans:%@", [respn.MagazineBeans description]);

        NSArray *arr = respn.MagazineBeans;
        for (NSDictionary *beanDict in arr){
            NSLog(@"beanDict description=%@", [beanDict JSONRepresentation]);
            MagazineBean *bean = [[[MagazineBean alloc] initWithJsonStr:[beanDict JSONRepresentation]] autorelease];
            NSLog(@"desc=%@",bean.vc2CoverUrl);
        }

    }
    if ([g_request isKindOfClass:[MagzineDetailListRequest class]]){
        MagazineDetailListResponse *respn = [(MagazineDetailListResponse *) [[MagazineDetailListResponse alloc] initWithJsonString:receiveStr] autorelease];
        if(nil != respn && respn.MagazineBeans != nil && [respn.MagazineBeans count] > 0){
            for(NSDictionary *beanDict  in respn.MagazineBeans){
                MagazineResourceBean *bean = [[[MagazineResourceBean alloc] initWithJsonStr:[beanDict JSONRepresentation]] autorelease];
                if (bean != nil){
                    NSLog(@"numBookId=%@",bean.numBookId);
                    NSLog(@"vc2PicUrl=%@",bean.vc2PicUrl);
                }
            }
        }
        NSLog(@"respn");
    }

    if ([g_request isKindOfClass:[VideoUrlRequest class]]){
        VideoUrlResponse *respn = [(VideoUrlResponse *) [[VideoUrlResponse alloc] initWithJsonString:receiveStr] autorelease];
        NSLog(@"VideoUrlResponse.videoUrl:%@", respn.videoUrl);
    }
    if ([g_request isKindOfClass:[AboutUsRequest class]]){
        AboutUsResponse *respn = [(AboutUsResponse *) [[AboutUsResponse alloc] initWithJsonString:receiveStr] autorelease];
        NSLog(@"AboutUsResponse.aboutUrl:%@", respn.aboutUrl);
    }
    if ([g_request isKindOfClass:[UserFeeInfoRequest class]]){
        UserFeeInfoResponse *respn = [(UserFeeInfoResponse *) [[UserFeeInfoResponse alloc] initWithJsonString:receiveStr] autorelease];
        NSLog(@"UserFeeInfoResponse.userInfo:%@", [respn.userInfo description]);
    }
    if ([g_request isKindOfClass:[LoginOrRegistRequest class]]){
        LoginOrRegistResponse *respn = [(LoginOrRegistResponse *) [[LoginOrRegistResponse alloc] initWithJsonString:receiveStr] autorelease];
        NSLog(@"LoginOrRegistResponse.result:%@", [respn.result description]);
        NSLog(@"LoginOrRegistResponse.loginStatus:%@", [respn.loginStatus description]);
        NSLog(@"LoginOrRegistResponse.userID:%@", [respn.userID description]);
        NSLog(@"LoginOrRegistResponse.userName:%@", [respn.userName description]);
    }
    if ([g_request isKindOfClass:[SuggestRequest class]]){
        SuggestResponse *respn = [(SuggestResponse *) [[SuggestResponse alloc] initWithJsonString:receiveStr] autorelease];
        NSLog(@"SuggestResponse.result:%@", [respn.result description]);
        NSLog(@"SuggestResponse.loginStatus:%@", [respn.loginStatus description]);
        NSLog(@"SuggestResponse.userID:%@", [respn.userID description]);
        NSLog(@"SuggestResponse.userName:%@", [respn.userName description]);
    }
}

#pragma mark - 进行具体功能点的测试
- (void)loadView {
    [super loadView];

//    testUrl = [NSURL URLWithString:@"http://161.2.1.205:8088/ssports_app/base"];

//    [self testMyLogin];//0
    [self testVideoList];//1  ok
//    [self testLiveDay];//2  此接口不用调试
//    [self testMagazineList];//3  ok
//    [self testMagazineDetailList];//3.5
//    [self testVideoUrl];//4   这个接口的method参数没有给出来   此接口不用调试
//    [self testAboutUs];//5      这个接口的method参数没有给出来 todo 需要加上关于我们的method
//    [self testUserFeeInfo];//6   这个接口报错，空指针  todo 即使没有这个用户，也需要做格式化
//    [self testUserLogin];//7       这个接口返回null，看看服务器做做容错
//    [self testUserRegist];//8        这个接口返回null，看看服务器做做容错
//    [self testChangePassword];//9   // 这个接口返回null，看看服务器做做容错
//    [self testSuggest];//10           // 报错,空指针  todo
}


//接口0: 测试自己的login
-(void)testMyLogin{
//    NSURL *testUrl = [NSURL URLWithString:@"http://161.2.1.235:8898/phoneweb/ssgmobile"];
    g_request = [[LoginRequest alloc] init];
    BaseRequest *baseRequest = [[[BaseRequest alloc] init] autorelease];
    baseRequest.action = @"Login";
    baseRequest.ngLabel = @"测试习惯中文。。。";
    ((LoginRequest *)g_request).baseRequest = baseRequest;
    [self startHttpJsonPost:g_request];
}
//接口1: 测试获取视频列表
-(void)testVideoList{
    VideoListRequest *req = [[VideoListRequest alloc] init];
    req.methodName = @"RequestListVideo";
    req.type = @"live"; //直播视频
    g_request = req;
    [self startHttpJsonPost:req];
}
//接口2: 测试获取日期列表
-(void)testLiveDay{
    LiveDayRequest *req = [[LiveDayRequest alloc] init] ;
    req.offset = 0;
    req.count = 10;
    g_request = req;
    [self startHttpJsonPost:req];
}
//接口3: 测试获取杂志列表
-(void)testMagazineList{
    MagzineListRequest *req = [[MagzineListRequest alloc] init] ;
    req.methodName = @"RequestGetTbMobilBookPage";
    req.startNUM = @"1";
    req.endNUM = @"10";
    g_request = req;
    [self startHttpJsonPost:req];
}
//接口3.5: 测试根据杂志ID获取杂志页面列表
-(void)testMagazineDetailList{
    MagzineDetailListRequest *req = [[MagzineDetailListRequest alloc] init] ;
    req.methodName = @"RequestListTbMobilBookResource"; //  杂志资源列表
    req.magzineID = @"11526";
    g_request = req;
    [self startHttpJsonPost:req];
}
//接口4: 测试获取视频url
-(void)testVideoUrl{
    VideoUrlRequest *req = [[VideoUrlRequest alloc] init];
    req.videoID = @"44555";
    g_request = req;
    [self startHttpJsonPost:req];
}
//接口5: 测试关于我们
-(void)testAboutUs{
    AboutUsRequest *req = [[AboutUsRequest alloc] init];
    g_request = req;
    [self startHttpJsonPost:req];
}
//接口6: 测试用户付费信息查询
-(void)testUserFeeInfo{
    UserFeeInfoRequest *req = [[UserFeeInfoRequest alloc] init];
    req.methodName = @"RequestUserCenter";
    req.userID = @"4544";
    g_request = req;
    [self startHttpJsonPost:req];
}
//接口7: 测试用户登陆
-(void)testUserLogin{
    LoginOrRegistRequest *req = [[LoginOrRegistRequest alloc] init];
    req.methodName = @"RequestLogin";
    req.userName = @"admin";
    req.password = @"admin";
    g_request = req;
    [self startHttpJsonPost:req];
}
//接口8: 测试用户注册
-(void)testUserRegist{
    LoginOrRegistRequest *req = [[LoginOrRegistRequest alloc] init];
    req.methodName = @"RequestRegister";
    req.userName = @"18614049921";
    req.password = @"******";
    g_request = req;
    [self startHttpJsonPost:req];
}
//接口9: 测试用户修改密码
-(void)testChangePassword{
    LoginOrRegistRequest *req = [[LoginOrRegistRequest alloc] init];
    req.methodName = @"RequestChangePassword";
    req.userName = @"4544";
    req.password = @"******";
    g_request = req;
    [self startHttpJsonPost:req];
}
//接口10: 测试提交建议
-(void)testSuggest{
    SuggestRequest *req = [[SuggestRequest alloc] init];
    req.methodName = @"RequestSaveSuggest";
    req.userID = @"555";
    req.suggestContent = @"希望把页面的颜色调成统一风格";
    g_request = req;
    [self startHttpJsonPost:req];
}

#pragma mark - 进行http测试  以下都不需要关心
- (void)startHttpJsonPost:(SuperRequest *)req {
    NSString *jsonStr = req.getJsonStr;
    //第二步，创建请求
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *str_srvUrl = app.str_serviceUrl;
    NSURL *svcUrl = [NSURL URLWithString:str_srvUrl];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:svcUrl
                                                                 cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:10] autorelease];
    [request setHTTPMethod:@"POST"];
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    receiveData = [[NSMutableData alloc] init];
    [[[NSURLConnection alloc]initWithRequest:request delegate:self] autorelease];
}

- (SuperResponse *)paseHttpResponseStr:(NSString *)receiveStr {
    return [[[SuperResponse alloc] initWithJsonString:receiveStr] autorelease];
}

//接收到服务器回应的时候调用此方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [receiveData setLength: 0];
}

//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receiveData appendData:data];
}

//数据传完之后调用此方法
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *receiveStr = [[[NSString alloc] initWithData:receiveData encoding:NSUTF8StringEncoding] autorelease];
    [self printResponse:receiveStr];
}

//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError:%@", [error localizedDescription]);
}

- (void)dealloc {
    [receiveData release];
    [g_response release];
    [g_request release];
    [super dealloc];
}


@end