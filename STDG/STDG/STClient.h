//
//  STClient.h
//  STDG
//
//  Created by 翟涛 on 14-3-10.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa/ReactiveCocoa.h>
#import "STGategory.h"

@interface STClient : NSObject

@property (nonatomic,strong,readonly) NSArray *forumArray;
@property (nonatomic,strong,readonly) NSArray *category;
@property (nonatomic,strong,readonly) NSArray *postTitles;
@property (nonatomic,strong,readonly) NSArray *news;

+(instancetype) sharedClient;

- (void)fetchWebForum;
- (void)fetchWebCategory;
- (void)fetchWebForumPosts:(int)fid;
- (void)fetchWebNews:(int)fid;
@end
