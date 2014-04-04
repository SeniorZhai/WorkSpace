//
//  OderInfoCell.m
//  STDG
//
//  Created by 翟涛 on 14-4-4.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "OderInfoCell.h"

@implementation OderInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _name = [[UILabel alloc]init];
        _created = [[UILabel alloc]init];
        _pay_time = [[UILabel alloc]init];
        _payment = [[UILabel alloc]init];
        [self.contentView addSubview:_name];
        [self.contentView addSubview:_created];
        [self.contentView addSubview:_payment];
        [self.contentView addSubview:_pay_time];
    }
    return self;
}

@end
