//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "SuperRequest.h"


@interface LoginOrRegistRequest : SuperRequest

@property (nonatomic) NSString *methodName;
@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *password;

@end