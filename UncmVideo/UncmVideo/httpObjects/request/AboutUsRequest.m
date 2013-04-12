//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "AboutUsRequest.h"


@implementation AboutUsRequest

-(NSString *)getJsonStr{//将本对象转换为string
    NSString *jsonString = [[[NSString alloc] initWithFormat:
            @"{}"] autorelease];
    return jsonString;
}


@end