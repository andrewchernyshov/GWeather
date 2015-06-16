//
//  RequestManager.h
//  GWeather
//
//  Created by Andrew Chernyhov on 15.06.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadManager.h"
#import "Parcer.h"
#import "WeatherRequest.h"

@protocol RequestManagerDelegate

- (void) requestManagerFinishedWithCityList: (NSMutableArray *)cityList;

- (void) requestManagerFinishedWithForecast: (WeatherObject *)dayForecast :(NSMutableArray *)threeDaysForecast;

@end

@interface RequestManager : NSObject <DownloadManagerDelegate, ParcerDelegate>

@property (nonatomic, weak) id<RequestManagerDelegate>delegate;
- (void) getCityListWithRequest: (NSString *)cityRequest;
- (void) getForecastWithRequest: (WeatherRequest *)forecastRequest;

@end
