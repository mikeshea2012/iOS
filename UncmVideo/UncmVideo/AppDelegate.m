//
// Created by xinyingtiyu on 13-4-7.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "AppDelegate.h"
#import "FirstPageViewController.h"
#import "TestJsonViewController.h"
#import "UserInfo.h"
//#import "MasterViewController.h"


@implementation AppDelegate

@synthesize userInfo,str_serviceUrl,nav,g_is_debug_mode;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    str_serviceUrl = @"http://161.2.1.205:8088/ssports_app/base";
    str_serviceUrl = @"http://122.200.86.243:8088/ssports_app/base";
//    str_serviceUrl = @"http://161.2.1.235:8898/phoneweb/ssgmobile";
    self.g_is_debug_mode = YES;

    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    FirstPageViewController *tbvc = [[[FirstPageViewController alloc] init] autorelease];
//    MasterViewController *tbvc = [[[MasterViewController alloc]
//            initWithNibName:@"MasterViewController" bundle:nil] autorelease];
//    TestJsonViewController *tbvc = [[[TestJsonViewController alloc] init] autorelease];
    nav = [[[UINavigationController alloc] initWithRootViewController:tbvc] autorelease];
    window.rootViewController = nav;
    [window makeKeyAndVisible];
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    return YES;
}

- (void)dealloc {
    [window release];
    [userInfo release];
    [str_serviceUrl release];
//    [nav release];
    [nav release];
    [super dealloc];
}
@end