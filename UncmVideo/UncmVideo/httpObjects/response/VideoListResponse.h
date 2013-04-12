//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "SuperResponse.h"


@interface VideoListResponse : SuperResponse

@property (nonatomic) NSString *timestamp;
@property (nonatomic) NSArray *videos;



@end