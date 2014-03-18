//
//  STClient.m
//  STDG
//
//  Created by 翟涛 on 14-3-10.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "STClient.h"
#import "AppMacro.h"
#import <Mantle.h>

@interface STClient()

@property (nonatomic,strong)NSURLSession *session;

@property (nonatomic, strong, readwrite) NSArray *category;
@property (nonatomic, strong, readwrite) NSArray *postTitles;
@property (nonatomic, strong, readwrite) NSArray *forumArray;
@property (nonatomic, strong, readwrite) NSArray *news;
@end

@implementation STClient

+ (instancetype)sharedClient {
    static id _sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] init];
    });
    
    return _sharedClient;
}


- (id)init{
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

- (void)fetchWebForum{
    NSURL *url = [NSURL URLWithString:STCLIENT_FORUM];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (! error) {
            NSError *jsonError = nil;
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
            if (! jsonError) {
                self.forumArray = array;
            }else{
               
            }
        }
        else{
           
        }}];
    [dataTask resume];
}

- (void)fetchWebCategory{
    NSURL *url = [NSURL URLWithString:STCLIENT_CATEGORY];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (! error) {
            NSError *jsonError = nil;
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
            RACSequence * list = [array rac_sequence];
            self.category = [[list map:^(NSDictionary *item) {
                return [MTLJSONAdapter modelOfClass:[STGategory class] fromJSONDictionary:item error:nil];
            }] array];
            if (! jsonError) {
               
            }else{
                
            }
        }
        else{
            
        }}];
    [dataTask resume];
}

- (void)fetchWebForumPosts:(int)fid{
    NSURL *url = [NSURL URLWithString:[[NSString alloc]initWithFormat:STCLIENT_FORUM_POSTS_TITLE,fid,0,5]];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (! error) {
            NSError *jsonError = nil;
            self.postTitles = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
            if (! jsonError) {
                
            }else{
                
            }
        }
        else{
            
        }}];
    [dataTask resume];
}
- (void)fetchWebNews:(int)fid{
    NSURL *url = [NSURL URLWithString:[[NSString alloc]initWithFormat:STCLIENT_CATEGORY_NEWS,fid,0,20]];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (! error) {
            NSError *jsonError = nil;
            self.news = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
            if (! jsonError) {
                
            }else{
                
            }
        }
        else{
            
        }}];
    [dataTask resume];
}
@end
