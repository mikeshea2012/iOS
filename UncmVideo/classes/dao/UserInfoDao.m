//
// Created by xinyingtiyu on 13-4-10.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UserInfoDao.h"
#import "UserInfo.h"
#import "FMResultSet.h"
#import "FMDatabase.h"

@implementation UserInfoDao {
    FMDatabase *g_db;
}

//确保数据库对象及表存在
-(void)initDB{
    if (g_db == nil){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"userinfo.db"];
        g_db = [FMDatabase databaseWithPath:dbPath];
    }
    [g_db open];
    BOOL isTableExist = NO;
    FMResultSet *rs = [g_db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", @"userinfo"];
    while ([rs next]) {
        NSInteger count = [rs intForColumn:@"count"];
        if (0 != count){
            isTableExist = YES;
        }
    }
    if (!isTableExist) {
        [g_db executeUpdate:@"CREATE TABLE userinfo (phone text,passwd text)"];
    }
}

//将bean插入或者更新到表中
- (void)updateOrInsertTable:(UserInfo *)bean {
    [self initDB];
    FMResultSet *rs = [g_db executeQuery:@"select count(*) as 'count' from userinfo "
                                                 " where phone = ?", bean.phone];
    BOOL isBeanExist = NO;
    while ([rs next]) {
        NSInteger count = [rs intForColumn:@"count"];
        if (0 != count){
            isBeanExist = YES;
        }
    }
    [rs close];
    if (isBeanExist){
        [g_db executeUpdate:@"UPDATE userinfo SET phone = ?, passwd = ? WHERE phone = ?",
                            bean.phone,
                            bean.passwd,
                            bean.phone
        ];
    }else{
        [g_db executeUpdate:@"INSERT INTO userinfo (phone,passwd) VALUES (?,?)",
                            bean.phone,
                            bean.passwd
        ];
        [rs close];
    }
}

//从数据库中查询出所有数据
-(NSMutableArray *)queryDataFromDB{
    NSMutableArray *resultArr = [[[NSMutableArray alloc] init] autorelease];
    [self initDB];
    FMResultSet *rs = [g_db executeQuery:@"select phone,passwd from userinfo "];
    while ([rs next]) {
        NSString *phone = [rs stringForColumn:@"phone"];
        NSString *passwd = [rs stringForColumn:@"passwd"];
        UserInfo *bean = [[[UserInfo alloc] init] autorelease];
        bean.phone = phone;
        bean.passwd = passwd;
        [resultArr addObject:bean];
    }
    return resultArr;
}

//根据 phone 从数据库中查询出数据
-(UserInfo *)queryDataFromDBById:(NSString *)str_phone{
    [self initDB];
    FMResultSet *rs = [g_db executeQuery:@"select phone,passwd from userinfo WHERE phone = ?",str_phone];
    UserInfo *bean = [[[UserInfo alloc] init] autorelease];
    while ([rs next]) {
        NSString *phone = [rs stringForColumn:@"phone"];
        NSString *passwd = [rs stringForColumn:@"passwd"];
        bean.phone = phone;
        bean.passwd = passwd;
    }
    return bean;
}

//清除数据库中的数据
-(BOOL)eraseDBByTableName{
    [self initDB];
    BOOL result = [g_db executeUpdate:@"delete from userinfo"];
    return result;
}




@end