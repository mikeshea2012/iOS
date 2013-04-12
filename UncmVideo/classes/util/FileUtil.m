//
// Created by xinyingtiyu on 13-3-31.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "FileUtil.h"
#import "People.h"
#import "MagazineBean.h"


@implementation FileUtil


+(BOOL)isFileExist:(NSString *)fileString{
    NSFileManager *fm = [[[NSFileManager alloc] init] autorelease];
    //判断是否mikefolder存在
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
            NSUserDomainMask, YES)lastObject];
    NSString *myFolder = [docs stringByAppendingPathComponent:@"mikeFolder"];
    BOOL exists = [fm fileExistsAtPath:myFolder];
    if(!exists){
        NSError *err = nil;
        [fm createDirectoryAtPath:myFolder withIntermediateDirectories:NO attributes:nil error:&err];
    }else{
        NSString *fullFileString = [myFolder stringByAppendingPathComponent:fileString];
        BOOL file_exists = [fm fileExistsAtPath:fullFileString];
        return file_exists;
    }
    return NO;

}
//将文件内容转换成MagazineBean
+(MagazineBean *)readMagazinBeanFromFile:(NSString *)fileString{
    NSFileManager *fm = [[[NSFileManager alloc] init] autorelease];
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
            NSUserDomainMask, YES)lastObject];
    NSString *myFolder = [docs stringByAppendingPathComponent:@"mikeFolder"];
    BOOL exists = [fm fileExistsAtPath:myFolder];
    if(!exists){
        NSError *err = nil;
        [fm createDirectoryAtPath:myFolder withIntermediateDirectories:NO attributes:nil error:&err];
    }
    NSString *fullFileString = [myFolder stringByAppendingPathComponent:fileString];
    MagazineBean *bean_read = [NSKeyedUnarchiver unarchiveObjectWithData:[self getDataFromFile:fullFileString]];
    return bean_read;
}


//将bean写入文件
+(void)writeBeanToFile:(id)obj andFileString:(NSString *)fileString{
    NSFileManager *fm = [[[NSFileManager alloc] init] autorelease];
    //判断是否mikefolder存在
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
            NSUserDomainMask, YES)lastObject];
    NSString *myFolder = [docs stringByAppendingPathComponent:@"mikeFolder"];
    BOOL exists = [fm fileExistsAtPath:myFolder];
    if(!exists){
        NSError *err = nil;
        [fm createDirectoryAtPath:myFolder withIntermediateDirectories:NO attributes:nil error:&err];
    }
    NSString *fullFileString = [myFolder stringByAppendingPathComponent:fileString];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    [data writeToFile:fullFileString atomically:NO];
}

//将文件内容转换成PeopleBean
+(People *)readPeopleBeanFromFile:(NSString *)fileString{
    People *people_read = [NSKeyedUnarchiver unarchiveObjectWithData:[self getDataFromFile:fileString]];
    return people_read;
}

+(NSData *)getDataFromFile:(NSString *)fileString{
    NSFileManager *fm = [[[NSFileManager alloc] init] autorelease];
    //判断是否mikefolder存在
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
            NSUserDomainMask, YES)lastObject];
    NSString *myFolder = [docs stringByAppendingPathComponent:@"mikeFolder"];
    BOOL exists = [fm fileExistsAtPath:myFolder];
    if(!exists){
        NSError *err = nil;
        [fm createDirectoryAtPath:myFolder withIntermediateDirectories:NO attributes:nil error:&err];
    }
    //读取文件
    NSString *fullFileString = [myFolder stringByAppendingPathComponent:fileString];
    NSData *readData = [[[NSData alloc] initWithContentsOfFile:fullFileString] autorelease];
    return readData;
}

//将图片保存到文件之中
+(BOOL)writeImageData:(NSData *)imgData ToFileWithName:(NSString *)fileName{
    NSFileManager *fm = [[[NSFileManager alloc] init] autorelease];
    //判断是否mikefolder存在
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
            NSUserDomainMask, YES)lastObject];
    NSString *myFolder = [docs stringByAppendingPathComponent:@"mikeFolder"];
    BOOL exists = [fm fileExistsAtPath:myFolder];
    if(!exists){
        NSError *err = nil;
        [fm createDirectoryAtPath:myFolder withIntermediateDirectories:NO attributes:nil error:&err];
    }
    NSString *fullFileString = [myFolder stringByAppendingPathComponent:fileName];
    return [imgData writeToFile:fullFileString atomically:NO];
}
//从文件系统中获取图片
+(UIImage *)loadImgDateFromFile:(NSString *)fileName{
    NSFileManager *fm = [[[NSFileManager alloc] init] autorelease];
    //判断是否mikefolder存在
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
            NSUserDomainMask, YES)lastObject];
    NSString *myFolder = [docs stringByAppendingPathComponent:@"mikeFolder"];
    BOOL exists = [fm fileExistsAtPath:myFolder];
    if(!exists){
        NSError *err = nil;
        [fm createDirectoryAtPath:myFolder withIntermediateDirectories:NO attributes:nil error:&err];
    }
    NSString *fullFileString = [myFolder stringByAppendingPathComponent:fileName];
    exists = [fm fileExistsAtPath:fullFileString];
    if(!exists){
       return nil;
    }
    NSData *imgData = [NSData dataWithContentsOfFile:fullFileString];
    UIImage *img = [[[UIImage alloc] initWithData:imgData] autorelease];
    return img;
}



@end