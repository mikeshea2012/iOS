//
// Created by xinyingtiyu on 13-4-7.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "QueryVideoResponse.h"
#import "JSON.h"


@implementation QueryVideoResponse

@synthesize totalNumber,from,to,videoBeans;

-(SuperResponse *)initWithJsonString:(NSString *)jsonStr{//将json string转换为本对象
    [super init];
    NSDictionary *results = [jsonStr JSONValue];
    self.totalNumber = [results objectForKey:@"totalNumber"];
    self.returnCode = [results objectForKey:@"returnCode"];
    self.from = [results objectForKey:@"from"];
    self.to = [results objectForKey:@"to"];
    self.videoBeans = [results objectForKey:@"videoBeans"];
    return self;
}

@end