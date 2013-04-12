//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "VideoUrlRequest.h"


@implementation VideoUrlRequest
@synthesize videoID;

-(NSString *)getJsonStr{
    NSString *jsonStr = [[[NSString alloc]
            initWithFormat:@"{\n"
                    "\"videoID\":\"%@\"\n"
                    "}",videoID] autorelease];
    return jsonStr;
}


@end