//
//  ZTManger.h
//  SimpleWeather
//
//  Created by 翟涛 on 14-3-9.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
#import <ReactiveCocoa/ReactiveCocoa/ReactiveCocoa.h>
#import "ZTCondition.h"

@interface ZTManager : NSObject<CLLocationManagerDelegate>

+(instancetype) sharedManager;

@property (nonatomic,strong,readonly) CLLocation *currentLocation;
@property (nonatomic,strong,readonly) ZTCondition *currentCondition;
@property (nonatomic,strong,readonly) NSArray *hourlyForecast;
@property (nonatomic,strong,readonly) NSArray *dailyForecast;

- (void)findCurrentLocation;

@end
