//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UserFeeInfoResponse.h"
#import "UserInfo.h"
#import "JSON.h"


@implementation UserFeeInfoResponse

@synthesize userInfo;

-(SuperResponse *)initWithJsonString:(NSString *)jsonStr{//将json string转换为本对象
    [super init];
    NSDictionary *results = [jsonStr JSONValue];
    UserInfo *tempUserInfo = [[[UserInfo alloc] init] autorelease];
    NSDictionary *dictionary = (NSDictionary *) [results objectForKey:@"userInfo"];
    tempUserInfo.UUID =  [dictionary objectForKey:@"UUID"];
    tempUserInfo.ispay =  [dictionary objectForKey:@"ispay"];
    self.userInfo = tempUserInfo;
    return self;
}

@end