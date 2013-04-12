//
// Created by xinyingtiyu on 13-3-31.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class People;
@class MagazineBean;


@interface FileUtil : NSObject
+(BOOL)isFileExist:(NSString *)fileString;
//将Bean写入文件
+(void)writeBeanToFile:(id)obj andFileString:(NSString *)fileString;
//将文件内容转换成PeopleBean
+(People *)readPeopleBeanFromFile:(NSString *)fileString;
//将文件内容转换成MagazineBean
+(MagazineBean *)readMagazinBeanFromFile:(NSString *)fileString;

//将图片保存到文件之中
+(BOOL)writeImageData:(NSData *)imgData ToFileWithName:(NSString *)fileName;
//从文件系统中获取图片
+(UIImage *)loadImgDateFromFile:(NSString *)fileName;


@end