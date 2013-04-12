//
// Created by xinyingtiyu on 13-4-10.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class SuperRequest;


@interface NoTableNetConnViewController : UIViewController <NSURLConnectionDataDelegate>


#pragma mark - 进行http 网络连接
- (void)startHttpJsonPost:(SuperRequest *)req;
//接收到服务器回应的时候调用此方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
//数据传完之后调用此方法
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
-(void)printError;

-(void)printResponse:(NSString *)receiveStr;


@end