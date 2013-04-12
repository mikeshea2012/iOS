//
// Created by xinyingtiyu on 13-4-7.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "QueryVideoBean.h"


@implementation QueryVideoBean
@synthesize vc2title,vc2videourlunited,vc2summary,vc2thumbpicurl;

- (void)dealloc {
    [vc2title release];
    [vc2videourlunited release];
    [vc2summary release];
    [vc2thumbpicurl release];
    [super dealloc];
}
+(QueryVideoBean *)initWithDic:(NSDictionary *)dictionary{
    QueryVideoBean *bean = [[[QueryVideoBean alloc] init] autorelease];
    bean.vc2summary = [dictionary objectForKey:@"vc2summary"];
    bean.vc2thumbpicurl = [dictionary objectForKey:@"vc2thumbpicurl"];
    bean.vc2title = [dictionary objectForKey:@"vc2title"];
    bean.vc2videourlunited = [dictionary objectForKey:@"vc2videourlunited"];

    return bean;
}




@end