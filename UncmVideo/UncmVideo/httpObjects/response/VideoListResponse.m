//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "VideoListResponse.h"
#import "JSON.h"


@implementation VideoListResponse
@synthesize timestamp,videos;

-(SuperResponse *)initWithJsonString:(NSString *)str {
    [super init];
    NSDictionary *dic = [str JSONValue];
    super.returnCode= [dic objectForKey:@"returnCode"];
    timestamp = [dic objectForKey:@"timestamp"];
    videos = [dic objectForKey:@"videos"];
    return self;
}


@end