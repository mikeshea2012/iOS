//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "VideoListRequest.h"


@implementation VideoListRequest
@synthesize methodName,type,start,end,offset,count;

-(NSString *)getJsonStr{
//    NSString *methodName = @"RequestListVideo";  // "method":"vod"
    NSString *jsonStr = [[[NSString alloc]
            initWithFormat:@"{\"method\":\"%@\",\"type\":\"%@\",\"start\":\"%@\","
                                   "\"end\":\"%@\",\"offset\":\"%d\",\"count\":\"%d\"}"
            ,methodName,type,start,end,offset,count] autorelease];
    return jsonStr;
}

@end