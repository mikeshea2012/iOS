//
// Created by xinyingtiyu on 13-3-21.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaseRequest.h"
#import "JSON.h"


@implementation BaseRequest
@synthesize action,ngLabel;

-(NSString *)getJsonStr{//将本对象转换为string
    NSString *jsonString = [[[NSString alloc] initWithFormat:
             @"{\"action\":\"%@\",\"ngLabel\":\"%@\"}", self.action, self.ngLabel] autorelease];
    return jsonString;
}



@end