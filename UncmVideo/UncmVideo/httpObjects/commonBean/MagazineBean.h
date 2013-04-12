//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface MagazineBean : NSObject  <NSCoding>
//@interface MagazineBean : NSObject

@property (nonatomic) NSString *numServerBookId;
@property (nonatomic) NSString *numBookId;
@property (nonatomic) NSString *vc2BookName;
@property (nonatomic) NSString *vc2Enableflag;
@property (nonatomic) NSString *datcreate;
@property (nonatomic) NSString *vc2Creater;
@property (nonatomic) NSString *datupdate;
@property (nonatomic) NSString *vc2Updater;
@property (nonatomic) NSString *datpublist;
@property (nonatomic) NSString *vc2Publister;
@property (nonatomic) NSString *numIndexAsc;
@property (nonatomic) NSString *vc2Desc;
@property (nonatomic) NSString *vc2CoverUrl;
@property (nonatomic) NSString *vc2Periods;

-(NSString *)getJsonStr;
-(MagazineBean *)initWithJsonStr:(NSString *)jsonStr;

@end