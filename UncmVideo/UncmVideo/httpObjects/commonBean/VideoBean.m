//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "VideoBean.h"
#import "JSON.h"


@implementation VideoBean
@synthesize videoId,vUrl,vName,vStart,start_time,start_date,
vEnd,team1Id,team1Name,team1ImageUrl,team2Id,team2Name,team2ImageUrl,vDesc,vStatus,vPic,vPic2;

-(NSString *)getJsonStr{
    NSString *jsonStr = [[[NSString alloc] initWithFormat:
            @"{\n"
                    "            \"videoId\" : \"%@\",\n"
                    "            \"vUrl\" : \"%@\",\n"
                    "            \"vName\" : \"%@\",\n"
                    "            \"vStart\" : \"%@\",\n"
                    "            \"vEnd\" : \"%@\",\n"
                    "            \"team1Id\" : \"%@\",\n"
                    "            \"team2Id\" : \"%@\",\n"
                    "            \"vDesc\" : \"%@\",\n"
                    "            \"vStatus\" : \"%@\",\n"
                    "            \"vPic\" : \"%@\",\n"
                    "            \"vPic2\" : \"%@\"\n"
                    "         }", videoId, vUrl, vName, vStart, vEnd, team1Id, team2Id, vDesc, vStatus, vPic, vPic2] autorelease];
    return jsonStr;
}
-(VideoBean *)initWithJsonStr:(NSString *)jsonStr{
    [super init];
    NSDictionary *dictionary = [jsonStr JSONValue];
    videoId = [dictionary objectForKey:@"videoId"];
    vUrl = [dictionary objectForKey:@"vUrl"];
    vName = [dictionary objectForKey:@"vName"];
    vStart = [dictionary objectForKey:@"vStart"];
    start_time = [dictionary objectForKey:@"start_time"];
    start_date = [dictionary objectForKey:@"start_date"];
    vEnd = [dictionary objectForKey:@"vEnd"];
    team1Id = [dictionary objectForKey:@"team1Id"];
    team1Name = [dictionary objectForKey:@"team1Name"];
    team1ImageUrl = [dictionary objectForKey:@"team1ImageUrl"];
    team2Id = [dictionary objectForKey:@"team2Id"];
    team2Name = [dictionary objectForKey:@"team2Name"];
    team2ImageUrl = [dictionary objectForKey:@"team2ImageUrl"];
    vDesc = [dictionary objectForKey:@"vDesc"];
    vStatus = [dictionary objectForKey:@"vStatus"];
    vPic = [dictionary objectForKey:@"vPic"];
    vPic2 = [dictionary objectForKey:@"vPic2"];
    return self;
}

+(VideoBean *)initWithDic:(NSDictionary *)dictionary{
    VideoBean *bean = [[[VideoBean alloc] init] autorelease];
    bean.videoId = [dictionary objectForKey:@"videoId"];
    bean.vUrl = [dictionary objectForKey:@"vUrl"];
    bean.vName = [dictionary objectForKey:@"vName"];
    bean.vStart = [dictionary objectForKey:@"vStart"];
    bean.start_time = [dictionary objectForKey:@"start_time"];
    bean.start_date = [dictionary objectForKey:@"start_date"];
    bean.vEnd = [dictionary objectForKey:@"vEnd"];
    bean.team1Id = [dictionary objectForKey:@"team1Id"];
    bean.team1Name = [dictionary objectForKey:@"team1Name"];
    bean.team1ImageUrl = [dictionary objectForKey:@"team1ImageUrl"];
    bean.team2ImageUrl = [dictionary objectForKey:@"team2ImageUrl"];
    bean.team2Name = [dictionary objectForKey:@"team2Name"];
    bean.team2Id = [dictionary objectForKey:@"team2Id"];
    bean.vDesc = [dictionary objectForKey:@"vDesc"];
    bean.vStatus = [dictionary objectForKey:@"vStatus"];
    bean.vPic = [dictionary objectForKey:@"vPic"];
    bean.vPic2 = [dictionary objectForKey:@"vPic2"];
    return bean;
}



- (void)dealloc {
    [videoId release];
    [vUrl release];
    [vName release];
    [vStart release];
    [vEnd release];
    [team1Id release];
    [team2Id release];
    [vDesc release];
    [vStatus release];
    [vPic release];
    [vPic2 release];
    [team1Name release];
    [team1ImageUrl release];
    [team2Name release];
    [team2ImageUrl release];
    [start_time release];
    [start_date release];
    [super dealloc];
}

@end