//
// Created by xinyingtiyu on 13-3-21.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "SuperRequest.h"


@interface BaseRequest : SuperRequest
@property (nonatomic) NSString *action;//操作名称
@property (nonatomic) NSString *ngLabel;//特殊标签

-(NSString *)getJsonStr;//将本对象转换为string
//-(BaseRequest *)initWithJsonString:(NSString *)str;//将string转换为本对象

@end