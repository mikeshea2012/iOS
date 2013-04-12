//
// Created by xinyingtiyu on 13-3-31.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "People.h"


@implementation People

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.numId forKey:@"numId"];
    [aCoder encodeObject:self.vc2Name forKey:@"vc2Name"];
}
-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    self.numId = [aDecoder decodeObjectForKey:@"numId"];
    self.vc2Name = [aDecoder decodeObjectForKey:@"vc2Name"];
    return self;
}

@end