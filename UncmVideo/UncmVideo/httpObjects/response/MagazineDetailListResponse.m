//
// Created by xinyingtiyu on 13-4-2.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MagazineDetailListResponse.h"
#import "JSON.h"


@implementation MagazineDetailListResponse

@synthesize MagazineBeans;

-(SuperResponse *)initWithJsonString:(NSString *)jsonStr{//将json string转换为本对象
    [super init];
    NSDictionary *results = [jsonStr JSONValue];
    self.MagazineBeans = [results objectForKey:@"magazineResourceBeans"];
    return self;
}

@end