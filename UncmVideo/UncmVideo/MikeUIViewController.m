//
// Created by xinyingtiyu on 13-3-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MikeUIViewController.h"
#import "SuperRequest.h"
#import "SuperResponse.h"
#import "AppDelegate.h"


@implementation MikeUIViewController {
    NSMutableData *receiveData;
    SuperResponse *g_response;
    SuperRequest *g_request;
//    NSURL *testUrl ;
}


#pragma mark - 进行http测试  以下都不需要关心
- (void)startHttpJsonPost:(SuperRequest *)req {
    NSString *jsonStr = req.getJsonStr;
    //第二步，创建请求
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *str_srvUrl = app.str_serviceUrl;
    NSURL *svcUrl = [NSURL URLWithString:str_srvUrl];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:svcUrl
                                                                 cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:10] autorelease];
    [request setHTTPMethod:@"POST"];
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    receiveData = [[NSMutableData alloc] init];
    [[[NSURLConnection alloc]initWithRequest:request delegate:self] autorelease];
}

- (SuperResponse *)paseHttpResponseStr:(NSString *)receiveStr {
    return [[[SuperResponse alloc] initWithJsonString:receiveStr] autorelease];
}

//接收到服务器回应的时候调用此方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [receiveData setLength: 0];
}

//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receiveData appendData:data];
}

-(void)printResponse:(NSString *)str{

}
//数据传完之后调用此方法
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *receiveStr = [[[NSString alloc] initWithData:receiveData encoding:NSUTF8StringEncoding] autorelease];
    [self printResponse:receiveStr];
}

//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError:%@", [error localizedDescription]);
}

- (void)dealloc {
    [receiveData release];
    [g_response release];
    [g_request release];
    [super dealloc];
}

@end