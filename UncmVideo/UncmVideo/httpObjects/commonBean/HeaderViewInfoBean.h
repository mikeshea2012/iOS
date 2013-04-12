//
// Created by xinyingtiyu on 13-4-8.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface HeaderViewInfoBean : NSObject

@property (nonatomic) NSString *title;   //导航条中文
@property (nonatomic) NSString *leftBtnImgName; //左边按钮的图案
@property (nonatomic) NSString *rightBtnImgName; //左边按钮的图案

-(id)initWithTitle:(NSString *)temp_title
    leftBtnImgName:(NSString *)temp_leftBtnImgName
    leftBtnImgName:(NSString *)temp_rightBtnImgName
;

@end