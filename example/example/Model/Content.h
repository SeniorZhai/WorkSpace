//
//  Content.h
//  example
//
//  Created by 翟涛 on 14-3-29.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "User.h"

@interface Content : NSObject

@property (nonatomic,strong)NSString* image;
@property (nonatomic,strong)NSString* aid;
@property (nonatomic,strong)NSNumber* created_at;
@property (nonatomic,strong)NSString* content;
@property (nonatomic,strong)User* user;

- (id)initWithDictionnary:(NSDictionary*)dic;
@end
