//
// Created by xinyingtiyu on 13-4-12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ImageDownloader.h"

@implementation ImageDownloader
@synthesize data=_data;
@synthesize delegate;
@synthesize delPara;

- (void)dealloc{
    [_request release];
    _request=nil;
    [_data release];
    _data=nil;
    [_connection release];
    _connection=nil;
    [delPara release];
    [super dealloc];
}

- (id)initWithURLString:(NSString *)url{
    self = [self init];
    if (self) {
        _request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
        _data = [[NSMutableData data] retain];
    }
    return self;
}

// 开始处理-本类的主方法
- (void)start {
    if (![self isCancelled]) {
        [NSThread sleepForTimeInterval:3];
        // 以异步方式处理事件，并设置代理
        _connection=[[NSURLConnection connectionWithRequest:_request delegate:self]retain];
        while(_connection != nil) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
    }
}

#pragma mark NSURLConnection delegate Method
// 接收到数据（增量）时
- (void)connection:(NSURLConnection*)connection
    didReceiveData:(NSData*)data{
    // 添加数据
    [_data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection {
    [_connection release];
    _connection=nil;
    NSLog(@"%s", __func__);
    UIImage *img = [[[UIImage alloc] initWithData:self.data] autorelease];
    if (self.delegate != nil){
        [delegate imageDidFinished:img para:self.delPara];
    }
}

-(void)connection: (NSURLConnection *) connection didFailWithError: (NSError *) error{
    [_connection release];
    _connection=nil;
    NSLog(@"%s", __func__);

    if (self.delegate != nil){
        [delegate imageDidErrorFinished:nil para:self.delPara];
    }
}

-(BOOL)isConcurrent{
    //返回yes表示支持异步调用，否则为支持同步调用
    return YES;
}
- (BOOL)isExecuting{
    return _connection == nil;
}
- (BOOL)isFinished{
    return _connection == nil;
}


@end