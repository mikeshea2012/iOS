//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface VideoBean : NSObject
@property (nonatomic,retain) NSString *videoId;
@property (nonatomic,retain) NSString *vUrl;
@property (nonatomic,retain) NSString *vName;
@property (nonatomic,retain) NSString *vStart;
@property (nonatomic,retain) NSString *start_time;
@property (nonatomic,retain) NSString *start_date;
@property (nonatomic,retain) NSString *vEnd;
@property (nonatomic,retain) NSString *team1Name;
@property (nonatomic,retain) NSString *team1ImageUrl;
@property (nonatomic,retain) NSString *team1Id;
@property (nonatomic,retain) NSString *team2Name;
@property (nonatomic,retain) NSString *team2Id;
@property (nonatomic,retain) NSString *team2ImageUrl;

@property (nonatomic,retain) NSString *vDesc;
@property (nonatomic,retain) NSString *vStatus;
@property (nonatomic,retain) NSString *vPic;
@property (nonatomic,retain) NSString *vPic2;

-(NSString *)getJsonStr;
-(VideoBean *)initWithJsonStr:(NSString *)jsonStr;
+(VideoBean *)initWithDic:(NSDictionary *)dict;


@end