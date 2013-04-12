//
// Created by xinyingtiyu on 13-4-3.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MagazineDetailDao.h"
#import "MagazineDetailBean.h"
#import "FMDatabase.h"


@implementation MagazineDetailDao {
    FMDatabase *g_db;
}

//确保数据库对象及表存在
-(void)initDB{
    if (g_db == nil){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"magazineDetailList.db"];
        g_db = [FMDatabase databaseWithPath:dbPath];
    }
    [g_db open];
    BOOL isTableExist = NO;
    FMResultSet *rs = [g_db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", @"MagazineDetailList"];
    while ([rs next]) {
        NSInteger count = [rs intForColumn:@"count"];
        if (0 != count){
            isTableExist = YES;
        }
    }
    if (!isTableExist) {
        [g_db executeUpdate:@"CREATE TABLE MagazineDetailList (bookId text,bookDetailJsonStr text)"];
    }
}

//将bean插入或者更新到表中
- (void)updateOrInsertTable:(MagazineDetailBean *)bean {
    [self initDB];
    NSLog(@"before");
    NSLog(@"bookId=%@",bean.bookId);
    NSLog(@"after");

    FMResultSet *rs = [g_db executeQuery:@"select count(*) as 'count' from MagazineDetailList "
                                                 " where bookId = ?", bean.bookId];
    BOOL isBeanExist = NO;
    while ([rs next]) {
        NSInteger count = [rs intForColumn:@"count"];
        if (0 != count){
            isBeanExist = YES;
        }
    }
    [rs close];
    if (isBeanExist){
        [g_db executeUpdate:@"UPDATE MagazineDetailList SET bookDetailJsonStr = ? WHERE bookId = ?",bean.bookDetailJsonStr,bean.bookId];
    }else{
        [g_db executeUpdate:@"INSERT INTO MagazineDetailList (bookId,bookDetailJsonStr) VALUES (?,?)",
                            bean.bookId,
                            bean.bookDetailJsonStr];
    }
}

//从数据库中查询出所有数据
-(NSMutableArray *)queryDataFromDB{
    NSMutableArray *resultArr = [[[NSMutableArray alloc] init] autorelease];
    [self initDB];
    FMResultSet *rs = [g_db executeQuery:@"select bookId,bookDetailJsonStr from MagazineDetailList "];
    while ([rs next]) {
        NSString *bookId = [rs stringForColumn:@"bookId"];
        NSString *bookDetailJsonStr = [rs stringForColumn:@"bookDetailJsonStr"];
        MagazineDetailBean *bean = [[[MagazineDetailBean alloc] init] autorelease];
        bean.bookId = bookId;
        bean.bookDetailJsonStr = bookDetailJsonStr;
        [resultArr addObject:bean];
    }
    return resultArr;
}

//根据id从数据库中查询出数据
-(MagazineDetailBean *)queryDataFromDBById:(NSString *)bookId{
    [self initDB];
    FMResultSet *rs = [g_db executeQuery:@"select bookDetailJsonStr from MagazineDetailList WHERE bookId = ?",bookId];
    MagazineDetailBean *bean = [[[MagazineDetailBean alloc] init] autorelease];
    while ([rs next]) {
        NSString *bookDetailJsonStr = [rs stringForColumn:@"bookDetailJsonStr"];
        bean.bookId = bookId;
        bean.bookDetailJsonStr = bookDetailJsonStr;
    }
    return bean;
}

//清除数据库中的数据
-(BOOL)eraseDBByBookId:(NSString *)bookId{
    [self initDB];
    BOOL result = [g_db executeUpdate:@"delete from MagazineDetailList where bookId=?",bookId];
    return result;
}





@end