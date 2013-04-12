//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "SuperResponse.h"


@interface LoginOrRegistResponse : SuperResponse

@property (nonatomic) NSString *returnMsg;


@property (nonatomic) NSString *result;
@property (nonatomic) NSString *loginStatus;
@property (nonatomic) NSString *userID;
@property (nonatomic) NSString *userName;


@end