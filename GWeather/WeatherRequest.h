//
//  WeatherRequest.h
//  GWeather
//
//  Created by Andrew Chernyhov on 15.06.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherRequest : NSObject
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, copy) NSString *coordinates;

-(id) initWithCityName: (NSString *)cityName region: (NSString *)region coordinates: (NSString *) coordinates;

@end
