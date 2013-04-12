//
// Created by xinyingtiyu on 13-2-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "VideoRecordView.h"


@implementation VideoRecordView
- (id)init {

    self = [super init];
    if (self) {
        // Initialization code.
        [self setBackgroundColor:RGBACOLOR(206, 207, 207, 1)];
        //时间
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 14)];
        [_timeLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        [_timeLabel setTextAlignment:(NSTextAlignment) UITextAlignmentLeft];
        [_timeLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_timeLabel];
        //主队图标
        _homeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(84, 6, 25, 25)];
        _homeImageView.image = [UIImage imageNamed:@"1001.png"];
        [_homeImageView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_homeImageView];
        //主队名称
        _homeTeamNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(114, 10, 40, 14)];
        [_homeTeamNameLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        [_homeTeamNameLabel setTextAlignment:(NSTextAlignment) UITextAlignmentLeft];
        [_homeTeamNameLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_homeTeamNameLabel];
        //vs
        _vsLabel = [[UILabel alloc] initWithFrame:CGRectMake(144, 12, 40, 12)];
        [_vsLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        [_vsLabel setTextAlignment:(NSTextAlignment) UITextAlignmentLeft];
        [_vsLabel setBackgroundColor:[UIColor clearColor]];
        _vsLabel.text = @"vs";
        [self addSubview:_vsLabel];
        //客队名称
        _guestTeamNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(162, 10, 40, 14)];
        [_guestTeamNameLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        [_guestTeamNameLabel setTextAlignment:(NSTextAlignment) UITextAlignmentLeft];
        [_guestTeamNameLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_guestTeamNameLabel];
        //客队图标
        _guestImageView = [[UIImageView alloc] initWithFrame:CGRectMake(84, 6, 25, 25)];
        _guestImageView.image = [UIImage imageNamed:@"1002.png"];
        [_guestImageView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_guestImageView];
        //status
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(246, 10, 40, 14)];
        [_statusLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        [_statusLabel setTextAlignment:(NSTextAlignment) UITextAlignmentLeft];
        [_statusLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_statusLabel];
        //desc
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(246, 10, 40, 14)];
        [_descLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        [_descLabel setTextAlignment:(NSTextAlignment) UITextAlignmentLeft];
        [_descLabel setBackgroundColor:[UIColor clearColor]];
        [_descLabel setNumberOfLines:2];
        [self addSubview:_descLabel];

    }
    return self;
}

- (void)dealloc {
    [_timeLabel release];
    [_homeImageView release];
    [_homeTeamNameLabel release];
    [_vsLabel release];
    [_guestTeamNameLabel release];
    [_guestImageView release];
    [_statusLabel release];
    [_descLabel release];
    [super dealloc];
}


@end