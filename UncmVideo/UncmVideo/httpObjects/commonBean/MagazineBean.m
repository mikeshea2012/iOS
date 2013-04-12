//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MagazineBean.h"
#import "JSON.h"


@implementation MagazineBean

@synthesize numServerBookId,numBookId,vc2BookName,vc2Enableflag,datcreate,vc2Creater,datupdate,vc2Updater,
datpublist,vc2Publister,numIndexAsc,vc2Desc,vc2CoverUrl,vc2Periods;


-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.vc2Desc forKey:@"vc2Desc"];
    [aCoder encodeObject:self.vc2CoverUrl forKey:@"vc2CoverUrl"];
    [aCoder encodeObject:self.vc2BookName forKey:@"vc2BookName"];
}
-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    self.vc2Desc = [aDecoder decodeObjectForKey:@"vc2Desc"];
    self.vc2CoverUrl = [aDecoder decodeObjectForKey:@"vc2CoverUrl"];
    self.vc2BookName = [aDecoder decodeObjectForKey:@"vc2BookName"];
    return self;
}


-(NSString *)getJsonStr{
    NSString *jsonStr = [[[NSString alloc] initWithFormat:
            @"   {\n"
                    "    \"numBookId\":\"%@\",\n"
                    "    \"vc2BookName\":\"%@\",\n"
                    "    \"vc2Enableflag\":\"%@\",\n"
                    "    \"datcreate\":\"%@\",\n"
                    "    \"vc2Creater\":\"%@\",\n"
                    "    \"datupdate\":\"%@\",\n"
                    "    \"vc2Updater\":\"%@\",\n"
                    "    \"datpublist\":\"%@\",\n"
                    "    \"vc2Publister\":\"%@\",\n"
                    "    \"numIndexAsc\":\"%@\",\n"
                    "    \"vc2Desc\":\"%@\",\n"
                    "    \"vc2CoverUrl\":\"%@\",\n"
                    "    \"vc2Periods\":\"%@\"\n"
                    "   }",numBookId,vc2BookName,vc2Enableflag,datcreate,vc2Creater,
                    datupdate,vc2Updater,datpublist,vc2Publister,numIndexAsc,
                    vc2Desc,vc2CoverUrl,vc2Periods

    ] autorelease];
    return jsonStr;
}
-(MagazineBean *)initWithJsonStr:(NSString *)jsonStr{
    [super init];
    NSDictionary *dictionary = [jsonStr JSONValue];
    numBookId = [dictionary objectForKey:@"numBookId"];
    vc2BookName = [dictionary objectForKey:@"vc2BookName"];
    vc2Enableflag = [dictionary objectForKey:@"vc2Enableflag"];
    datcreate = [dictionary objectForKey:@"datcreate"];
    vc2Creater = [dictionary objectForKey:@"vc2Creater"];

    datupdate = [dictionary objectForKey:@"datupdate"];
    vc2Updater = [dictionary objectForKey:@"vc2Updater"];
    datpublist = [dictionary objectForKey:@"datpublist"];
    vc2Publister = [dictionary objectForKey:@"vc2Publister"];
    numIndexAsc = [dictionary objectForKey:@"numIndexAsc"];

    vc2Desc = [dictionary objectForKey:@"vc2Desc"];
    vc2CoverUrl = [dictionary objectForKey:@"vc2CoverUrl"];
    vc2Periods = [dictionary objectForKey:@"vc2Periods"];
    return self;
}

- (void)dealloc {
//    [vc2BookName release];
//    [vc2Desc release];
//    [vc2CoverUrl release];
    [super dealloc];
}


@end