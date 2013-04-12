//
// Created by xinyingtiyu on 13-3-21.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "LoginResponse.h"
#import "JSON.h"


@implementation LoginResponse


@synthesize defaultSearchWords;

-(SuperResponse *)initWithJsonString:(NSString *)jsonStr{//将json string转换为本对象
    [super init];
    NSDictionary *results = [jsonStr JSONValue];
    self.defaultSearchWords = [results objectForKey:@"defaultSearchWords"];
    return self;
}



@end