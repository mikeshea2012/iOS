//
// Created by xinyingtiyu on 13-3-21.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "SuperRequest.h"

@class BaseRequest;

@interface LoginRequest : SuperRequest

@property (nonatomic) BaseRequest* baseRequest;

-(NSString *)getJsonStr;//将本对象转换为string
//-(LoginRequest *)initWithJsonString:(NSString *)str;//将string转换为本对象

@end