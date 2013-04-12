//
// Created by xinyingtiyu on 13-2-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "CommonHeadProtocol.h"
#import "STableViewController.h"
#import "ImageDownloader.h"

@class MPMoviePlayerController;

@interface FirstPageViewController : STableViewController <CommonHeadProtocol,imageDownloaderDelegate>


@end