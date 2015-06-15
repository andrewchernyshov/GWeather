//
//  WeatherRequest.m
//  GWeather
//
//  Created by Andrew Chernyhov on 15.06.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import "WeatherRequest.h"

@implementation WeatherRequest

- (id) initWithCityName:(NSString *)cityName region:(NSString *)region coordinates:(NSString *)coordinates
{
    self = [super init];
    if (self) {
        _cityName = cityName;
        _region = region;
        _coordinates = coordinates;
    }
    return self;
}

@end
