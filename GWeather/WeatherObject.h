//
//  WeatherObject.h
//  GWeather
//
//  Created by Andrew Chernyhov on 15.06.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherObject : NSObject
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, copy) NSString *coordinates;
@property (nonatomic, copy) NSString *weekDay;
@property (nonatomic, copy) NSString *weatherDiscription;
@property (nonatomic, copy) NSString *currentTemperature;
@property (nonatomic, copy) NSString *sunrise;
@property (nonatomic, copy) NSString *sunset;
@property (nonatomic, copy) NSString *humidityRate;
@property (nonatomic, copy) NSString *windSpeed;
@end
