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

@end
