//
//  SBViewController.m
//  GWeather
//
//  Created by Andrew Chernyhov on 15.06.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import "SBViewController.h"
#import "WeatherRequest.h"
#import "Coordinator.h"
#import "DisplayViewController.h"
@interface SBViewController ()
{
    NSMutableArray *cityListArrayDefault;
    NSMutableArray *cityListArrayMain;
    NSString *cityRequest;
    WeatherRequest *forecastRequest;
}
@end

@implementation SBViewController

- (void)viewDidLoad {
    cityListArrayDefault = [[NSMutableArray alloc] init];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

# pragma mark TableView Configuration

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!cityListArrayMain) {
        return cityListArrayDefault.count;
    } else
    {
        return cityListArrayMain.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    if (!cityListArrayMain) {
        WeatherRequest *currentRequest = [cityListArrayDefault objectAtIndex:indexPath.row];
        [cell.textLabel setText:currentRequest.cityName];
        [cell.detailTextLabel setText:currentRequest.region];

    } else
    {
        WeatherRequest *currentRequest = [cityListArrayMain objectAtIndex:indexPath.row];
        [cell.textLabel setText:currentRequest.cityName];
        [cell.detailTextLabel setText:currentRequest.region];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!cityListArrayMain) {
        forecastRequest = [cityListArrayDefault objectAtIndex:indexPath.row];
    }
    else{
        forecastRequest = [cityListArrayMain objectAtIndex:indexPath.row];
    }
    [[Coordinator sharedInstance] getForecastWithRequest:forecastRequest];
    [self dismissViewControllerAnimated:YES completion:nil];
}





#pragma mark SearchBar Configuration

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    cityRequest = searchBar.text;
    Coordinator *coordinator = [Coordinator sharedInstance];
    coordinator.delegate = self;
    [coordinator getCityListWithRequest:cityRequest];
    
  
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark Callbacks

- (void) cityListRequestFinishedWithData: (NSMutableArray *) cityListArray
{
    cityListArrayMain = cityListArray;
    [_myTableView reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
