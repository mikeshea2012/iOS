//
// Created by xinyingtiyu on 13-3-4.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface DeltaInfo : NSObject {
    CGFloat deltaY;
    //y方向上的位移
    int viewIndex; //被移动的view的index值
}
@property CGFloat deltaY;
@property int viewIndex;

@end