//
// Created by xinyingtiyu on 13-4-7.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "FirstPageViewController.h"
#import "TestJsonViewController.h"

@class UserInfo;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
}
@property (nonatomic, retain) UINavigationController *nav;
@property (nonatomic, retain) UserInfo *userInfo;
//@property (nonatomic, retain) NSURL *serviceUrl;
@property (nonatomic, retain) NSString *str_serviceUrl;
@property (nonatomic) BOOL g_is_debug_mode;
@end