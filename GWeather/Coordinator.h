//
//  Coordinator.h
//  GWeather
//
//  Created by Andrew Chernyhov on 15.06.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestManager.h"
#import "WeatherRequest.h"
#import "WeatherObject.h"
@protocol CoordinatorDelegate
@optional
- (void) cityListRequestFinishedWithData: (NSMutableArray *) cityListArray;
- (void) forecastRequestFinishedWithData: (WeatherObject *)todayForecast :(NSMutableArray *)threeDaysForecast;
@end

@interface Coordinator : NSObject <RequestManagerDelegate>
+(Coordinator *)sharedInstance;
- (void)getCityListWithRequest: (NSString *)request;
- (void)getForecastWithRequest: (WeatherRequest *)request;
@property (nonatomic, weak) id<CoordinatorDelegate>delegate;
@end
