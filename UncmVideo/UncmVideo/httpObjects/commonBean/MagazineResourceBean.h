//
// Created by xinyingtiyu on 13-4-2.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface MagazineResourceBean : NSObject

@property (nonatomic) NSString *numResId;
@property (nonatomic) NSString *vc2ResName;
@property (nonatomic) NSString *vc2Desc;
@property (nonatomic) NSString *vc2Enableflag;
@property (nonatomic) NSString *vc2ResType;
@property (nonatomic) NSString *vc2PicUrl;
@property (nonatomic) NSString *vc2VideoUrl;
@property (nonatomic) NSString *vc2PadvideoUrl;
@property (nonatomic) NSString *numIndexAsc;
@property (nonatomic) NSString *numBookId;

-(NSString *)getJsonStr;
-(MagazineResourceBean *)initWithJsonStr:(NSString *)jsonStr;

@end