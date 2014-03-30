//
//  User.m
//  example
//
//  Created by 翟涛 on 14-3-29.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "User.h"

@implementation User


- (id)initWithDictionnary:(id)dic
{
    if (self = [super init])
    {
        if ([dic class] != [NSNull class]) {
            _aid = [dic objectForKey:@"id"];
            _icon = [dic objectForKey:@"icon"];
            _userName = [dic objectForKey:@"login"];
        }
    }
    return self;
}


@end
