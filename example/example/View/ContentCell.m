//
//  ContentCell.m
//  example
//
//  Created by 翟涛 on 14-3-27.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "ContentCell.h"

@implementation ContentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background"]];
        _icon = [[UIImageView alloc]init];
        _name = [[UILabel alloc] init];
        _content = [[UILabel alloc] init];
        _image = [[UIImageView alloc] init];
        
        
        [self.contentView addSubview:_image];
        [self.contentView addSubview:_name];
        [self.contentView addSubview:_icon];
        [self.contentView addSubview:_content];
    }
    return self;
}

@end
