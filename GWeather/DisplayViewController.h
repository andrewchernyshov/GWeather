//
//  DisplayViewController.h
//  GWeather
//
//  Created by Andrew Chernyhov on 15.06.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBViewController.h"

@interface DisplayViewController : UIViewController <SBViewControllerDelegate>
- (IBAction)addSBVCButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherDiscriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunriseLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunsetLabel;

@property (weak, nonatomic) IBOutlet UILabel *day1WeekDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *day1TemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *day1WeatherDiscriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *day1WindSpeedLabel;

@property (weak, nonatomic) IBOutlet UILabel *day2WeekDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *day2TemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *day2WeatherDiscriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *day2WindSpeedLabel;

@property (weak, nonatomic) IBOutlet UILabel *day3WeekDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *day3TemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *day3WeatherDiscriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *day3WindSpeedLabel;



@end
