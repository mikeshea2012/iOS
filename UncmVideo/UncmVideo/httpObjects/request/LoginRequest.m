//
// Created by xinyingtiyu on 13-3-21.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "LoginRequest.h"
#import "JSON.h"
#import "BaseRequest.h"


@implementation LoginRequest
@synthesize baseRequest;
-(NSString *)getJsonStr{//将本对象转换为string
    NSString *jsonString = [[[NSString alloc] initWithFormat:
            @"{\"baseRequest\":%@}", self.baseRequest.getJsonStr] autorelease];
    return jsonString;
}



@end