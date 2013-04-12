//
// Created by xinyingtiyu on 13-3-19.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "STableViewController.h"
#import "CommonHeadProtocol.h"
#import "NoTableNetConnViewController.h"


@interface LoginViewController : NoTableNetConnViewController <CommonHeadProtocol, UITextFieldDelegate> {
    bool g_isChcked;
    UIButton *g_right_btn;
    UITextField *g_userName;
    UITextField *g_pwd;
}

@property(nonatomic) NSString *userPhone;

@end