#import <MediaPlayer/MediaPlayer.h>
#import "VideoPlayViewController.h"
#import "GlobalSetting.h"


@implementation VideoPlayViewController {
    MPMoviePlayerController *player;
    bool isPlaying;
}
@synthesize videoUrl;

//设置页面
- (void)loadView {
    [super loadView];

    //视频播放
    NSURL *url = nil;
    if ([GlobalSetting is_in_debug_mode]){//如果处于调试模式
        url = [NSURL URLWithString:@"http://161.2.1.235/video/2.m4v"];
    }else{
        url = [NSURL URLWithString:self.videoUrl];
    }
    player = [[MPMoviePlayerController alloc] initWithContentURL:url];
    self.view.backgroundColor = [UIColor redColor];
    int x = -80, y = 80, w = 480, h = 320;

    //针对不同的屏幕进行适配
    int delta = (int)([UIScreen mainScreen].bounds.size.height - 480.0);
    if (delta > 0){
        x = -124, y = 120, w = (int)[UIScreen mainScreen].bounds.size.height, h = 320;
    }
    player.view.frame = CGRectMake(x, y, w, h);

    [[NSNotificationCenter defaultCenter]
            addObserver:self selector:@selector(movieFinishedCallback:)
                   name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    [self.view addSubview:player.view];

    //返回按钮
    UILabel *backLabel = [[[UILabel alloc] initWithFrame:CGRectMake(240, 40, 80, 20)] autorelease];
    backLabel.backgroundColor = [UIColor clearColor];
    backLabel.font = [UIFont systemFontOfSize:20];
    backLabel.textAlignment = NSTextAlignmentCenter;
    backLabel.text = @"返回";
    backLabel.textColor = [UIColor colorWithRed:118.0 / 255.0 green:0 blue:0 alpha:1.0];
    [self.view addSubview:backLabel];
    backLabel.transform = CGAffineTransformIdentity;
    backLabel.transform = CGAffineTransformMakeRotation((CGFloat) (M_PI/ 2));
    backLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(goBack:)] autorelease];
    [backLabel addGestureRecognizer:singleTap];

    player.view.transform = CGAffineTransformIdentity;
    player.view.transform = CGAffineTransformMakeRotation((CGFloat) (M_PI/ 2));
    self.wantsFullScreenLayout = YES;
    player.view.contentMode = UIViewContentModeScaleAspectFill;
    player.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

//---play movie---
    [player play];
    isPlaying = true;
    [self.navigationController.navigationBar setHidden:YES];
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)goBack:(id)something {
    self.wantsFullScreenLayout = NO;
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.navigationBar setHidden:NO];
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [player stop];
    isPlaying = false;
    [self.navigationController popViewControllerAnimated:NO];
}


#pragma mark - ---当播放器播放完成后---
- (void)movieFinishedCallback:(NSNotification *)aNotification {
    MPMoviePlayerController *moviePlayer = [aNotification object];
    [[NSNotificationCenter defaultCenter]
            removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification
                    object:moviePlayer];
    [moviePlayer.view sendSubviewToBack:player.view];
    isPlaying = false;
}

- (void)dealloc {
    [player release];
    [super dealloc];
}


@end