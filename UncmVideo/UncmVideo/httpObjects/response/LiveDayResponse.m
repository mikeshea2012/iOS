//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SuperResponse.h"
#import "LiveDayResponse.h"
#import "JSON.h"


@implementation LiveDayResponse
@synthesize dateList;

-(SuperResponse *)initWithJsonString:(NSString *)jsonStr{//将json string转换为本对象
    [super init];
    NSDictionary *results = [jsonStr JSONValue];
    NSArray *_dateList = [results objectForKey:@"dateList"];
    self.dateList = _dateList;
    return self;
}

@end