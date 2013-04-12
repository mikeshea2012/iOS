#import <QuartzCore/QuartzCore.h>
#import "MagazineViewController.h"
#import "MagazinePageViewController.h"
#import "SuperRequest.h"
#import "SuperResponse.h"
#import "MagzineListRequest.h"
#import "JSON.h"
#import "MagazineBean.h"
#import "MagazineListResponse.h"
#import "FileUtil.h"
#import "MagazineDao.h"
#import "AppDelegate.h"
@implementation MagazineViewController {
    NSMutableData *receiveData;
    SuperRequest *g_request;
//    NSURL *testUrl;
//    NSMutableArray *g_magzine_records;//全局变量
}
//extern NSMutableArray *g_magzine_records;//全局变量
@synthesize g_secondFromIndex, g_recordHeight, g_totalNumber;


- (ObjView *)getMiddleObj {
    NSLog(@"getMiddleObj");
    ObjView *minObj = view_1;
    float minFloat = abs((int) (view_1.center.y - middlePointY));
    ObjView *obj = nil;
    for (int i = 1; i <= 5; i++) {
        if (i == 1) {
            obj = view_1;
        }
        if (i == 2) {
            obj = view_2;
        }
        if (i == 3) {
            obj = view_3;
        }
        if (i == 4) {
            obj = view_4;
        }
        if (i == 5) {
            obj = view_5;
        }
        if (abs((int) (obj.center.y - middlePointY)) < minFloat) {
            minObj = obj;
            minFloat = abs((int) (obj.center.y - middlePointY));
        }
    }
    if (minObj.boxview_index == 1) {
        return view_1;
    }
    if (minObj.boxview_index == 2) {
        return view_2;
    }
    if (minObj.boxview_index == 3) {
        return view_3;
    }
    if (minObj.boxview_index == 4) {
        return view_4;
    }
    if (minObj.boxview_index == 5) {
        return view_5;
    }
    return view_1;
}

//初始化
- (void)initAllViews {
    NSLog(@"initAllViews");
    for (int tempIndex = 1; tempIndex <= 5; tempIndex++) {
        [self.view addSubview:[self initObjViewByIndex:tempIndex]];
    }
    ObjView *middleObjView = [self getMiddleObj];
    last_middleIndex = middleObjView.boxview_index;
    [self allMovedDeltaY:0];
    //重新组织
    [self reArrangeAll:middleObjView.boxview_index];

}

- (ObjView *)initObjViewByIndex:(int)tempIndex {
    NSLog(@"initObjViewByIndex");
    int x = 0, y = 0, w = 0, h = 0;
    ObjView *vi;
    NSString *imgName;
    imgName = @"magazine_default.jpg";
    x = 0, y = g_secondFromIndex * (tempIndex - 1), w = 320, h = g_recordHeight;
    vi = [[[ObjView alloc] init] autorelease];
    vi.boxview_index = tempIndex;
    vi.frame = CGRectMake(x, y, w, h);

    UIImage *img = [FileUtil loadImgDateFromFile:[[[NSString alloc] initWithFormat:@"cover_100%d",tempIndex] autorelease]];
    if (nil != img){
        [vi.userImageView setImage:img];
    }else{
        [vi.userImageView setImage:[UIImage imageNamed:imgName]];
    }
    [vi titleLabel].text = @"";
    NSString *content = @"";//[[[NSString alloc] initWithFormat:@"%d想知道一场英超比赛总共需要多少运营人员参与吗？想知道一个球队中到底有多少工作人员吗？本期《上英超》为您详细揭秘...", tempIndex] autorelease];
    [vi.descTextView setText:content];
    SEL action = nil;
    if (tempIndex == 1) {
        view_1 = vi;
        action = @selector(clickMagazine_1:);
    }
    if (tempIndex == 2) {
        view_2 = vi;
        action = @selector(clickMagazine_2:);
    }
    if (tempIndex == 3) {
        view_3 = vi;
        action = @selector(clickMagazine_3:);
    }
    if (tempIndex == 4) {
        view_4 = vi;
        action = @selector(clickMagazine_4:);
    }
    if (tempIndex == 5) {
        view_5 = vi;
        action = @selector(clickMagazine_5:);
    }
    //加上点击手势响应事件
    vi.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:action] autorelease];
    [vi addGestureRecognizer:singleTap];
    return vi;
}
//将某个view移动到某个从上到下的顺序,seq=1置顶,seq=2放在第二位,seq=3居中，seq=4居于第四位,seq=5第五位
- (void)moveSomeView:(ObjView *)obj ToSeq:(int)seq {
    NSLog(@"moveSomeView");

    int objIndex = obj.boxview_index;
    NSString *imgName = @"magazine_default.jpg";
    NSString *title = @"";
    NSString *content = @"";
    MagazineDao *dao = [[[MagazineDao alloc] init] autorelease];
    MagazineBean *bean = [dao queryDataFromDBById:[[[NSString alloc] initWithFormat:@"100%d", objIndex] autorelease]];
    if (nil != bean){
        title = bean.vc2BookName;
        content = bean.vc2Desc;
    }
    CGPoint centerPoint = obj.center;
    centerPoint.y = middlePointY - (3 - seq) * g_secondFromIndex;
    if (abs((int) (obj.center.y - centerPoint.y)) > 2 * g_secondFromIndex) { //发生了从顶到底或者从底到顶的转换
        if (seq == 1 || seq == 5) {
            float speed = 0.1, f_alpha, f_rate;
            [UIView beginAnimations:@"" context:nil];
            [UIView setAnimationDuration:speed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            [UIView setAnimationBeginsFromCurrentState:YES];

            [obj removeFromSuperview];
            CGFloat x = (CGFloat) 0;
            CGFloat y = (seq - 1) * g_secondFromIndex;
            CGFloat w = (CGFloat) 320;
            CGFloat h = (CGFloat) g_recordHeight;
            ObjView *vi;
            vi = [[[ObjView alloc] init] autorelease];
            vi.boxview_index = objIndex;
            vi.frame = CGRectMake(x, y, w, h);
            UIImage *img = [FileUtil loadImgDateFromFile:[[[NSString alloc] initWithFormat:@"cover_100%d",objIndex] autorelease]];
            if (nil != img){
                [vi.userImageView setImage:img];
            }else{
                [vi.userImageView setImage:[UIImage imageNamed:imgName]];
            }
            [vi titleLabel].text = title;
//            NSString *content = [[[NSString alloc] initWithFormat:@"%d renew 想知道一场"
//                                                                          "英超比赛总共需要多少运营人员参与吗？想知道一个球队中到底有多少工作人员吗？"
//                                                                          "本期《上英超》为您详细揭秘...", objIndex] autorelease];
            SEL action = nil;
            [vi.descTextView setText:content];

            if (objIndex == 1) {
                view_1 = vi;
                action = @selector(clickMagazine_1:);
            }
            if (objIndex == 2) {
                view_2 = vi;
                action = @selector(clickMagazine_2:);
            }
            if (objIndex == 3) {
                view_3 = vi;
                action = @selector(clickMagazine_3:);
            }
            if (objIndex == 4) {
                view_4 = vi;
                action = @selector(clickMagazine_4:);
            }
            if (objIndex == 5) {
                view_5 = vi;
                action = @selector(clickMagazine_5:);
            }
            //加上点击手势响应事件
            vi.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                         action:action] autorelease];
            [vi addGestureRecognizer:singleTap];

            [self.view addSubview:vi];
            //view_n 动画
            f_alpha = 1 - abs((int) (vi.center.y - middlePointY)) * 0.15 / g_secondFromIndex; //透明度计算公式
            f_rate = 1 - abs((int) (vi.center.y - middlePointY)) * 0.20 / g_secondFromIndex; //缩放比计算公式
            vi.alpha = f_alpha;
            vi.layer.transform = CATransform3DMakeScale(f_rate, f_rate, 1);
            [UIView commitAnimations];
        }
    } else {
        obj.center = centerPoint;
    }
}

//以中间记录为参考，重新排序
- (void)reArrangeAll:(int)middleViewIndex {
    NSLog(@"reArrangeAll");
    if (middleViewIndex == 3) {
        [self moveSomeView:view_1 ToSeq:1];
        [self moveSomeView:view_2 ToSeq:2];
        [self moveSomeView:view_3 ToSeq:3];
        [self moveSomeView:view_4 ToSeq:4];
        [self moveSomeView:view_5 ToSeq:5];

        [self.view sendSubviewToBack:view_2];
        [self.view sendSubviewToBack:view_1];
        [self.view sendSubviewToBack:view_4];
        [self.view sendSubviewToBack:view_5];
        [self.view bringSubviewToFront:view_3];
    }
    if (middleViewIndex == 2) {
        [self moveSomeView:view_5 ToSeq:1];
        [self moveSomeView:view_1 ToSeq:2];
        [self moveSomeView:view_2 ToSeq:3];
        [self moveSomeView:view_3 ToSeq:4];
        [self moveSomeView:view_4 ToSeq:5];

        [self.view sendSubviewToBack:view_1];
        [self.view sendSubviewToBack:view_5];
        [self.view sendSubviewToBack:view_3];
        [self.view sendSubviewToBack:view_4];
        [self.view bringSubviewToFront:view_2];
    }
    if (middleViewIndex == 1) {
        [self moveSomeView:view_4 ToSeq:1];
        [self moveSomeView:view_5 ToSeq:2];
        [self moveSomeView:view_1 ToSeq:3];
        [self moveSomeView:view_2 ToSeq:4];
        [self moveSomeView:view_3 ToSeq:5];

        [self.view sendSubviewToBack:view_5];
        [self.view sendSubviewToBack:view_4];
        [self.view sendSubviewToBack:view_2];
        [self.view sendSubviewToBack:view_3];
        [self.view bringSubviewToFront:view_1];
    }
    if (middleViewIndex == 5) {
        [self moveSomeView:view_3 ToSeq:1];
        [self moveSomeView:view_4 ToSeq:2];
        [self moveSomeView:view_5 ToSeq:3];
        [self moveSomeView:view_1 ToSeq:4];
        [self moveSomeView:view_2 ToSeq:5];

        [self.view sendSubviewToBack:view_4];
        [self.view sendSubviewToBack:view_3];
        [self.view sendSubviewToBack:view_1];
        [self.view sendSubviewToBack:view_2];
        [self.view bringSubviewToFront:view_5];
    }
    if (middleViewIndex == 4) {
        [self moveSomeView:view_2 ToSeq:1];
        [self moveSomeView:view_3 ToSeq:2];
        [self moveSomeView:view_4 ToSeq:3];
        [self moveSomeView:view_5 ToSeq:4];
        [self moveSomeView:view_1 ToSeq:5];

        [self.view sendSubviewToBack:view_3];
        [self.view sendSubviewToBack:view_2];
        [self.view sendSubviewToBack:view_5];
        [self.view sendSubviewToBack:view_1];
        [self.view bringSubviewToFront:view_4];
    }
}

//所有记录同时进行移动，当中心记录有切换的时候，进行重新排序
- (void)allMovedDeltaY:(CGFloat)deltaY {
    NSLog(@"allMovedDeltaY");
    if (deltaY > 0.75 * g_secondFromIndex) {
        deltaY = 0.75 * g_secondFromIndex;
    }
    float speed = 0.1, f_alpha, f_rate;
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:speed];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationBeginsFromCurrentState:YES];

    [self moveSomeView:view_1 andDeltaY:deltaY];
    [self moveSomeView:view_2 andDeltaY:deltaY];
    [self moveSomeView:view_3 andDeltaY:deltaY];
    [self moveSomeView:view_4 andDeltaY:deltaY];
    [self moveSomeView:view_5 andDeltaY:deltaY];


    //view_1动画
    f_alpha = 1 - abs((int) (view_1.center.y - middlePointY)) * 0.15 / g_secondFromIndex; //透明度计算公式
    f_rate = 1 - abs((int) (view_1.center.y - middlePointY)) * 0.20 / g_secondFromIndex; //缩放比计算公式
    view_1.alpha = f_alpha;
    view_1.layer.transform = CATransform3DMakeScale(f_rate, f_rate, 1);
    //view_5动画
    f_alpha = 1 - abs((int) (view_5.center.y - middlePointY)) * 0.15 / g_secondFromIndex; //透明度计算公式
    f_rate = 1 - abs((int) (view_5.center.y - middlePointY)) * 0.20 / g_secondFromIndex; //缩放比计算公式
    view_5.alpha = f_alpha;
    view_5.layer.transform = CATransform3DMakeScale(f_rate, f_rate, 1);
    //view_2动画
    f_alpha = 1 - abs((int) (view_2.center.y - middlePointY)) * 0.15 / g_secondFromIndex; //透明度计算公式
    f_rate = 1 - abs((int) (view_2.center.y - middlePointY)) * 0.20 / g_secondFromIndex; //缩放比计算公式
    view_2.alpha = f_alpha;
    view_2.layer.transform = CATransform3DMakeScale(f_rate, f_rate, 1);
    //view_4动画
    f_alpha = 1 - abs((int) (view_4.center.y - middlePointY)) * 0.15 / g_secondFromIndex; //透明度计算公式
    f_rate = 1 - abs((int) (view_4.center.y - middlePointY)) * 0.20 / g_secondFromIndex; //缩放比计算公式
    view_4.alpha = f_alpha;
    view_4.layer.transform = CATransform3DMakeScale(f_rate, f_rate, 1);
    //view_3动画
    f_alpha = 1 - abs((int) (view_3.center.y - middlePointY)) * 0.15 / g_secondFromIndex; //透明度计算公式
    f_rate = 1 - abs((int) (view_3.center.y - middlePointY)) * 0.20 / g_secondFromIndex; //缩放比计算公式
    view_3.alpha = f_alpha;
    view_3.layer.transform = CATransform3DMakeScale(f_rate, f_rate, 1);

    [UIView commitAnimations];


    ObjView *middleObjView = [self getMiddleObj];
    //算出 middlePointY和 当前中间记录项的y值
    CGFloat deltaToMoved = middlePointY - middleObjView.center.y;
    if (last_middleIndex != middleObjView.boxview_index) {
        [self moveSomeView:view_1 andDeltaY:deltaToMoved];
        [self moveSomeView:view_2 andDeltaY:deltaToMoved];
        [self moveSomeView:view_3 andDeltaY:deltaToMoved];
        [self moveSomeView:view_4 andDeltaY:deltaToMoved];
        [self moveSomeView:view_5 andDeltaY:deltaToMoved];

        //重新组织
        [self reArrangeAll:middleObjView.boxview_index];
        last_middleIndex = middleObjView.boxview_index;
    }


}

#pragma mark 以下都不需要关注
///////////////////////////////////
//将某个uiview进行位移
- (void)moveSomeView:(ObjView *)objView andDeltaY:(CGFloat)deltaY {
    NSLog(@"moveSomeView");
    CGPoint centerPoint = objView.center;
    centerPoint.y += deltaY;
    objView.center = centerPoint;
}




- (id)init {
    NSLog(@"init");
    [super init];
    g_secondFromIndex = 80;
    g_recordHeight = 142;
    g_totalNumber = 6;
    middlePointY = 231;//中间记录的center point 的y值
    g_bottomY = 415;
    return self;
}

//处理上下滑动效果
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"handleSwipeFrom");
    if (recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        [self allMovedDeltaY:-1 * g_secondFromIndex];
    } else if (recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
        [self allMovedDeltaY:1 * g_secondFromIndex];
    } else {
        return;
    }
}

//点击左导航条触发的动作
- (void)responseLeft:(id)button {
    NSLog(@"responseLeft");
    [self.navigationController popViewControllerAnimated:YES];
}

//统一设置头部导航条 以及 “赛事中心”及"英超榜"tab
- (void)SET_HEADER_NAVIGATION {
    NSLog(@"SET_HEADER_NAVIGATION");
    [self.navigationController.navigationBar
            setBackgroundImage:[UIImage imageNamed:@"navi_bg_height_1.png"]
                 forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setContentMode:UIViewContentModeScaleToFill];
    self.navigationItem.title = @"英超精华";
    //part1:导航栏-->  1.1 左边的导航条
    UIButton *left_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    left_btn.frame = CGRectMake(0, 0, 61, 30);
    [left_btn setTitle:@"返回" forState:UIControlStateNormal];
    left_btn.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [left_btn setBackgroundImage:[UIImage imageNamed:@"back_61_30"] forState:UIControlStateNormal];
    [left_btn addTarget:self action:@selector(responseLeft:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left_barBtn = [[[UIBarButtonItem alloc] initWithCustomView:left_btn] autorelease];
    self.navigationItem.leftBarButtonItem = left_barBtn;
}

//设置页面
- (void)loadView {
    NSLog(@"loadView");
    [super loadView];
    [self SET_HEADER_NAVIGATION];//统一设置头部导航条

    g_items = [[NSMutableArray alloc] init];
    [self initAllViews];
    //step4:为表格部分添加手势
    self.view.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)] autorelease];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [self.view addGestureRecognizer:recognizer];
    recognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)] autorelease];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.view addGestureRecognizer:recognizer];
    recognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)] autorelease];
    [self.view addGestureRecognizer:recognizer];

    //从本地数据库查询数据，如果有数据就进行更新
    [self updateRecordFromLocalDB];

    //进行联网操作
    NSLog(@"开始联网操作...");
    [self startHttpRequest];
}

//从本地数据库查询数据，如果有数据就进行更新
-(void)updateRecordFromLocalDB{
    MagazineDao *dao = [[[MagazineDao alloc] init] autorelease];
    NSMutableArray *arr = dao.queryDataFromDB;
    if (nil == arr || [arr count] == 0){
        NSLog(@"db is null or records number = 0");
        return;
    }else{
        NSLog(@"records number = %d", [arr count]);
    }
    int i = 0;
    for (MagazineBean *bean in arr){
        i++;
        ObjView *objView = [self getObjViewByIndex:i];
        objView.titleLabel.text = bean.vc2BookName;
        objView.descTextView.text = bean.vc2Desc;
        UIImage *img = [FileUtil loadImgDateFromFile:[[[NSString alloc] initWithFormat:@"cover_100%d",i] autorelease]];
        if (nil != img){
            objView.userImageView.image = img;
        }

    }
}

- (void)startHttpRequest {
    NSLog(@"startHttpRequest");
    MagzineListRequest *req = [[MagzineListRequest alloc] init];
    req.methodName = @"RequestGetTbMobilBookPage";
    req.startNUM = @"1";
    req.endNUM = @"10";
    g_request = req;
    [self startHttpJsonPost:req];
}

#pragma mark - 进行http测试  以下都不需要关心



#pragma mark - 将返回的数据打印出来
- (void)printResponse:(NSString *)receiveStr {
    NSLog(@"printResponse");
    if ([g_request isKindOfClass:[MagzineListRequest class]]) {
        MagazineListResponse *respn = [(MagazineListResponse *) [[MagazineListResponse alloc] initWithJsonString:receiveStr] autorelease];
        NSLog(@"MagazineListResponse.totalNumber:%@", respn.totalNumber);
        NSLog(@"MagazineListResponse.from:%@", respn.from);
        NSLog(@"MagazineListResponse.to:%@", respn.to);

        NSArray *arr = respn.MagazineBeans;
        MagazineDao *dao = [[[MagazineDao alloc] init] autorelease];
        if ([arr count] > 0){ //将数据库原有数据清除
            [dao eraseDBByTableName];
        }
        NSMutableArray *arr0 = dao.queryDataFromDB;
        NSLog(@"debug,arr0.count=%d",[arr0 count]);
        NSLog(@"debug,arr.count=%d",[arr count]);
        int i = 0;
//        [self showActivity];
        for (NSDictionary *beanDict in arr) {
            i++;
            [beanDict JSONRepresentation];
            MagazineBean *bean = [[[MagazineBean alloc] init] autorelease];
            bean.vc2BookName = [beanDict objectForKey:@"vc2BookName"];
            bean.numServerBookId = [beanDict objectForKey:@"numBookId"];
            bean.vc2Desc = [beanDict objectForKey:@"vc2Desc"];
            bean.vc2CoverUrl = [beanDict objectForKey:@"vc2CoverUrl"];
            bean.numBookId = [[NSString alloc] initWithFormat:@"100%d",i];
            if(![@"Y" isEqualToString: [beanDict objectForKey:@"vc2Enableflag"]]){
                continue;
            }
            [dao updateOrInsertTable:bean];
            NSString *picName = [[[NSString alloc] initWithFormat:@"cover_100%d", i] autorelease];
            NSData *imgData = [self getImageDataFromURL: bean.vc2CoverUrl];
            if (imgData != nil){
                [FileUtil writeImageData:imgData ToFileWithName:picName];
            }
        }
//        [self stopActivity];
        NSMutableArray *arr2 = dao.queryDataFromDB;
        NSLog(@"debug,arr2.count=%d",[arr2 count]);
    }

    //从本地数据库查询数据，如果有数据就进行更新
    [self updateRecordFromLocalDB];
}

//显示联网状态
-(void)showActivity{
    UIActivityIndicatorView *indicatorView = [[[UIActivityIndicatorView alloc]
            initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    indicatorView.frame = CGRectMake(0, 0, 300, 300);
    indicatorView.color = [UIColor blueColor];
    indicatorView.center = self.view.center;
    [self.view addSubview:indicatorView];
    [self.view bringSubviewToFront:indicatorView];
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


- (ObjView *)getObjViewByIndex:(int)index {
    NSLog(@"getObjViewByIndex");
    if (index == 1) {
        return view_1;
    }
    if (index == 2) {
        return view_2;
    }
    if (index == 3) {
        return view_3;
    }
    if (index == 4) {
        return view_4;
    }
    if (index == 5) {
        return view_5;
    }
    return view_1;
}


- (NSData *)getImageDataFromURL:(NSString *)fileUrl {
    NSLog(@"getImageFromURL");
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileUrl]];
    return data;
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
                                                             timeoutInterval:10] autorelease];
    [request setHTTPMethod:@"POST"];
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    receiveData = [[NSMutableData alloc] init];
    [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
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
    NSString *receiveStr = [[[NSString alloc] initWithData:receiveData encoding:NSUTF8StringEncoding] autorelease];
    [self printResponse:receiveStr];
}

//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError:%@", [error localizedDescription]);
}




- (void)clickMagazine_1:(id)respd {
    NSLog(@"clickMagazine_1...");
    MagazineDao *dao = [[[MagazineDao alloc] init] autorelease];
    MagazineBean *bean = [dao queryDataFromDBById:@"1001"];
    if (nil == bean){
        return;
    }
    MagazinePageViewController *magazinePageViewController = [[[MagazinePageViewController alloc] init] autorelease];
    magazinePageViewController.magazine_issueNo = 21;
    magazinePageViewController.magazineName = bean.vc2BookName;
    magazinePageViewController.serverBookId = bean.numServerBookId;
    [self.navigationController pushViewController:magazinePageViewController animated:YES];
}

- (void)clickMagazine_2:(id)respd {
    NSLog(@"clickMagazine_2...");
    MagazineDao *dao = [[[MagazineDao alloc] init] autorelease];
    MagazineBean *bean = [dao queryDataFromDBById:@"1002"];
    if (nil == bean){
        return;
    }
    MagazinePageViewController *magazinePageViewController = [[[MagazinePageViewController alloc] init] autorelease];
    magazinePageViewController.magazine_issueNo = 22;
    magazinePageViewController.magazineName = bean.vc2BookName;
    magazinePageViewController.serverBookId = bean.numServerBookId;
    [self.navigationController pushViewController:magazinePageViewController animated:YES];
}

- (void)clickMagazine_3:(id)respd {
    NSLog(@"clickMagazine_3...");
    MagazineDao *dao = [[[MagazineDao alloc] init] autorelease];
    MagazineBean *bean = [dao queryDataFromDBById:@"1003"];
    if (nil == bean){
        return;
    }
    MagazinePageViewController *magazinePageViewController = [[[MagazinePageViewController alloc] init] autorelease];
    magazinePageViewController.magazine_issueNo = 21;
    magazinePageViewController.serverBookId = bean.numServerBookId;
    magazinePageViewController.magazineName = bean.vc2BookName;
    [self.navigationController pushViewController:magazinePageViewController animated:YES];
}

- (void)clickMagazine_4:(id)respd {
    NSLog(@"clickMagazine_4...");
    MagazineDao *dao = [[[MagazineDao alloc] init] autorelease];
    MagazineBean *bean = [dao queryDataFromDBById:@"1004"];
    if (nil == bean){
        return;
    }
    MagazinePageViewController *magazinePageViewController = [[[MagazinePageViewController alloc] init] autorelease];
    magazinePageViewController.magazine_issueNo = 22;
    magazinePageViewController.magazineName = bean.vc2BookName;
    magazinePageViewController.serverBookId = bean.numServerBookId;
    [self.navigationController pushViewController:magazinePageViewController animated:YES];
}

- (void)clickMagazine_5:(id)respd {
    NSLog(@"clickMagazine_5...");
    MagazineDao *dao = [[[MagazineDao alloc] init] autorelease];
    MagazineBean *bean = [dao queryDataFromDBById:@"1005"];
    if (nil == bean){
        return;
    }
    MagazinePageViewController *magazinePageViewController = [[[MagazinePageViewController alloc] init] autorelease];
    magazinePageViewController.magazine_issueNo = 21;
    magazinePageViewController.magazineName = bean.vc2BookName;
    magazinePageViewController.serverBookId = bean.numServerBookId;
    [self.navigationController pushViewController:magazinePageViewController animated:YES];
}

- (void)dealloc {
    NSLog(@"dealloc...");
    [g_items release];
    [g_request release];
    [receiveData release];
    [super dealloc];
}
@end