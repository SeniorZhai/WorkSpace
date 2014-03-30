//
//  Content.m
//  example
//
//  Created by 翟涛 on 14-3-29.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "Content.h"

@implementation Content

- (id)initWithDictionnary:(NSDictionary*)dic
{
    if (self = [super init])
    {
        _image = [dic objectForKey:@"image"];
        _aid = [dic objectForKey:@"id"];
        _created_at = [dic objectForKey:@"created_at"];
        _content = [dic objectForKey:@"content"];
        _user = [[User alloc] initWithDictionnary:[dic objectForKey:@"user"]];
    }
    return self;
}

@end
