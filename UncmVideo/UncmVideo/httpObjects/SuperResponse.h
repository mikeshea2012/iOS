//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface SuperResponse : NSObject

@property(nonatomic) NSString* returnCode;
-(SuperResponse *)initWithJsonString:(NSString *)str;//将string转换为本对象

@end