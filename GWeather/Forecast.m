//
//  Forecast.m
//  GWeather
//
//  Created by Andrew Chernyhov on 17.06.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import "Forecast.h"

@implementation Forecast

-(id) initWithDayForecast:(WeatherObject *)dayForecast and3DaysForecast:(NSMutableArray *)threeDaysForecast
{
    self = [super init];
    if (self) {
        _dayForecast = dayForecast;
        _threeDaysForecast = threeDaysForecast;
    }
    return self;
}


- (WeatherObject *) getDayForecast
{
    return _dayForecast;
}

- (NSMutableArray *) get3DaysForecast
{
    return _threeDaysForecast;
}


@end
