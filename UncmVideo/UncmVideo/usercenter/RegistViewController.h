//
// Created by xinyingtiyu on 13-3-19.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface RegistViewController : NoTableNetConnViewController <CommonHeadProtocol, UITextFieldDelegate> {
    bool g_isChcked;
    UIButton *g_right_btn;
    UITextField *g_userName;
    UITextField *g_pwd;
}
@end