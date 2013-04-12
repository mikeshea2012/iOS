//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MagzineListRequest.h"


@implementation MagzineListRequest

@synthesize methodName,startNUM,endNUM;

-(NSString *)getJsonStr {

    NSString *jsonString = [[[NSString alloc] initWithFormat:
            @"{\n"
                    "  \"method\":\"%@\",\n"
                    "  \"startNUM\":\"%@\",\n"
                    "  \"endNUM\":\"%@\"\n"
                    "}"
                    ,methodName, startNUM,endNUM] autorelease];
    return jsonString;
}


@end