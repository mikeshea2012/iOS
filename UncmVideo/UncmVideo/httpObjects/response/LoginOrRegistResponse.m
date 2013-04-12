//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "LoginOrRegistResponse.h"
#import "JSON.h"

@implementation LoginOrRegistResponse

@synthesize result,loginStatus,userID,userName,returnMsg;

-(SuperResponse *)initWithJsonString:(NSString *)jsonStr{//将json string转换为本对象
    [super init];
    NSDictionary *results = [jsonStr JSONValue];
    self.returnCode = [results objectForKey:@"returnCode"];
    returnMsg = [results objectForKey:@"returnMsg"];
    result = [results objectForKey:@"result"];
    loginStatus = [results objectForKey:@"loginStatus"];
    userID = [results objectForKey:@"userID"];
    userName = [results objectForKey:@"userName"];
    return self;
}


@end