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
@property (nonatomic, strong, readwrite)NSMutableArray *forumArray;
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


- (void)fetchWebForum{
    NSURL *url = [NSURL URLWithString:STCLIENT_FORUM];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (! error) {
            NSError *jsonError = nil;
            self.forumArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
            if (! jsonError) {
                
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
//            self.category = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
            RACSequence * list = [array rac_sequence];
            self.category = [[list map:^(NSDictionary *item) {
                return [MTLJSONAdapter modelOfClass:[STGategory class] fromJSONDictionary:item error:nil];
            }] array];
            NSLog(@"%@",self.category);
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
@end
