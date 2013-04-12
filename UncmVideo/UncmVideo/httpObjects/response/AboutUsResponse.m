//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "AboutUsResponse.h"
#import "JSON.h"


@implementation AboutUsResponse

@synthesize aboutUrl;

-(SuperResponse *)initWithJsonString:(NSString *)jsonStr{//将json string转换为本对象
    [super init];
    NSDictionary *results = [jsonStr JSONValue];
    aboutUrl = [results objectForKey:@"aboutUrl"];
    return self;
}



@end