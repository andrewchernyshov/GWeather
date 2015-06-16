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
}

- (void) getCityListWithRequest:(NSString *)cityRequest
{
    
    DownloadManager *downloadManager = [[DownloadManager alloc] init];
    [downloadManager downloadCityListWithRequest:cityRequest :self];
    //downloadManager.delegate = self;
    }

- (void) getForecastWithRequest:(WeatherRequest *)forecastRequest
{
    currentRequest = forecastRequest;
    DownloadManager *downloadManager = [[DownloadManager alloc] init];
    [downloadManager downloadForecastWithRequest:forecastRequest :self];
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

- (void) downloadManagerFinishedForecastDownloadWithData:(NSData *)dayData :(NSData *)threeDaysData
{
    Parcer *parcer = [[Parcer alloc] initWithCityList:nil dayForecast:dayData :threeDaysData :currentRequest];
    [parcer parceForecast:self];
}

- (void) parcerFinishedForecastParcingWitgData:(WeatherObject *)todayForecast :(NSMutableArray *)threeDayForecast
{
    
    [self.delegate requestManagerFinishedWithForecast:todayForecast :threeDayForecast];
}

@end
