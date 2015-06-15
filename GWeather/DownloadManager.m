//
//  DownloadManager.m
//  GWeather
//
//  Created by Andrew Chernyhov on 15.06.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import "DownloadManager.h"
@interface DownloadManager ()
{
    NSURL *_url;
}
@end

@implementation DownloadManager

-(id) initWithURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

- (void) downloadCityList: (id<DownloadManagerDelegate>)delegate
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *cityRequestTask = [session dataTaskWithURL:_url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [delegate downloadManagerFinishedCityListRequestWithData:data]; //теряет делегата при другой записи
        });
        
        
        
    }];
    [cityRequestTask resume];
}



@end
