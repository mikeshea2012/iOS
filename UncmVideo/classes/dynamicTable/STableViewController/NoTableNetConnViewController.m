//
// Created by xinyingtiyu on 13-4-10.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NoTableNetConnViewController.h"
#import "SuperRequest.h"
#import "AppDelegate.h"

@implementation NoTableNetConnViewController{
    NSMutableData *receiveData;
}


//显示联网状态
-(void)showActivity{
    UIActivityIndicatorView *indicatorView = [[[UIActivityIndicatorView alloc]
            initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    indicatorView.frame = CGRectMake(0, 0, 100, 100);
    indicatorView.center = self.view.center;
    [self.view addSubview:indicatorView];
    [indicatorView startAnimating];
    indicatorView.tag = 7180;
}
//停止联网状态
-(void)stopActivity{
    id view = [self.view viewWithTag:7180];
    if (nil == view){
        return;
    }
    UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)view;
    if (nil == indicatorView){
        return;
    }
    if ([indicatorView isAnimating]){
        [indicatorView stopAnimating];
    }
}

#pragma mark - 进行http 网络连接
- (void)startHttpJsonPost:(SuperRequest *)req {
    [self showActivity];//显示联网转圈
    NSString *jsonStr = req.getJsonStr;
    //第二步，创建请求
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *str_srvUrl = app.str_serviceUrl;
    NSURL *svcUrl = [NSURL URLWithString:str_srvUrl];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:svcUrl
                                                                 cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:20] autorelease];
    [request setHTTPMethod:@"POST"];
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    receiveData = [[NSMutableData alloc] init];
    [[[NSURLConnection alloc]initWithRequest:request delegate:self] autorelease];
}

//接收到服务器回应的时候调用此方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [receiveData setLength: 0];
}

//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receiveData appendData:data];
}

//数据传完之后调用此方法
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *receiveStr = [[[NSString alloc] initWithData:receiveData encoding:NSUTF8StringEncoding] autorelease];
    [self printResponse:receiveStr];
    [self stopActivity];//停止显示联网转圈
}

//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"FP_1:didFailWithError:%@", [error localizedDescription]);
    [self stopActivity];//停止显示联网转圈
    [self printError];
}

-(void)printError{

}

-(void)printResponse:(NSString *)receiveStr{

}

- (void) dealloc
{
    [receiveData release];
    [super dealloc];
}

@end