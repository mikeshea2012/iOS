//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MagazineListResponse.h"
#import "JSON.h"


@implementation MagazineListResponse
@synthesize totalNumber,from,to,MagazineBeans;

-(SuperResponse *)initWithJsonString:(NSString *)jsonStr{//将json string转换为本对象
    [super init];
    NSDictionary *results = [jsonStr JSONValue];
    self.totalNumber = [results objectForKey:@"totalNumber"];
    self.from = [results objectForKey:@"from"];
    self.to = [results objectForKey:@"to"];
    self.MagazineBeans = [results objectForKey:@"magazineBeans"];
    return self;
}


@end