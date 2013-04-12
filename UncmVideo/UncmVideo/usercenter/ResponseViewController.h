//
// Created by xinyingtiyu on 13-3-19.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "NoTableNetConnViewController.h"
#import "CommonHeadProtocol.h"

@interface ResponseViewController : NoTableNetConnViewController <CommonHeadProtocol, UITextFieldDelegate, UIAlertViewDelegate> {
    bool g_response_key;
    UITextView *g_textView;
    UIButton *g_right_btn;
}
@property(nonatomic) NSString *fromString;

@end