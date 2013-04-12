//
// Created by xinyingtiyu on 13-3-4.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface ObjView : UIView {
    CGPoint locP, centerP;
    int boxview_index;
    UIImageView *_userImageView;
    UILabel *_descTextView;
    UILabel *_titleLabel;
    int boxview_seq;
}
@property(nonatomic, retain) UIImageView *userImageView;
@property(nonatomic, retain) UILabel *descTextView;
@property(nonatomic, retain) UILabel *titleLabel;
@property(nonatomic) int boxview_index;
@property int boxview_seq;
@property int viewIndex;
@property CGPoint locP;
@property CGPoint centerP;
@end