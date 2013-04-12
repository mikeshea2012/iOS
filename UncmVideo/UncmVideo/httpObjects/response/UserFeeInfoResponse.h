//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "SuperResponse.h"

@class UserInfo;


@interface UserFeeInfoResponse : SuperResponse

@property (nonatomic) UserInfo *userInfo;

@end