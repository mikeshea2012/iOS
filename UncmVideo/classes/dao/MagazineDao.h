//
// Created by xinyingtiyu on 13-4-2.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class MagazineBean;


@interface MagazineDao : NSObject
//将bean插入或者更新到表中
- (void)updateOrInsertTable:(MagazineBean *)bean;
//从数据库中查询出数据
-(NSMutableArray *)queryDataFromDB;
//根据id从数据库中查询出数据
-(MagazineBean *)queryDataFromDBById:(NSString *)id;
//清除数据库中的数据
-(BOOL)eraseDBByTableName;
@end