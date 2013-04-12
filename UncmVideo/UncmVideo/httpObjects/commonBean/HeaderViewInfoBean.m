//
// Created by xinyingtiyu on 13-4-8.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "HeaderViewInfoBean.h"


@implementation HeaderViewInfoBean

@synthesize title,leftBtnImgName,rightBtnImgName;

-(id)initWithTitle:(NSString *)temp_title
    leftBtnImgName:(NSString *)temp_leftBtnImgName
    leftBtnImgName:(NSString *)temp_rightBtnImgName
{
    [super init];
    self.title = temp_title;
    self.leftBtnImgName = temp_leftBtnImgName;
    self.rightBtnImgName = temp_rightBtnImgName;
    return self;

}


@end