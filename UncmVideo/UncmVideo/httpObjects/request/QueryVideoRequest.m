//
// Created by xinyingtiyu on 13-4-7.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "QueryVideoRequest.h"


@implementation QueryVideoRequest

@synthesize methodName,startNUM,endNUM;

-(NSString *)getJsonStr {

    NSString *jsonString = [[[NSString alloc] initWithFormat:
            @"{\n"
                    "  \"method\":\"%@\","
                    "  \"startNUM\":\"%@\","
                    "  \"endNUM\":\"%@\""
                    "}"
            ,methodName,startNUM,endNUM] autorelease];
    return jsonString;
}


@end