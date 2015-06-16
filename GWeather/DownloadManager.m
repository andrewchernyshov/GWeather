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
    NSString *codedRequest;
}
@end

@implementation DownloadManager


- (void) downloadCityListWithRequest:(NSString *)request :(id<DownloadManagerDelegate>)delegate
{
    codedRequest = [request stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://geocode-maps.yandex.ru/1.x/?format=json&geocode=%@", codedRequest]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *cityRequestTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [delegate downloadManagerFinishedCityListRequestWithData:data]; //теряет делегата при другой записи
        });
        
        
        
    }];
    [cityRequestTask resume];
}



@end
