//
// Created by xinyingtiyu on 13-4-7.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@protocol CommonHeadProtocol;
@class HeaderViewInfoBean;


@interface CommonHeaderView : UIView {
    id<CommonHeadProtocol> delegate;
}
@property (retain) id<CommonHeadProtocol> delegate;

-(void)setNavi:(HeaderViewInfoBean *)bean;
-(id)initWitHighlightIndex:(int)highlightIndex;
@end