//
// Created by xinyingtiyu on 13-3-4.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import <QuartzCore/QuartzCore.h>
#import "ObjView.h"
#import "DeltaInfo.h"
#import "MagazineViewController.h"


@implementation ObjView

@synthesize locP;
@synthesize centerP;
@synthesize viewIndex;

@synthesize userImageView = _userImageView, descTextView = _descTextView, titleLabel = _titleLabel;

- (id)init {

    self = [super init];
    if (self) {
        self.layer.cornerRadius = 5;
        [self setBackgroundColor:RGBACOLOR(206, 207, 207, 1)];
//
        _userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, 102, 134)];
        [_userImageView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_userImageView];
        //杂志标题
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(122, 20, 174, 14)];
        [_titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        [_titleLabel setContentMode:UIViewContentModeCenter];
        [_titleLabel setTextAlignment:(NSTextAlignment) UITextAlignmentLeft];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_titleLabel];
        //杂志内容
        UILabel *uiTextView = [[UILabel alloc] initWithFrame:CGRectMake(112, 50, 172, 88)];
        uiTextView.numberOfLines = 5;
        uiTextView.backgroundColor = [UIColor clearColor];
        uiTextView.textColor = [UIColor blackColor];
        uiTextView.font = [UIFont fontWithName:@"Helvetica" size:12];
        _descTextView = uiTextView;

        [self addSubview:_descTextView];
    }
    return self;
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    self->locP = [[touches anyObject] locationInView:self.superview];
//    self->centerP = self.center;
//
//}

//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    CGPoint loc = [[touches anyObject] locationInView:self.superview];
//    CGFloat deltaY = loc.y - self->locP.y;
//
//    CGPoint c = self.center;
//    c.x = self->centerP.x;
//    c.y = self->centerP.y + deltaY;
//    MagazineViewController *mag = [[[MagazineViewController alloc] init] autorelease];
//    int fixHeight = (mag.g_totalNumber-1) * mag.g_secondFromIndex + mag.g_recordHeight;
//    if (c.y > fixHeight){
//        c.y = c.y -fixHeight;
//        [self.superview sendSubviewToBack:self];
//    }
//    if (c.y < 0){
//        c.y = fixHeight + c.y;
//        [self.superview sendSubviewToBack:self];
//    }
//    self.center = c;
//
//    self->locP = [[touches anyObject] locationInView:self.superview];
//    self->centerP = self.center;
//    [self doAnimationWithY:self.center.y];//todo attention
//
//    DeltaInfo *deltaInfo = [[[DeltaInfo alloc] init] autorelease];
//    deltaInfo.deltaY = deltaY;
//    deltaInfo.viewIndex = viewIndex;
//
//
//    [[[NSString alloc] initWithFormat:@"%d", viewIndex] autorelease];
//    NSDictionary *dic = [NSDictionary dictionaryWithObject:deltaInfo
//                                                    forKey:@"testkey"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"someViewDidMoved"
//                                                        object:self
//                                                      userInfo:dic];
//}

- (void)receivingMethodOnListener:(NSNotification *)notification {
    DeltaInfo *obj = (DeltaInfo *) [[notification userInfo] objectForKey:@"testkey"];
    MagazineViewController *mag = [[[MagazineViewController alloc] init] autorelease];
    int fixHeight = (mag.g_totalNumber - 1) * mag.g_secondFromIndex + mag.g_recordHeight;
    if (obj.viewIndex != viewIndex) { //别人的原因，需要自己进行容错并同步
        CGPoint c = self.center;
        c.y = c.y + obj.deltaY;
        if (c.y > fixHeight) {
            c.y = c.y - fixHeight;
            [self.superview sendSubviewToBack:self];
        }
        if (c.y < 0) {
            c.y = fixHeight + c.y;
            [self.superview sendSubviewToBack:self];
        }
        self.center = c;
        self->centerP = self.center;
        [self doAnimationWithY:self.center.y]; //todo attention
        [self.superview sendSubviewToBack:self];
    }
}

- (void)doAnimationWithY:(float)y { //todo attention

    if (abs((int) (y - 231.0)) >= 0 && abs((int) (y - 231.0)) <= 10) {
        MagazineViewController *controller = [[[MagazineViewController alloc] init] autorelease];
        [self.superview bringSubviewToFront:self];
    }

    float speed = 0.4;
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:speed];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationBeginsFromCurrentState:YES];
    float f_alpha = 1 - abs((int) (y - 231.0)) * 0.15 / 80.0; //透明度计算公式
    float f_rate = 1 - abs((int) (y - 231.0)) * 0.20 / 80.0; //缩放比计算公式

    self.alpha = f_alpha;
    self.layer.transform = CATransform3DMakeScale(f_rate, f_rate, 1);

    [UIView commitAnimations];
}


- (void)dealloc {
    [_userImageView release];
    [_descTextView release];
    [_titleLabel release];
    [super dealloc];
}

@end