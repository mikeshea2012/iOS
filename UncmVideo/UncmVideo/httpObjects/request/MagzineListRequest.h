//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "SuperRequest.h"


@interface MagzineListRequest : SuperRequest

@property (nonatomic) NSString *methodName;
@property (nonatomic) NSString *startNUM;
@property (nonatomic) NSString *endNUM;




@end