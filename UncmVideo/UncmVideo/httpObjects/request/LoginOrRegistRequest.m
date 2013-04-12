//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "LoginOrRegistRequest.h"


@implementation LoginOrRegistRequest
@synthesize methodName,userName,password;

-(NSString *)getJsonStr{//将本对象转换为string
    NSString *jsonString = [[[NSString alloc] initWithFormat:
            @"{\n"
                    "\"methodName\":\"%@\",\n"
                    "\"userName\":\"%@\",\n"
                    "\"password\":\"%@\",\n"
                    "}",methodName,userName,password
    ] autorelease];
    return jsonString;
}


@end