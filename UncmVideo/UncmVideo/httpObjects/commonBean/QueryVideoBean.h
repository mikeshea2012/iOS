//
// Created by xinyingtiyu on 13-4-7.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface QueryVideoBean : NSObject

@property (nonatomic,retain) NSString *vc2title;
@property (nonatomic,retain) NSString *vc2videourlunited;
@property (nonatomic,retain) NSString *vc2summary;
@property (nonatomic,retain) NSString *vc2thumbpicurl;

+(QueryVideoBean *)initWithDic:(NSDictionary *)dictionary;
//-(BOOL)isEmptyOrNull:(NSString *)string;
@end