//
//  ZTClient.m
//  First_iPad
//
//  Created by 翟涛 on 14-3-10.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "ZTClient.h"

@interface ZTClient()

@property (nonatomic,strong)NSURLSession* session;

@end

@implementation ZTClient

- (id)init{
    if (self = [super init]) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
};

- (id)fetchJSONFromURL:(NSURL *)url{
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (! error) {
            NSError *jsonError = nil;
           
            id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            if (!jsonError) {
                NSLog(@"成功");
            }
            else{
                NSLog(@"%@",jsonError);
            }
        }
        else{
            NSLog(@"%@",error);
        }
    }];
    [task resume];
    return nil;
}

@end
