//
//  Parcer.m
//  GWeather
//
//  Created by Andrew Chernyhov on 15.06.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import "Parcer.h"
#import "WeatherObject.h"
@interface Parcer ()
{
    WeatherObject *currentWeatherForecast;
    
    NSData *_cityList;
    NSData *_dayForecast;
    NSData *_threeDaysForecast;
    WeatherRequest *weatherRequest;
    NSMutableArray *weatherObjectArray;
    WeatherRequest *_forecastRequest;
    NSMutableArray *discriptionWeatherArray;
    WeatherObject *todayForecast;
    
    NSMutableArray *weekdayFinalArray;
    NSMutableArray *windSpeedFinalArray;
    NSMutableArray *weatherDiscriptionFinalArray;
    NSMutableArray *tempFinalArray;
    NSMutableArray *weekdayArray;
    NSMutableArray *windSpeedArray;
    NSMutableArray *tempData;
    NSMutableArray *discriptionArray;
    NSNumberFormatter *numberFormatter;
    NSDateFormatter *dateFormatter;
    NSMutableArray *weatherForecastObjectArray;
    int curDay;
    int curDay1;
    int curDay2;
    
    
    
    
}
@end

@implementation Parcer

- (id) initWithCityList: (NSData *)cityList dayForecast: (NSData *)dayForecast : (NSData *) threeDaysForecast : (WeatherRequest *)currentWeatherRequest
{
    self = [super init];
    if (self) {
        
        _cityList = cityList;
        _dayForecast = dayForecast;
        _threeDaysForecast = threeDaysForecast;
        _forecastRequest = currentWeatherRequest;
        
        
    }
    return self;
}

#pragma mark City list parcing

- (void)parceCityList: (id<ParcerDelegate>)delegate
{
    
    
    
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
    
    
    [delegate parcerFinishedCityListParcingWithData:weatherObjectArray];
    
    
}

- (void) parce1DayForecast
{
    
    
        
    
    
        NSDictionary *allDataDictionary1 = [NSJSONSerialization JSONObjectWithData:_dayForecast options:0 error:nil];
        discriptionWeatherArray = [[NSMutableArray alloc] init];
        NSArray *weatherArray = [allDataDictionary1 objectForKey:@"weather"];
        for (NSDictionary *dict1 in weatherArray) {
            NSString *weatherDiscription = [dict1 objectForKey:@"description"];
            [discriptionWeatherArray addObject:weatherDiscription];
        }
        
        NSDictionary *sysDictionary = [allDataDictionary1 objectForKey:@"sys"];
        
        NSString *sunrise = [sysDictionary objectForKey:@"sunrise"];
        int sunriseInt = [sunrise intValue];
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
        NSDate *sunriseDate = [NSDate dateWithTimeIntervalSince1970:sunriseInt];
        NSString *sunriseFinal = [dateFormatter stringFromDate:sunriseDate];
        
        NSString *sunset = [sysDictionary objectForKey:@"sunset"];
        int sunsetInt = [sunset intValue];
        
        NSDate *sunsetDate = [NSDate dateWithTimeIntervalSince1970:sunsetInt];
        NSString *sunsetFinal = [dateFormatter stringFromDate:sunsetDate];
        
        NSDate *CurrentDate = [NSDate date];
        
        [dateFormatter setDateFormat:@"EEEE"];
        NSString *weekDay = [dateFormatter stringFromDate:CurrentDate];
        
        
        NSDictionary *mainDictionary = [allDataDictionary1 objectForKey:@"main"];
        
        NSString *currentTemperature = [mainDictionary objectForKey:@"temp"];
        NSNumber *temp = [NSNumber numberWithDouble:[currentTemperature doubleValue]- 273]; //NSNumberFormatter
        numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [numberFormatter setRoundingMode:NSNumberFormatterRoundHalfUp];
        [numberFormatter setMaximumFractionDigits:0];
        NSString *tempFormated = [numberFormatter stringFromNumber:temp];
        
        
        
        NSDictionary *windDictionary = [allDataDictionary1 objectForKey:@"wind"];
        NSNumber *windSpeed = [windDictionary objectForKey:@"speed"];
        NSString *windSpeedFinal = [numberFormatter stringFromNumber:windSpeed];
        
        
        
        NSNumber *humidityRate = [mainDictionary objectForKey:@"humidity"];
        
        [numberFormatter setMultiplier:@1];
        [numberFormatter setNumberStyle:NSNumberFormatterPercentStyle];
        NSString *humidityFinal = [numberFormatter stringFromNumber:humidityRate];
    
            todayForecast = [[WeatherObject alloc] init];
            [todayForecast setSunrise:sunriseFinal];
            [todayForecast setSunset:sunsetFinal];
            [todayForecast setWeekDay:weekDay];
            [todayForecast setCurrentTemperature:tempFormated];
            [todayForecast setWindSpeed:windSpeedFinal];
            [todayForecast setHumidityRate:humidityFinal];
            [todayForecast setWeatherDiscription:[discriptionWeatherArray objectAtIndex:0]];
            [todayForecast setCityName:_forecastRequest.cityName];
            [todayForecast setRegion:_forecastRequest.region];
            [todayForecast setCoordinates:_forecastRequest.coordinates];
            
            
    dispatch_async(dispatch_get_main_queue(), ^{
        
        currentWeatherForecast = [[WeatherObject alloc] init];
        currentWeatherForecast = todayForecast;
    });
    
    
}
#pragma mark 3 days forecast parcing

- (void)parce3DayForecast:(id<ParcerDelegate>)delegate
{
    
    
    
    weekdayFinalArray = [[NSMutableArray alloc] init];
    windSpeedFinalArray = [[NSMutableArray alloc] init];
    weatherDiscriptionFinalArray = [[NSMutableArray alloc] init];
    tempFinalArray = [[NSMutableArray alloc] init];
    dateFormatter = [[NSDateFormatter alloc] init];
    weekdayArray = [[NSMutableArray alloc] init];
    windSpeedArray = [[NSMutableArray alloc] init];
    tempData = [[NSMutableArray alloc] init];
    discriptionArray = [[NSMutableArray alloc] init];
    
    
    weatherForecastObjectArray = [[NSMutableArray alloc] init];
    
    

    
    
        
        NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:_threeDaysForecast options:0 error:nil];
        NSArray *arrayOfList = [allDataDictionary objectForKey:@"list"];
        
        for (NSDictionary *diction in arrayOfList) {
            NSString *dayTime = [diction objectForKey:@"dt"];
            NSNumber *windSpeed = [diction objectForKey:@"speed"];
            
            [weekdayArray addObject:dayTime];
            [windSpeedArray addObject: windSpeed];
            
            
            NSDictionary *temp = [diction objectForKey:@"temp"];
            NSString *currentTemp = [temp objectForKey:@"day"];
            [tempData addObject:currentTemp];
            
            NSArray *arrayOfWeather = [diction objectForKey:@"weather"];
            for (NSDictionary *diction2 in arrayOfWeather) {
                NSString *weatherDiscr = [diction2 objectForKey:@"description"];
                
                [discriptionArray addObject:weatherDiscr];
            }
            
        }
        
        
        
        
        NSString *temp1 = [tempData objectAtIndex:1];
        NSString *temp2 = [tempData objectAtIndex:2];
        NSString *temp3 = [tempData objectAtIndex:3];
        NSNumber *temp1Num = [NSNumber numberWithFloat:[temp1 floatValue]- 273];
        NSNumber *temp2Num = [NSNumber numberWithFloat:[temp2 floatValue]- 273];
        NSNumber *temp3Num = [NSNumber numberWithFloat:[temp3 floatValue]- 273];
        
        
        
        
        [numberFormatter setRoundingMode:NSNumberFormatterRoundHalfUp];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [numberFormatter setMaximumFractionDigits:0];
        
        
        NSString *temp1Final = [numberFormatter stringFromNumber:temp1Num];
        NSString *temp2Final = [numberFormatter stringFromNumber:temp2Num];
        NSString *temp3Final = [numberFormatter stringFromNumber:temp3Num];
        [tempFinalArray addObject:temp1Final];
        [tempFinalArray addObject:temp2Final];
        [tempFinalArray addObject:temp3Final];
        
        
        
        
        
        NSString *day1 = [weekdayArray objectAtIndex:1];
        curDay = [day1 intValue];
        NSString *day2 = [weekdayArray objectAtIndex:2];
        curDay1 = [day2 intValue];
        NSString *day3 = [weekdayArray objectAtIndex:3];
        curDay2 = [day3 intValue];
        
        
        [dateFormatter setDateFormat:@"EEE"];
        NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:curDay];
        NSDate *currentDate1 = [NSDate dateWithTimeIntervalSince1970:curDay1];
        NSDate *currentDate2 = [NSDate dateWithTimeIntervalSince1970:curDay2];
        
        
        NSString *weekdayFinal = [dateFormatter stringFromDate:currentDate];
        NSString *weekdayFinal1 = [dateFormatter stringFromDate:currentDate1];
        NSString *weekdayFinal2 = [dateFormatter stringFromDate:currentDate2];
        [weekdayFinalArray addObject:weekdayFinal];
        [weekdayFinalArray addObject:weekdayFinal1];
        [weekdayFinalArray addObject:weekdayFinal2];
        
        
        NSString *day1WindSpeed = [numberFormatter stringFromNumber:[windSpeedArray objectAtIndex:1]];
        NSString *day2WindSpeed = [numberFormatter stringFromNumber:[windSpeedArray objectAtIndex:2]];
        NSString *day3WindSpeed = [numberFormatter stringFromNumber:[windSpeedArray objectAtIndex:3]];
        [windSpeedFinalArray addObject:day1WindSpeed];
        [windSpeedFinalArray addObject:day2WindSpeed];
        [windSpeedFinalArray addObject:day3WindSpeed];
        
        
        
        
        NSString *weatherDiscrFinal = [discriptionArray objectAtIndex:1];
        NSString *weatherDiscrFinal1 = [discriptionArray objectAtIndex:2];
        NSString *weatherDiscrFinal2 = [discriptionArray objectAtIndex:3];
        [weatherDiscriptionFinalArray addObject:weatherDiscrFinal];
        [weatherDiscriptionFinalArray addObject:weatherDiscrFinal1];
        [weatherDiscriptionFinalArray addObject:weatherDiscrFinal2];
        
        
        int i;
        
        for (i = 0; i <= 2; i ++) {
            
            WeatherObject *weatherObject = [[WeatherObject alloc] init];
            [weatherObject setWeekDay:[weekdayFinalArray objectAtIndex:i]];
            [weatherObject setCurrentTemperature:[tempFinalArray objectAtIndex:i]];
            [weatherObject setWindSpeed:[windSpeedFinalArray objectAtIndex:i]];
            [weatherObject setWeatherDiscription:[weatherDiscriptionFinalArray objectAtIndex:i]];
            
            [weatherForecastObjectArray addObject:weatherObject];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [delegate parcerFinishedForecastParcingWitgData:currentWeatherForecast :weatherForecastObjectArray];
            
        });
        

    

    
}
























@end
