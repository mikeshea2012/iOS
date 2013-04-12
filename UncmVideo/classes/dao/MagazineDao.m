//
// Created by xinyingtiyu on 13-4-2.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MagazineDao.h"
#import "FMResultSet.h"
#import "FMDatabase.h"
#import "MagazineBean.h"


@implementation MagazineDao{
    FMDatabase *g_db;
}

//确保数据库对象及表存在
-(void)initDB{
    if (g_db == nil){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"magazinelist.db"];
        g_db = [FMDatabase databaseWithPath:dbPath];
    }
    [g_db open];
    BOOL isTableExist = NO;
    FMResultSet *rs = [g_db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", @"MagazineList"];
    while ([rs next]) {
        NSInteger count = [rs intForColumn:@"count"];
        if (0 != count){
            isTableExist = YES;
        }
    }
    if (!isTableExist) {
        [g_db executeUpdate:@"CREATE TABLE MagazineList (Id integer,Title text,Desc text,CoverUrl text,ServerBookId text)"];
    }
}

//将bean插入或者更新到表中
- (void)updateOrInsertTable:(MagazineBean *)bean {
    [self initDB];
    FMResultSet *rs = [g_db executeQuery:@"select count(*) as 'count' from MagazineList "
                                                 " where Id = ?", bean.numBookId];
    BOOL isBeanExist = NO;
    while ([rs next]) {
        NSInteger count = [rs intForColumn:@"count"];
        if (0 != count){
            isBeanExist = YES;
        }
    }
    [rs close];
    if (isBeanExist){
        [g_db executeUpdate:@"UPDATE MagazineList SET Title = ?, Desc = ?, CoverUrl = ?,ServerBookId=? WHERE Id = ?",
                            bean.vc2BookName,
                            bean.vc2Desc,
                            bean.vc2CoverUrl,
                            bean.numServerBookId,
                            bean.numBookId

        ];
    }else{
        [g_db executeUpdate:@"INSERT INTO MagazineList (Id,Title,Desc,CoverUrl,ServerBookId) VALUES (?,?,?,?,?)",
                        [NSNumber numberWithInt:[bean.numBookId intValue]],
                            bean.vc2BookName,
                            bean.vc2Desc,
                            bean.vc2CoverUrl,
                            bean.numServerBookId

        ];
        [rs close];
    }
}

//从数据库中查询出所有数据
-(NSMutableArray *)queryDataFromDB{
    NSMutableArray *resultArr = [[[NSMutableArray alloc] init] autorelease];
    [self initDB];
    FMResultSet *rs = [g_db executeQuery:@"select Id , Title , Desc ,  CoverUrl,ServerBookId from MagazineList "];
    while ([rs next]) {
        NSInteger Id = [rs intForColumn:@"Id"];
        NSString *Title = [rs stringForColumn:@"Title"];
        NSString *Desc = [rs stringForColumn:@"Desc"];
        NSString *CoverUrl = [rs stringForColumn:@"CoverUrl"];
        NSString *ServerBookId = [rs stringForColumn:@"ServerBookId"];
        MagazineBean *bean = [[[MagazineBean alloc] init] autorelease];
        bean.numBookId = [[NSString alloc] initWithFormat:@"%d",Id];
        bean.vc2BookName = Title;
        bean.vc2Desc = Desc;
        bean.vc2CoverUrl = CoverUrl;
        bean.numServerBookId = ServerBookId;
        [resultArr addObject:bean];
    }
    return resultArr;
}

//根据id从数据库中查询出数据
-(MagazineBean *)queryDataFromDBById:(NSString *)id{
    NSMutableArray *resultArr = [[[NSMutableArray alloc] init] autorelease];
    [self initDB];
    FMResultSet *rs = [g_db executeQuery:@"select Id , Title , Desc ,  CoverUrl,ServerBookId from MagazineList WHERE Id = ?",id];
    MagazineBean *bean = nil;
    while ([rs next]) {
        NSInteger Id = [rs intForColumn:@"Id"];
        NSString *Title = [rs stringForColumn:@"Title"];
        NSString *Desc = [rs stringForColumn:@"Desc"];
        NSString *CoverUrl = [rs stringForColumn:@"CoverUrl"];
        NSString *ServerBookId = [rs stringForColumn:@"ServerBookId"];
        bean = [[[MagazineBean alloc] init] autorelease];
        bean.numBookId = [[NSString alloc] initWithFormat:@"%d",Id];
        bean.vc2BookName = Title;
        bean.vc2Desc = Desc;
        bean.vc2CoverUrl = CoverUrl;
        bean.numServerBookId = ServerBookId;
        [resultArr addObject:bean];
    }
    return bean;
}

//清除数据库中的数据
-(BOOL)eraseDBByTableName{
    [self initDB];
    BOOL result = [g_db executeUpdate:@"delete from MagazineList"];
    return result;
}





@end