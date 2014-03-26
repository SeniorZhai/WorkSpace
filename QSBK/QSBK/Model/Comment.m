//
//  Comment.m
//  QSBK
//
//  Created by 翟涛 on 14-3-26.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "Comment.h"

@implementation Comment
@synthesize name;
@synthesize content;
@synthesize floor;
- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        id user = [dictionary objectForKey:@"user"];
        if([user class] != [NSNull class])
        {
            self.name = [user objectForKey:@"login"];
        }
        self.content = [dictionary objectForKey:@"content"];
        self.floor = [[dictionary objectForKey:@"floor"] intValue];
    }
    return self;
}

- (void)dealloc{
    self.name = nil;
    self.content = nil;
}

@end
