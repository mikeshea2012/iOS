//
// Created by xinyingtiyu on 13-4-10.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UserCenterView.h"
#import "AboutUsViewController.h"
#import "AppDelegate.h"
#import "ResponseViewController.h"


@implementation UserCenterView


#pragma mark 初始化部分
- (id)initWithFrame:(CGRect)frame {
    [super initWithFrame:frame];
    UITableView *tableView = [[[UITableView alloc] initWithFrame:frame] autorelease];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    UIImageView *bgView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)] autorelease];
    bgView.center = tableView.center;
    bgView.image = [UIImage imageNamed:@"bg_usercenter.png"];
    tableView.backgroundView = bgView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self = (id) tableView;
    return self;
}



#pragma mark 表格部分
//点击某行记录会触发的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int row = indexPath.row;
    UIViewController *controller = nil;

    if (row == 0) {
        //清除缓存
        NSLog(@"清除缓存...");
        [self UserCenter_showAlertWithTitle:@"提示:" message:@"清除缓存成功"];
    }
    if (row == 1) {
        //关于我们
        controller = [[[AboutUsViewController alloc]
                initWithNibName:@"AboutUsViewController" bundle:nil] autorelease];
        ((AboutUsViewController *)controller).fromStr = @"关于我们";
    }
    if (row == 2) {
        //意见反馈
        controller = [[[ResponseViewController alloc]
                initWithNibName:@"ResponseViewController" bundle:nil] autorelease];
        ((ResponseViewController *)controller).fromString = @"意见反馈";
    }
    if (row == 3) {
        //给我评分
    }
    if (row == 4) {
        //版本更新
    }
    if (controller != nil) {
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app.nav pushViewController:controller animated:YES];
    }

}


//弹出提示信息
- (void)UserCenter_showAlertWithTitle:(NSString *)title
                   message:(NSString *)msg{
    UIAlertView *promptAlert = [[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:nil] autorelease];
    [NSTimer scheduledTimerWithTimeInterval:0.5f
                                     target:self
                                   selector:@selector(UserCenter_timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:NO];
    [promptAlert show];
}
//提示信息的定时消失机制
- (void)UserCenter_timerFireMethod:(NSTimer*)theTimer{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:@"BaseCell"] autorelease];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:@"BaseCell"] autorelease];
    }
    cell.selectionStyle = (UITableViewCellSelectionStyle) UITableViewCellSeparatorStyleNone;
    int row = indexPath.row;
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(13, 16, 100, 25)] autorelease];
    if (row == 0) {
        label.text = @"清除缓存";
    }
    if (row == 1) {
        label.text = @"关于我们";
    }
    if (row == 2) {
        label.text = @"意见反馈";
    }
    if (row == 3) {
        label.text = @"给我评分";
    }
    if (row == 4) {
        label.text = @"版本更新";
    }

    [label setFont:[UIFont systemFontOfSize:20]]; //字体
    label.textColor = RGBACOLOR(41, 41, 41, 1);
    label.textAlignment = (NSTextAlignment) UITextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    [cell addSubview:label];
    UIImage *img = [UIImage imageNamed:@"arrow_usercenter.png"];
    UIImageView *imgView = [[[UIImageView alloc] initWithImage:img] autorelease];
    imgView.frame = CGRectMake(280, 21, 10, 16);
    [cell addSubview:imgView];
    if (row != 4) {
        img = [UIImage imageNamed:@"filter_usercenter.png"];
        imgView = [[[UIImageView alloc] initWithImage:img] autorelease];
        imgView.frame = CGRectMake(14, 50, 275, 2);
        [cell addSubview:imgView];
    }
    return cell;
}



@end