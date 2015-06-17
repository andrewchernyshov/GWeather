//
//  SBViewController.h
//  GWeather
//
//  Created by Andrew Chernyhov on 15.06.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Coordinator.h"
#import "WeatherObject.h"
@protocol SBViewControllerDelegate

- (void) sbFinishedWithDayForecast: (WeatherObject *) dayForecast withThreeDayForecast: (NSMutableArray *)threeDaysForecast;

@end
@interface SBViewController : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, CoordinatorDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;


@property (nonatomic, weak) id<SBViewControllerDelegate>delegate;

@end
