//
// Created by xinyingtiyu on 13-3-4.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

#import "ObjView.h"

@class MagazinePageViewController;


@interface MagazineViewController : UIViewController  <NSURLConnectionDataDelegate>  {
    float first_touch_Y;
    ObjView *view_1, *view_2, *view_3, *view_4, *view_5;
    NSMutableArray *g_items;
    int g_secondFromIndex;
    //第二条记录与顶部的距离
    int g_recordHeight;
    //每条记录的高度
    int g_totalNumber;
    //总记录数
    CGFloat middlePointY;
    CGPoint locP;
    int last_middleIndex;
//    int g_two_center_y_space;//相邻两条记录center的y值之差
    CGFloat g_bottomY;//底部的y坐标
}
@property int g_secondFromIndex;
@property int g_recordHeight;
@property int g_totalNumber;

@end