//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "SuperResponse.h"


@interface MagazineListResponse : SuperResponse

@property (nonatomic) NSString *totalNumber;
@property (nonatomic) NSString *from;
@property (nonatomic) NSString *to;
@property (nonatomic) NSArray *MagazineBeans;




@end