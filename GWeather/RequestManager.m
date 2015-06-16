//
//  RequestManager.m
//  GWeather
//
//  Created by Andrew Chernyhov on 15.06.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import "RequestManager.h"
#import "DownloadManager.h"
#import "Parcer.h"


@implementation RequestManager

#pragma mark General functions


- (void) getCityListWithRequest:(NSString *)cityRequest
{
    
    DownloadManager *downloadManager = [[DownloadManager alloc] init];
    [downloadManager downloadCityListWithRequest:cityRequest :self];
    //downloadManager.delegate = self;
    }

#pragma mark Callbacks

- (void) downloadManagerFinishedCityListRequestWithData:(NSData *)data
{
    Parcer *parcer = [[Parcer alloc] initWithCityList:data dayForecast:nil threeDaysForecast:nil];
    [parcer parceCityList:self];
}

- (void) ParcerFinishedCityListParcingWithData:(NSMutableArray *)data
{
    [_delegate requestManagerFinishedWithCityList:data];
}
@end
