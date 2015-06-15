//
//  Parcer.m
//  GWeather
//
//  Created by Andrew Chernyhov on 15.06.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import "Parcer.h"
#import "WeatherRequest.h"
@interface Parcer ()
{
    NSData *_cityList;
    NSData *_dayForecast;
    NSData *_threeDaysForecast;
    WeatherRequest *weatherRequest;
    NSMutableArray *weatherObjectArray;
}
@end

@implementation Parcer

-(id) initWithCityList:(NSData *)cityList dayForecast:(NSData *)dayForecast threeDaysForecast:(NSData *)threeDaysForecast
{
    self = [super init];
    if (self) {
        
        _cityList = cityList;
        _dayForecast = dayForecast;
        _threeDaysForecast = threeDaysForecast;
        
    }
    return self;
}

- (void)parceCityList: (id<ParcerDelegate>)delegate
{
    
    if (_cityList) {
        NSDictionary *cityListDictionary = [NSJSONSerialization JSONObjectWithData:_cityList options:0 error:nil];
        NSDictionary *responseDictionary = [cityListDictionary objectForKey:@"response"];
        NSDictionary *geoObjectCollectionDictionary = [responseDictionary objectForKey:@"GeoObjectCollection"];
        NSArray *featureMemberArray = [geoObjectCollectionDictionary objectForKey:@"featureMember"];
        weatherObjectArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in featureMemberArray) {
            NSDictionary *geoObjectDictionary = [dict objectForKey:@"GeoObject"];
            NSString *cityName = [geoObjectDictionary objectForKey:@"name"];
            
            
            NSString *cityNameDiscription = [geoObjectDictionary objectForKey:@"description"];
            
            
            NSDictionary *pointDictionary = [geoObjectDictionary objectForKey:@"Point"];
            NSString *position = [pointDictionary objectForKey:@"pos"];
            
            weatherRequest = [[WeatherRequest alloc] init];
            [weatherRequest setCityName:cityName];
            
            [weatherRequest setRegion:cityNameDiscription];
            [weatherRequest setCoordinates:position];
            
            [weatherObjectArray addObject:weatherRequest];
        }
        [delegate ParcerFinishedCityListParcingWithData:weatherObjectArray];
    }
}


@end
