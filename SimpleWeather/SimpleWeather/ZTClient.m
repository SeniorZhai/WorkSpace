//
//  ZTClient.m
//  SimpleWeather
//
//  Created by 翟涛 on 14-3-9.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "ZTClient.h"
#import "ZTCondition.h"
#import "ZTDailyForecast.h"
@interface ZTClient()

@property (nonatomic,strong)NSURLSession *session;

@end

@implementation ZTClient
- (id)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}

- (RACSignal *)fetchJSONFromURL:(NSURL *)url {
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (! error) {
                NSError *jsonError = nil;
                id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                if (! jsonError) {
                    [subscriber sendNext:json];
                }
                else {
                    [subscriber sendError:jsonError];
                }
            }
            else {
                [subscriber sendError:error];
            }
            
            [subscriber sendCompleted];
        }];
        
        [dataTask resume];
        
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }] doError:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (RACSignal *)fetchCurrentConditionsForLocation:(CLLocationCoordinate2D)coordinate {
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&units=imperial",coordinate.latitude, coordinate.longitude];
    NSURL *url = [NSURL URLWithString:urlString];
    
    return [[self fetchJSONFromURL:url] map:^(NSDictionary *json) {
        return [MTLJSONAdapter modelOfClass:[ZTCondition class] fromJSONDictionary:json error:nil];
    }];
}
- (RACSignal *)fetchDailyForecastForLocation:(CLLocationCoordinate2D)coordinate {
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?lat=%f&lon=%f&units=imperial&cnt=7",coordinate.latitude, coordinate.longitude];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Use the generic fetch method and map results to convert into an array of Mantle objects
    return [[self fetchJSONFromURL:url] map:^(NSDictionary *json) {
        // 从JSON中取list变为序列
        NSLog(@"\njson____\n%@",json);
        RACSequence *list = [json[@"list"] rac_sequence];
        
        // Use a function to map results from JSON to Mantle objects
        return [[list map:^(NSDictionary *item) {
            NSLog(@"\nitem____\n%@",item);
            return [MTLJSONAdapter modelOfClass:[ZTDailyForecast class] fromJSONDictionary:item error:nil];
        }] array];
    }];
}

- (RACSignal *)fetchHourlyForecastForLocation:(CLLocationCoordinate2D)coordinate {
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast?lat=%f&lon=%f&units=imperial&cnt=12",coordinate.latitude, coordinate.longitude];
    NSURL *url = [NSURL URLWithString:urlString];
    
    return [[self fetchJSONFromURL:url] map:^(NSDictionary *json) {
        RACSequence *list = [json[@"list"] rac_sequence];
        
        return [[list map:^(NSDictionary *item) {
            return [MTLJSONAdapter modelOfClass:[ZTCondition class] fromJSONDictionary:item error:nil];
        }] array];
    }];
}

@end
