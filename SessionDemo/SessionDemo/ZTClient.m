//
//  ZTClient.m
//  SessionDemo
//
//  Created by 翟涛 on 14-3-9.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "ZTClient.h"

@interface ZTClient()
@property (nonatomic,strong)NSURLSession *session;
@end

@implementation ZTClient
- (id)init{
    if(self = [super init])
    {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}
- (NSString *)fetchJSONFormURL:(NSURL *)url{
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (! error) {
            NSError *jsonError = nil;
            id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            if (!jsonError) {
                // JSON数据没有错误，发送订阅者序列化后的JSON数组或字典
                NSLog(@"%@",json);
            }
            else{
                // 在任一情况下如果有错误，通知订阅者
            }
        }
        else
        {
            
        }
        // 无论该请求成功还是失败，通知订阅者请求已经完成
   
        
    }];
    // 订阅信号，启动网络请求
    [dataTask resume];
    return nil;
}
@end