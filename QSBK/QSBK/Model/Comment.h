//
//  Comment.h
//  QSBK
//
//  Created by 翟涛 on 14-3-26.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject
{
    NSString *name;
    NSString *content;
    int floor;
}

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,assign)int floor;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
