//
//  User.h
//  example
//
//  Created by 翟涛 on 14-3-29.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic,strong)NSString* userName;
@property (nonatomic,strong)NSString* aid;
@property (nonatomic,strong)NSString* icon;
- (id)initWithDictionnary:(id)dic;
@end
