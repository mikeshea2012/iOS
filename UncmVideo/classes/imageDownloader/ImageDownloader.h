//
// Created by xinyingtiyu on 13-4-12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@protocol imageDownloaderDelegate;

@interface ImageDownloader : NSOperation
{
    NSURLRequest* _request;

    NSURLConnection* _connection;

    NSMutableData* _data;//请求的数据

    BOOL _isFinished;

    id<imageDownloaderDelegate> delegate;

    NSObject *delPara;//可携带额外的参数
}

- (id)initWithURLString:(NSString *)url;

@property (readonly) NSData *data;
@property(nonatomic, assign) id<imageDownloaderDelegate> delegate;
@property(nonatomic, retain) NSObject *delPara;

@end

@protocol imageDownloaderDelegate

@optional

//图片下载完成的代理方法
- (void)imageDidFinished:(UIImage *)image para:(NSObject *)obj;
- (void)imageDidErrorFinished:(UIImage *)image para:(NSObject *)obj;


@end