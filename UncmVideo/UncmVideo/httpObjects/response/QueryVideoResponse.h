//
// Created by xinyingtiyu on 13-4-7.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "SuperResponse.h"


@interface QueryVideoResponse : SuperResponse

@property (nonatomic) NSString *totalNumber;
@property (nonatomic) NSString *from;
@property (nonatomic) NSString *to;
@property (nonatomic) NSArray *videoBeans;




@end