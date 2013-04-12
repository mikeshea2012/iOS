//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "SuperRequest.h"


@interface SuggestRequest : SuperRequest
@property (nonatomic) NSString *methodName;
@property (nonatomic) NSString *userID;
@property (nonatomic) NSString *suggestContent;
@end