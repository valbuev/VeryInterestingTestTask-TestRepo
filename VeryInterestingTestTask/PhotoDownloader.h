//
//  PhotoDownloader.h
//  VeryInterestingTestTask
//
//  Created by Valeriy Buev on 28.05.14.
//  Copyright (c) 2014 bva. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PhotoDownloaderDelegate <NSObject>

-(void) setNetworkIndicatorVisible: (Boolean) visible;

-(void) PhotoDownloaderDidFinishedDownload: (NSString *) filePath forObject:(NSObject *) object;

@end

@interface PhotoDownloader : NSObject
< NSURLConnectionDataDelegate>{
    NSString *url_str;
    NSObject *managedObject;
    NSString *filePath;
    NSFileHandle *file;
    NSURLConnection *theConnection;
}

@property (nonatomic,retain) id<PhotoDownloaderDelegate> delegate;

- (void) startDownloadFromURL: (NSString *) _url_str withManagedObject: (NSObject *) object;

@end
