//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SuggestRequest.h"


@implementation SuggestRequest
@synthesize methodName,userID,suggestContent;


-(NSString *)getJsonStr {
    NSString *jsonString = [[[NSString alloc] initWithFormat:
            @"{\n"
                    "\"method\":\"%@\",\n"
                    "\"userID\":\"%@\",\n"
                    "\"suggestContent\":\"%@\"\n"
                    "}"
            ,methodName,userID,suggestContent] autorelease];
    return jsonString;
}
@end