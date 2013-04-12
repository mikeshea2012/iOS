//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UserFeeInfoRequest.h"


@implementation UserFeeInfoRequest
@synthesize methodName,userID;

-(NSString *)getJsonStr {
    NSString *jsonString = [[[NSString alloc] initWithFormat:
            @"{\n"
                    "\"method\":\"%@\"\n"
                    "\"userID\":\"%@\"\n"
                    "}"
            ,methodName, userID] autorelease];
    return jsonString;
}





@end