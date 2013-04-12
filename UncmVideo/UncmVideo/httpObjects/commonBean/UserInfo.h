//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface UserInfo : NSObject

@property (nonatomic, retain) NSString *UUID;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *passwd;
@property (nonatomic, retain) NSString *addtime;
@property (nonatomic, retain) NSString *regtype;
@property (nonatomic, retain) NSString *operatorid;
@property (nonatomic, retain) NSString *paytype;
@property (nonatomic, retain) NSString *ispay;
@property (nonatomic, retain) NSString *paytime;

-(NSString *)getJsonStr;
-(UserInfo *)initWithJsonStr:(NSString *)jsonStr;

@end