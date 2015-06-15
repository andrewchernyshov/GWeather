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

@interface RequestManager ()
{
    NSString *codedCityRequest;
    
}
@end

@implementation RequestManager

- (void) getCityListWithRequest:(NSString *)cityRequest
{
    codedCityRequest = [cityRequest stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://geocode-maps.yandex.ru/1.x/?format=json&geocode=%@", codedCityRequest]];
    DownloadManager *downloadManager = [[DownloadManager alloc] initWithURL:url];
    [downloadManager downloadCityList:self];
    //downloadManager.delegate = self;
    }

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
