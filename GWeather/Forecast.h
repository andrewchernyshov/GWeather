//
//  Forecast.h
//  GWeather
//
//  Created by Andrew Chernyhov on 17.06.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherObject.h"

@interface Forecast : NSObject
-(id) initWithDayForecast: (WeatherObject *) dayForecast and3DaysForecast: (NSMutableArray *) threeDaysForecast;
- (NSMutableArray *) get3DaysForecast;
- (WeatherObject *) getDayForecast;
@property(nonatomic, strong) WeatherObject *dayForecast;
@property (nonatomic, strong) NSMutableArray *threeDaysForecast;
@end
