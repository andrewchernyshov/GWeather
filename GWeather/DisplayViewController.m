//
//  DisplayViewController.m
//  GWeather
//
//  Created by Andrew Chernyhov on 15.06.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import "DisplayViewController.h"

@interface DisplayViewController ()

@end

@implementation DisplayViewController

- (void)viewDidLoad {
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addSBVCButton:(id)sender {
    SBViewController *sbvc = [self.storyboard instantiateViewControllerWithIdentifier:@"SBViewController"];
    [self presentViewController:sbvc animated:YES completion:nil];
    sbvc.delegate = self;
}


- (void) sbFinishedWithDayForecast:(WeatherObject *)dayForecast withThreeDayForecast:(NSMutableArray *)threeDaysForecast
{
    [_cityNameLabel setText:dayForecast.cityName];
    [_regionLabel setText:dayForecast.region];
    [_weekDayLabel setText:dayForecast.weekDay];
    [_weatherDiscriptionLabel setText:dayForecast.weatherDiscription];
    [_temperatureLabel setText:dayForecast.currentTemperature];
    [_humidityLabel setText:dayForecast.humidityRate];
    [_windSpeedLabel setText:dayForecast.windSpeed];
    [_sunriseLabel setText:dayForecast.sunrise];
    [_sunsetLabel setText:dayForecast.sunset];
    
    
    [_day1WeekDayLabel setText:[[threeDaysForecast objectAtIndex:0]weekDay]];
    [_day1TemperatureLabel setText:[[threeDaysForecast objectAtIndex:0] currentTemperature]];
    [_day1WeatherDiscriptionLabel setText:[[threeDaysForecast objectAtIndex:0]weatherDiscription]];
    [_day1WindSpeedLabel setText:[[threeDaysForecast objectAtIndex:0] windSpeed]];
    
    
    [_day2WeekDayLabel setText:[[threeDaysForecast objectAtIndex:1]weekDay]];
    [_day2TemperatureLabel setText:[[threeDaysForecast objectAtIndex:1] currentTemperature]];
    [_day2WeatherDiscriptionLabel setText:[[threeDaysForecast objectAtIndex:1]weatherDiscription]];
    [_day2WindSpeedLabel setText:[[threeDaysForecast objectAtIndex:1]windSpeed]];
    
    [_day3WeekDayLabel setText:[[threeDaysForecast objectAtIndex:2]weekDay]];
    [_day3TemperatureLabel setText:[[threeDaysForecast objectAtIndex:2] currentTemperature]];
    [_day3WeatherDiscriptionLabel setText:[[threeDaysForecast objectAtIndex:2]weatherDiscription]];
    [_day3WindSpeedLabel setText:[[threeDaysForecast objectAtIndex:2]windSpeed]];
   
    
}


@end
