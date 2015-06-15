//
//  DownloadManager.h
//  GWeather
//
//  Created by Andrew Chernyhov on 15.06.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DownloadManagerDelegate
- (void) downloadManagerFinishedCityListRequestWithData: (NSData *)data;
@end


@interface DownloadManager : NSObject
- (id) initWithURL: (NSURL *) url;
@property (nonatomic, weak) id<DownloadManagerDelegate>delegate;

- (void) downloadCityList: (id<DownloadManagerDelegate>)delegate;



@end
