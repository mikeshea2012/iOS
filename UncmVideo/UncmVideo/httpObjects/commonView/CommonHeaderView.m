//
// Created by xinyingtiyu on 13-4-7.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "CommonHeaderView.h"
#import "CommonHeadProtocol.h"
#import "HeaderViewInfoBean.h"


@implementation CommonHeaderView
@synthesize delegate;

-(void)setNavi:(HeaderViewInfoBean *)bean{
    if (nil != delegate){
        UIViewController *viewController = (UIViewController *)delegate;
        [viewController.navigationController.navigationBar
                setBackgroundImage:[UIImage imageNamed:@"navi_bg_height_1.png"]
                     forBarMetrics:UIBarMetricsDefault];
        [viewController.navigationController.navigationBar setContentMode:UIViewContentModeScaleToFill];
        viewController.navigationItem.title = bean.title;
        //part1:导航栏-->  1.1 左边的导航条-->杂志
        UIButton *left_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        left_btn.frame = CGRectMake(0, 0, 37, 28);
        [left_btn setBackgroundImage:[UIImage imageNamed:bean.leftBtnImgName] forState:UIControlStateNormal];
        [left_btn addTarget:self action:@selector(responseLeft) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *left_barBtn = [[[UIBarButtonItem alloc] initWithCustomView:left_btn] autorelease];
        viewController.navigationItem.leftBarButtonItem = left_barBtn;
        //part1:导航栏--> 1.3右边的导航条-->关于我们
        UIButton *right_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        right_btn.frame = CGRectMake(0, 0, 37, 28);
        [right_btn setBackgroundImage:[UIImage imageNamed:bean.rightBtnImgName] forState:UIControlStateNormal];
        [right_btn addTarget:self action:@selector(responseRight) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *right_barBtn = [[[UIBarButtonItem alloc] initWithCustomView:right_btn] autorelease];
        viewController.navigationItem.rightBarButtonItem = right_barBtn;
    }
}

-(id)initWitHighlightIndex:(int)highlightIndex{
    [super init];

    self.frame = CGRectMake(0, 0, 320, 35);
    self.userInteractionEnabled = YES;
    //part1:导航栏-->中间的分隔线(赛事中心顶部)
    UIImageView *filterImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_filter.png"]] autorelease];
    filterImageView.frame = CGRectMake(0, 0, 320, 1);
    [self addSubview:filterImageView];

    //比赛直播背景
    UIImage *tabImage_gameCenter = [UIImage imageNamed:@"menu_159_33"];
    if (highlightIndex == 1){
        tabImage_gameCenter = [UIImage imageNamed:@"menu_bg_159_33"];
    }
    UIImageView *tabImageView_gameCenter = [[[UIImageView alloc] initWithImage:tabImage_gameCenter] autorelease];
    tabImageView_gameCenter.frame = CGRectMake(0, 1, 320 / 3.0, 35);
    tabImageView_gameCenter.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:tabImageView_gameCenter];
    //比赛直播中文
    UILabel *label_gameCenter = [[[UILabel alloc] init] autorelease];
    label_gameCenter.text = @"比赛直播";
    [label_gameCenter setTextAlignment:NSTextAlignmentCenter]; //字体位置，居左还是居中还是居右
    [label_gameCenter setFont:[UIFont systemFontOfSize:15]]; //字体
    [label_gameCenter setTextColor:[UIColor whiteColor]];   //文字颜色
    label_gameCenter.frame = CGRectMake(0, 1, 320 / 3.0, 35);
    label_gameCenter.backgroundColor = [UIColor clearColor];
    [self addSubview:label_gameCenter];
    label_gameCenter.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap_FP = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(gotoFP)] autorelease];
    [label_gameCenter addGestureRecognizer:singleTap_FP];
    //直播回看
    UIImage *tabImage_epl_list = [UIImage imageNamed:@"menu_159_33"];
    if (highlightIndex == 2){
        tabImage_epl_list = [UIImage imageNamed:@"menu_bg_159_33"];
    }
    UIImageView *tabImage_epl_list_view = [[[UIImageView alloc] initWithImage:tabImage_epl_list] autorelease];
    tabImage_epl_list_view.frame = CGRectMake(320 / 3.0, 2, 320 / 3.0, 35);
    tabImage_epl_list_view.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:tabImage_epl_list_view];



    //直播回看中文
    UILabel *label_epl_list = [[[UILabel alloc] init] autorelease];
    label_epl_list.text = @"直播回看";
    [label_epl_list setTextAlignment:NSTextAlignmentCenter]; //字体位置，居左还是居中还是居右
    [label_epl_list setFont:[UIFont systemFontOfSize:15]]; //字体
    [label_epl_list setTextColor:[UIColor whiteColor]];   //文字颜色
    label_epl_list.frame = CGRectMake(320 / 3.0, 1, 320 / 3.0, 35);
    label_epl_list.backgroundColor = [UIColor clearColor];
    [self addSubview:label_epl_list];
    label_epl_list.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(gotoSubs)] autorelease];
    [label_epl_list addGestureRecognizer:singleTap];

    //视频集锦
    UIImage *tabImage_epl_list2 = [UIImage imageNamed:@"menu_159_33"];
    if (highlightIndex == 3){
        tabImage_epl_list2 = [UIImage imageNamed:@"menu_bg_159_33"];
    }
    UIImageView *tabImage_epl_list_view2 = [[[UIImageView alloc] initWithImage:tabImage_epl_list2] autorelease];
    tabImage_epl_list_view2.frame = CGRectMake(320*2 / 3.0, 2, 320 / 3.0, 35);
    tabImage_epl_list_view2.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:tabImage_epl_list_view2];

    //视频集锦中文
    UILabel *label_epl_list2 = [[[UILabel alloc] init] autorelease];
    label_epl_list2.text = @"视频集锦";
    [label_epl_list2 setTextAlignment:NSTextAlignmentCenter]; //字体位置，居左还是居中还是居右
    [label_epl_list2 setFont:[UIFont systemFontOfSize:15]]; //字体
    [label_epl_list2 setTextColor:[UIColor whiteColor]];   //文字颜色
    label_epl_list2.frame = CGRectMake(320*2/ 3.0, 1, 320 / 3.0, 35);
    label_epl_list2.backgroundColor = [UIColor clearColor];
    [self addSubview:label_epl_list2];
    label_epl_list2.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap2 = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(gotoSubs2)] autorelease];
    [label_epl_list2 addGestureRecognizer:singleTap2];

    return self;
}

-(void)responseLeft{
    if ([delegate respondsToSelector:@selector(responseLeft)]){
        [delegate responseLeft];
    }
}
-(void)responseRight{
    if ([delegate respondsToSelector:@selector(responseRight)]){
        [delegate responseRight];
    }
}
-(void)gotoFP{
    if ([delegate respondsToSelector:@selector(gotoFP)]){
        [delegate gotoFP];
    }
}

-(void)gotoSubs{
    if ([delegate respondsToSelector:@selector(gotoSubs)]){
        [delegate gotoSubs];
    }
}

-(void)gotoSubs2{
    if ([delegate respondsToSelector:@selector(gotoSubs2)]){
        [delegate gotoSubs2];
    }
}

- (void)dealloc {
    [delegate release];
    [super dealloc];
}


@end