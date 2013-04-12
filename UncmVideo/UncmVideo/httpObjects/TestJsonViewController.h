//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface TestJsonViewController : UIViewController <NSURLConnectionDataDelegate>

+(NSString *)getUserFeeInfoTestRespStr; //getUserFeeInfo的应答string
+(NSString *)getLoginTestRespStr; //login的应答string
+(NSString *)getFP1TestRespStr; //首页第一个tab的应答string

@end