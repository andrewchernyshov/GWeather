//
//  Coordinator.m
//  GWeather
//
//  Created by Andrew Chernyhov on 15.06.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import "Coordinator.h"

@implementation Coordinator
+ (Coordinator *)sharedInstance
{
    static Coordinator *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
    
        _sharedInstance = [[Coordinator alloc] init];
    
    });
    return _sharedInstance;
}


#pragma mark General functions

- (void)getCityListWithRequest:(NSString *)request
{
    RequestManager *requestManager = [[RequestManager alloc] init];
    requestManager.delegate = self;
    [requestManager getCityListWithRequest:request];

}


- (void) getForecastWithRequest:(WeatherRequest *)request
{
    RequestManager *requestManager = [[RequestManager alloc] init];
    [requestManager getForecastWithRequest:request];
}

#pragma mark Callback

- (void)requestManagerFinishedWithCityList:(NSMutableArray *)cityList
{
    [self.delegate cityListRequestFinishedWithData:cityList];
}

- (void) requestManagerFinishedWithForecast:(WeatherObject *)dayForecast :(NSMutableArray *)threeDaysForecast
{
    [self.delegate forecastRequestFinishedWithData:dayForecast :threeDaysForecast];
}

@end
