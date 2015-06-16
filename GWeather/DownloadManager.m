//
//  DownloadManager.m
//  GWeather
//
//  Created by Andrew Chernyhov on 15.06.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import "DownloadManager.h"
@interface DownloadManager ()
{
    NSString *codedRequest;
    NSString *lat;
    NSString *lon;
    NSData *aDayForecast;
    NSData *threeDaysForecast;
    
}
@end

@implementation DownloadManager


- (void) downloadCityListWithRequest:(NSString *)request :(id<DownloadManagerDelegate>)delegate
{
    codedRequest = [request stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://geocode-maps.yandex.ru/1.x/?format=json&geocode=%@", codedRequest]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *cityRequestTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [delegate downloadManagerFinishedCityListRequestWithData:data]; //теряет делегата при другой записи
        });
        
        
        
    }];
    [cityRequestTask resume];
}


- (void) downloadForecastWithRequest:(WeatherRequest *)request :(id<DownloadManagerDelegate>)delegate
{
    _delegate = delegate;
    NSArray *dividedCoordinates = [request.coordinates componentsSeparatedByString:@" "];
    lat = [dividedCoordinates objectAtIndex:1];
    lon = [dividedCoordinates objectAtIndex:0];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&cnt=4&mode=json&APPID=7099e347b14e30461a20a65f60e11a89", lat, lon]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            aDayForecast = [[NSData alloc] initWithData:data];
            
            
        });
        
    }];
    [task resume];
    

    NSURL *_url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?lat=%@&lon=%@&cnt=4&mode=json&APPID=7099e347b14e30461a20a65f60e11a89", lat, lon]];
    NSURLSessionTask *_task = [session dataTaskWithURL:_url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            threeDaysForecast = data;
            [delegate downloadManagerFinishedForecastDownloadWithData:aDayForecast :threeDaysForecast];
        
        });
    
    }];
    
    [_task resume];
}



@end
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
