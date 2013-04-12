//
// Created by xinyingtiyu on 13-4-2.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MagzineDetailListRequest.h"


@implementation MagzineDetailListRequest
@synthesize methodName,magzineID;

-(NSString *)getJsonStr {

    NSString *jsonString = [[[NSString alloc] initWithFormat:
            @"{\n"
                    "  \"method\":\"%@\",\n"
                    "  \"magzineID\":\"%@\""
                    "}"
            ,methodName, magzineID] autorelease];
    return jsonString;
}


@end