//
// Created by xinyingtiyu on 13-4-10.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class UserInfo;


@interface UserInfoDao : NSObject

//将bean插入或者更新到表中
- (void)updateOrInsertTable:(UserInfo *)bean;
//从数据库中查询出数据
-(NSMutableArray *)queryDataFromDB;
//根据id从数据库中查询出数据
-(UserInfo *)queryDataFromDBById:(NSString *)id;
//清除数据库中的数据
-(BOOL)eraseDBByTableName;


@end