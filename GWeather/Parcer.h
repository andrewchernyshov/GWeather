//
//  Parcer.h
//  GWeather
//
//  Created by Andrew Chernyhov on 15.06.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ParcerDelegate

- (void) ParcerFinishedCityListParcingWithData: (NSMutableArray *) data;

@end

@interface Parcer : NSObject

- (id) initWithCityList: (NSData *)cityList dayForecast: (NSData *)dayForecast threeDaysForecast: (NSData *) threeDaysForecast;
- (void) parceCityList: (id<ParcerDelegate>)delegate;
@property (nonatomic, weak) id <ParcerDelegate> delegate;
@end
