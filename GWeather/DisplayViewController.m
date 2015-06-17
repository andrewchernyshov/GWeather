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
    
}


@end
