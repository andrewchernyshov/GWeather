//
//  Coordinator.h
//  GWeather
//
//  Created by Andrew Chernyhov on 15.06.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestManager.h"

@protocol CoordinatorDelegate
- (void) cityListRequestFinishedWithData: (NSMutableArray *) cityListArray;
@end

@interface Coordinator : NSObject <RequestManagerDelegate>
+(Coordinator *)sharedInstance;
- (void)getCityListWithRequest: (NSString *)request;
@property (nonatomic, weak) id<CoordinatorDelegate>delegate;
@end
