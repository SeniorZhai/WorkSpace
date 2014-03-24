//
//  ZTCache.m
//  CacheDemo
//
//  Created by 翟涛 on 14-3-24.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "ZTCache.h"

//  7天的秒数
static NSTimeInterval cacheTime = (double)604800;

@implementation ZTCache

+ (void) resetCache {
    [[NSFileManager defaultManager] removeItemAtPath:[ZTCache cacheDirectory] error:nil];
}
+ (NSString *) cacheDirectory {
    // 沙盒缓存目录 用户主目录 展开完整目录
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* cacheDirectory = [paths objectAtIndex:0];
    // 添加目录后缀
    cacheDirectory = [cacheDirectory stringByAppendingPathComponent:@"ZTCaches"];
    return cacheDirectory;
}

+ (NSData *) objectForKey:(NSString *)key{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSString* filename = [self.cacheDirectory stringByAppendingPathComponent:key];
    // 判断文件是否存在
    if ([fileManager fileExistsAtPath:filename]) {
        // 获取文件属性Dic，并取其中的最后修改时间属性
        NSDate *modificationDate = [[fileManager attributesOfItemAtPath:filename error:nil] objectForKey:NSFileModificationDate];
        // 如果最后修改时间与现在时间大于7天，删除文件
        if ([modificationDate timeIntervalSinceNow] > cacheTime) {
            [fileManager removeItemAtPath:filename error:nil];
        }else{
            // 从文件中读取data
            NSData *data = [NSData dataWithContentsOfFile:filename];
            return data;
        }
    }
    NSLog(@"不存在");
    return nil;
}

+ (void) setObject:(NSData *)data forKey:(NSString *)key{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filename = [self.cacheDirectory stringByAppendingPathComponent:key];
    BOOL isDir = YES;
    // 如果缓存目录不存在需要创建缓存目录
    if (![fileManager fileExistsAtPath:self.cacheDirectory isDirectory:&isDir]) {
        // 创建目录
        [fileManager createDirectoryAtPath:self.cacheDirectory withIntermediateDirectories:NO attributes:nil error:nil];
    }
    NSError *error;
    @try {
        [data writeToFile:filename options:NSDataWritingAtomic error:&error];
    }
    @catch (NSException *exception) {
        //
    }
}
@end
