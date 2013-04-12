//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "VideoUrlResponse.h"
#import "JSON.h"

@implementation VideoUrlResponse
@synthesize videoUrl;

-(SuperResponse *)initWithJsonString:(NSString *)str {
    [super init];
    NSDictionary *dic = [str JSONValue];
    videoUrl = [dic objectForKey:@"videoUrl"];
    return self;
}

@end