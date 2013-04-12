//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "LiveDayRequest.h"


@implementation LiveDayRequest
@synthesize offset,count;


-(NSString *)getJsonStr{//将本对象转换为string
    NSString *jsonString = [[[NSString alloc] initWithFormat:
            @"{\"offset\":%d,\"count\":%d}", self.offset,self.count] autorelease];
    return jsonString;
}

@end