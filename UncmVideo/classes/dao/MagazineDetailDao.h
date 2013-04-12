//
// Created by xinyingtiyu on 13-4-3.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class MagazineDetailBean;


@interface MagazineDetailDao : NSObject

//将bean插入或者更新到表中
- (void)updateOrInsertTable:(MagazineDetailBean *)bean;
//从数据库中查询出数据
-(NSMutableArray *)queryDataFromDB;
//根据id从数据库中查询出数据
-(MagazineDetailBean *)queryDataFromDBById:(NSString *)id;
//清除数据库中的数据
-(BOOL)eraseDBByBookId:(NSString *)bookId;


@end