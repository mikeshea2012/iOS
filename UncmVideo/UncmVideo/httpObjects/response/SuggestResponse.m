//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SuggestResponse.h"
#import "JSON.h"

@implementation SuggestResponse


@synthesize result,loginStatus,userID,userName;

-(SuperResponse *)initWithJsonString:(NSString *)jsonStr{//将json string转换为本对象
    [super init];
    NSDictionary *results = [jsonStr JSONValue];
    result = [results objectForKey:@"result"];
    loginStatus = [results objectForKey:@"loginStatus"];
    userID = [results objectForKey:@"userID"];
    self.returnCode = [results objectForKey:@"returnCode"];
    userName = [results objectForKey:@"userName"];
    return self;
}

@end