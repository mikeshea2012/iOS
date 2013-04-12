//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "SuperRequest.h"


@interface VideoListRequest : SuperRequest

@property (nonatomic) NSString *methodName;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *start;
@property (nonatomic) NSString *end;
@property (nonatomic) int offset;
@property (nonatomic) int count;



@end