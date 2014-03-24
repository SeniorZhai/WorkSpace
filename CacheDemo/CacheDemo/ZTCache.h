//
//  ZTCache.h
//  CacheDemo
//
//  Created by 翟涛 on 14-3-24.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTCache : NSObject

+ (void) resetCache;
+ (void) setObject:(NSData *)data forKey:(NSString *)key;
+ (id) objectForKey:(NSString *)key;

@end
