//
// Created by xinyingtiyu on 13-3-6.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


#import <Foundation/Foundation.h>

@interface Sort : NSObject {

}
//选择排序
- (void)selectSortWithArray:(NSArray *)aData;

//插入排序
- (void)insertSortWithArray:(NSArray *)aData;

//快速排序
- (void)quickSortWithArray:(NSArray *)aData;

- (void)swapWithData:(NSMutableArray *)aData index1:(NSUInteger)index1 index2:(NSInteger)index2;


@end