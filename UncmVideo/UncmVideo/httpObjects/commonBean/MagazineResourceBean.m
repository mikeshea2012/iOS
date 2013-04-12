//
// Created by xinyingtiyu on 13-4-2.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MagazineResourceBean.h"
#import "JSON.h"


@implementation MagazineResourceBean


@synthesize numResId,vc2ResName,vc2Desc,vc2Enableflag,vc2ResType,
vc2PicUrl,vc2VideoUrl,vc2PadvideoUrl,numIndexAsc,numBookId;


-(NSString *)getJsonStr{
    NSString *jsonStr = [[[NSString alloc] initWithFormat:
            @"   {\n"
                    "    \"numResId\":\"%@\",\n"
                    "    \"vc2ResName\":\"%@\",\n"
                    "    \"vc2Desc\":\"%@\",\n"
                    "    \"vc2Enableflag\":\"%@\",\n"
                    "    \"vc2ResType\":\"%@\",\n"

                    "    \"vc2PicUrl\":\"%@\",\n"
                    "    \"vc2VideoUrl\":\"%@\",\n"
                    "    \"vc2PadvideoUrl\":\"%@\",\n"
                    "    \"numIndexAsc\":\"%@\",\n"
                    "    \"numBookId\":\"%@\""
                    "   }",
                    numResId,vc2ResName,vc2Desc,vc2Enableflag,vc2ResType,
                    vc2PicUrl,vc2VideoUrl,vc2PadvideoUrl,numIndexAsc,numBookId

    ] autorelease];
    return jsonStr;
}
-(MagazineResourceBean *)initWithJsonStr:(NSString *)jsonStr{
    [super init];
    NSDictionary *dictionary = [jsonStr JSONValue];
    numResId = [dictionary objectForKey:@"numResId"];
    vc2ResName = [dictionary objectForKey:@"vc2ResName"];
    vc2Desc = [dictionary objectForKey:@"vc2Desc"];
    vc2Enableflag = [dictionary objectForKey:@"vc2Enableflag"];
    vc2ResType = [dictionary objectForKey:@"vc2ResType"];

    vc2PicUrl = [dictionary objectForKey:@"vc2PicUrl"];
    vc2VideoUrl = [dictionary objectForKey:@"vc2VideoUrl"];
    vc2PadvideoUrl = [dictionary objectForKey:@"vc2PadvideoUrl"];
    numIndexAsc = [dictionary objectForKey:@"numIndexAsc"];
    numBookId = [dictionary objectForKey:@"numBookId"];

    return self;
}

@end