//
//  Parcer.h
//  GWeather
//
//  Created by Andrew Chernyhov on 15.06.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherRequest.h"
#import "WeatherObject.h"
@protocol ParcerDelegate

- (void) parcerFinishedCityListParcingWithData: (NSMutableArray *) data;
- (void) parcerFinishedForecastParcingWitgData: (WeatherObject *)todayForecast :(NSMutableArray *)threeDayForecast;
@end

@interface Parcer : NSObject

- (id) initWithCityList: (NSData *)cityList dayForecast: (NSData *)dayForecast : (NSData *) threeDaysForecast : (WeatherRequest *)currentWeatherRequest;
- (void) parceCityList: (id<ParcerDelegate>)delegate;
- (void) parceForecast: (id<ParcerDelegate>)delegate;

@property (nonatomic, weak) id <ParcerDelegate> delegate;
@end
