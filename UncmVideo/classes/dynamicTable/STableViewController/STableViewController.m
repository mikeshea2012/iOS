//
// STableViewController.m
//
// @author Shiki
//

#import "STableViewController.h"
#import "SuperRequest.h"
#import "AppDelegate.h"
#import "DemoTableHeaderView.h"
#define DEFAULT_HEIGHT_OFFSET 52.0f

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation STableViewController{
    NSMutableData *receiveData;
}

@synthesize tableView;
@synthesize headerView;
@synthesize footerView;

@synthesize isDragging;
@synthesize isRefreshing;
@synthesize isLoadingMore;

@synthesize canLoadMore;

@synthesize pullToRefreshEnabled;

@synthesize clearsSelectionOnViewWillAppear;

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) initialize
{
  pullToRefreshEnabled = YES;
  
  canLoadMore = YES;
  
  clearsSelectionOnViewWillAppear = YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id) init
{
  if ((self = [super init]))
    [self initialize];  
  return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id) initWithCoder:(NSCoder *)aDecoder
{
  if ((self = [super initWithCoder:aDecoder]))
    [self initialize];
  return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) viewDidLoad
{
  [super viewDidLoad];
  
  self.tableView = [[[UITableView alloc] init] autorelease];
  tableView.frame = self.view.bounds;
  tableView.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  tableView.dataSource = self;
  tableView.delegate = self;
  
  [self.view addSubview:tableView];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  if (clearsSelectionOnViewWillAppear) {
    NSIndexPath *selected = [self.tableView indexPathForSelectedRow];
    if (selected)
      [self.tableView deselectRowAtIndexPath:selected animated:animated];
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Pull to Refresh

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setHeaderView:(UIView *)aView
{
  if (!tableView)
    return;
  
  if (headerView && [headerView isDescendantOfView:tableView])
    [headerView removeFromSuperview];
  [headerView release]; headerView = nil;
  
  if (aView) {
    headerView = [aView retain];
    
    CGRect f = headerView.frame;
    headerView.frame = CGRectMake(f.origin.x, 0 - f.size.height, f.size.width, f.size.height);
    headerViewFrame = headerView.frame;
    
    [tableView addSubview:headerView];
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat) headerRefreshHeight
{
  if (!CGRectIsEmpty(headerViewFrame))
    return headerViewFrame.size.height;
  else
    return DEFAULT_HEIGHT_OFFSET;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) pinHeaderView
{
  [UIView animateWithDuration:0.3 animations:^(void) {
    self.tableView.contentInset = UIEdgeInsetsMake([self headerRefreshHeight], 0, 0, 0);
  }];

    DemoTableHeaderView *hv = (DemoTableHeaderView *) self.headerView;
    [hv.activityIndicator startAnimating];
    hv.title.text = @"页面刷新中...";
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) unpinHeaderView
{
  [UIView animateWithDuration:0.3 animations:^(void) {
    self.tableView.contentInset = UIEdgeInsetsZero;
  }];
    // do custom handling for the header view
    [[(DemoTableHeaderView *) self.headerView activityIndicator] stopAnimating];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) willBeginRefresh
{ 
  if (pullToRefreshEnabled)
    [self pinHeaderView];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) willShowHeaderView:(UIScrollView *)scrollView
{
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) headerViewDidScroll:(BOOL)willRefreshOnRelease scrollView:(UIScrollView *)scrollView
{
    DemoTableHeaderView *hv = (DemoTableHeaderView *) self.headerView;
    if (willRefreshOnRelease) {
        hv.title.text = @"释放后刷新...";
    } else {
        hv.title.text = @"下拉可刷新...";
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL) refresh
{
  if (isRefreshing)
    return NO;

  
  [self willBeginRefresh];
  isRefreshing = YES;

    [self performSelector:@selector(addItemsOnTop) withObject:nil afterDelay:2.0];
    // See -addItemsOnTop for more info on how to finish loading
    return YES;
}

-(void)addItemsOnTop{

}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) refreshCompleted
{
  isRefreshing = NO;
  
  if (pullToRefreshEnabled)
    [self unpinHeaderView];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Load More

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setFooterView:(UIView *)aView
{
  if (!tableView)
    return;
  
  tableView.tableFooterView = nil;
  [footerView release]; footerView = nil;
  
  if (aView) {
    footerView = [aView retain];
    
    tableView.tableFooterView = footerView;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) willBeginLoadingMore
{
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) loadMoreCompleted
{
  isLoadingMore = NO;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL) loadMore
{
  if (isLoadingMore)
    return NO;
  
  [self willBeginLoadingMore];
  isLoadingMore = YES;  
  return YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat) footerLoadMoreHeight
{
  if (footerView)
    return footerView.frame.size.height;
  else
    return DEFAULT_HEIGHT_OFFSET;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setFooterViewVisibility:(BOOL)visible
{
  if (visible && self.tableView.tableFooterView != footerView)
    self.tableView.tableFooterView = footerView;
  else if (!visible)
    self.tableView.tableFooterView = nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) allLoadingCompleted
{
  if (isRefreshing)
    [self refreshCompleted];
  if (isLoadingMore)
    [self loadMoreCompleted];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIScrollViewDelegate

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
  if (isRefreshing)
    return;
  isDragging = YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
  if (!isRefreshing && isDragging && scrollView.contentOffset.y < 0) {
    [self headerViewDidScroll:scrollView.contentOffset.y < 0 - [self headerRefreshHeight] 
                   scrollView:scrollView];
  } else if (!isLoadingMore && canLoadMore) {
    CGFloat scrollPosition = scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y;
    if (scrollPosition < [self footerLoadMoreHeight]) {
      [self loadMore];
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
  if (isRefreshing)
    return;
  
  isDragging = NO;
  if (scrollView.contentOffset.y <= 0 - [self headerRefreshHeight]) {
    if (pullToRefreshEnabled)
      [self refresh];
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) releaseViewComponents
{
  [headerView release]; headerView = nil;
  [footerView release]; footerView = nil;
  [tableView release]; tableView = nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc
{
  [receiveData release];
  [self releaseViewComponents];
  [super dealloc];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) viewDidUnload
{
  [self releaseViewComponents];
  [super viewDidUnload];
}

//显示联网状态
-(void)showActivity{
    id view = [self.view viewWithTag:7180];
    if (nil != view){
        UIActivityIndicatorView *indicatorView =
                (UIActivityIndicatorView *)view;
        [indicatorView startAnimating];
    }else{
        UIActivityIndicatorView *indicatorView = [[[UIActivityIndicatorView alloc]
                initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
        indicatorView.frame = CGRectMake(0, 0, 100, 100);
        indicatorView.center = self.view.center;
        [self.view addSubview:indicatorView];
        [indicatorView startAnimating];
        indicatorView.tag = 7180;
    }
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

@end
