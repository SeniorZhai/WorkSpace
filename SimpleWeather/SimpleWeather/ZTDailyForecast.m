//
//  ZTDailyForecast.m
//  SimpleWeather
//
//  Created by 翟涛 on 14-3-9.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "ZTDailyForecast.h"

@implementation ZTDailyForecast

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // 1
    NSMutableDictionary *paths = [[super JSONKeyPathsByPropertyKey] mutableCopy];
    // 2
    paths[@"tempHigh"] = @"temp.max";
    paths[@"tempLow"] = @"temp.min";
    // 3
    return paths;
}

+ (NSValueTransformer *)tempHighJSONTransformer{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *num) {
        return @((num.floatValue - 32)*5/9);
    } reverseBlock:^(NSNumber *temp) {
        return @((temp.floatValue + 32)*9/5);
    }];
}
+ (NSValueTransformer *)tempLowJSONTransformer{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *num) {
        return @((num.floatValue - 32)*5/9);
    } reverseBlock:^(NSNumber *temp) {
        return @((temp.floatValue + 32)*9/5);
    }];
}

@end
