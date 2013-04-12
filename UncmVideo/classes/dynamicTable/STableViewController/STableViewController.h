//
// STableViewController.h
//  
// @author Shiki
//

#import <UIKit/UIKit.h>

@class SuperRequest;


@interface STableViewController : UIViewController <NSURLConnectionDataDelegate,UITableViewDelegate, UITableViewDataSource> {
  
@protected
  
  BOOL isDragging;
  BOOL isRefreshing;
  BOOL isLoadingMore;
  
  // had to store this because the headerView's frame seems to be changed somewhere during scrolling
  // and I couldn't figure out why >.<
  CGRect headerViewFrame;
}

// The view used for "pull to refresh"
@property (nonatomic, retain) UIView *headerView;

// The view used for "load more"
@property (nonatomic, retain) UIView *footerView;

@property (nonatomic, retain) UITableView *tableView;
@property (readonly) BOOL isDragging;
@property (readonly) BOOL isRefreshing;
@property (readonly) BOOL isLoadingMore;
@property (nonatomic) BOOL canLoadMore;

@property (nonatomic) BOOL pullToRefreshEnabled;

// Defaults to YES
@property (nonatomic) BOOL clearsSelectionOnViewWillAppear;

// Just a common initialize method
- (void) initialize;

#pragma mark - Pull to Refresh

// The minimum height that the user should drag down in order to trigger a "refresh" when
// dragging ends. 
- (CGFloat) headerRefreshHeight;

// Will be called if the user drags down which will show the header view. Override this to
// update the header view (e.g. change the label to "Pull down to refresh").
- (void) willShowHeaderView:(UIScrollView *)scrollView;

// If the user is dragging, will be called on every scroll event that the headerView is shown. 
// The value of willRefreshOnRelease will be YES if the user scrolled down enough to trigger a 
// "refresh" when the user releases the drag.
- (void) headerViewDidScroll:(BOOL)willRefreshOnRelease scrollView:(UIScrollView *)scrollView;

// By default, will permanently show the headerView by setting the tableView's contentInset.
- (void) pinHeaderView;

// Reverse of pinHeaderView. 
- (void) unpinHeaderView;

// Called when the user stops dragging and, if the conditions are met, will trigger a refresh.
- (void) willBeginRefresh;

// Override to perform fetching of data. The parent method [super refresh] should be called first.
// If the value is NO, -refresh should be aborted.
- (BOOL) refresh;
-(void)addItemsOnTop;//从头部刷新
// Call to signal that refresh has completed. This will then hide the headerView.
- (void) refreshCompleted;

#pragma mark - Load More

// The value of the height starting from the bottom that the user needs to scroll down to in order
// to trigger -loadMore. By default, this will be the height of -footerView.
- (CGFloat) footerLoadMoreHeight;

// Override to perform fetching of next page of data. It's important to call and get the value of
// of [super loadMore] first. If it's NO, -loadMore should be aborted.
- (BOOL) loadMore;

// Called when all the conditions are met and -loadMore will begin.
- (void) willBeginLoadingMore;

// Call to signal that "load more" was completed. This should be called so -isLoadingMore is
// properly set to NO.
- (void) loadMoreCompleted;

// Helper to show/hide -footerView
- (void) setFooterViewVisibility:(BOOL)visible;

#pragma mark - 

// A helper method that calls refreshCompleted and/or loadMoreCompleted if any are active.
- (void) allLoadingCompleted;

#pragma mark - 

- (void) releaseViewComponents;

#pragma mark 加上进度圈

//显示联网状态
-(void)showActivity;
//停止联网状态
-(void)stopActivity;


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
