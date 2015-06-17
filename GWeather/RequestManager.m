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
{
    WeatherRequest *currentRequest;
    NSData *day1ForecastData;
    
}

- (void) getCityListWithRequest:(NSString *)cityRequest 
{
    
    DownloadManager *downloadManager = [[DownloadManager alloc] init];
    [downloadManager downloadCityListWithRequest:cityRequest :self];
    
    }

- (void) getForecastWithRequest:(WeatherRequest *)forecastRequest :(id<RequestManagerDelegate>)delegate
{
    currentRequest = forecastRequest;
    DownloadManager *downloadManager = [[DownloadManager alloc] init];
    [downloadManager download1DayForecastWithRequest:forecastRequest :self];
    
    
    
}

#pragma mark Callbacks

- (void) downloadManagerFinishedCityListRequestWithData:(NSData *)data
{
    Parcer *parcer = [[Parcer alloc] initWithCityList:data dayForecast:nil :nil :nil];
    [parcer parceCityList:self];
}

- (void) parcerFinishedCityListParcingWithData:(NSMutableArray *)data
{
    [_delegate requestManagerFinishedWithCityList:data];
}

- (void) downloadManagerFinishedForecastDownloadFor1DayWithData:(NSData *)dayData
{
    day1ForecastData = [[NSData alloc] initWithData:dayData];
    DownloadManager *downloadManager = [[DownloadManager alloc] init];
    [downloadManager download3DaysForecastWithRequest:currentRequest :self];
}

- (void) downloadManagerFinishedForecastDownloadFor3DaysWithData:(NSData *)threeDaysData
{
    Parcer *parcer = [[Parcer alloc] initWithCityList:nil dayForecast:day1ForecastData :threeDaysData :currentRequest ];
    [parcer parce1DayForecast];
    [parcer parce3DayForecast:self];
}


- (void) parcerFinishedForecastParcingWitgData:(WeatherObject *)todayForecast :(NSMutableArray *)threeDaysForecast
{
    [self.delegate requestManagerFinishedWithForecast:todayForecast :threeDaysForecast];
    [_delegate requestManagerFinishedWithForecast:todayForecast :threeDaysForecast];
}
@end

















