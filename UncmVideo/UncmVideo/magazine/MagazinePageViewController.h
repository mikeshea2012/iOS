//
// Created by xinyingtiyu on 13-3-20.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface MagazinePageViewController : UIViewController  <NSURLConnectionDataDelegate>{
    int magazine_issueNo;//杂志期次
}
@property(nonatomic) NSString *magazineName;
@property(nonatomic) int magazine_issueNo;
@property(nonatomic,retain) NSString *serverBookId;
@end