//
//  HomeViewController.h
//  QSBK
//
//  Created by 翟涛 on 14-3-26.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//
#include "ContentViewController.h"
@interface HomeViewController : UIViewController
{
    ContentViewController *contentView;
    UITableView *itemView;
    BOOL isItemViewShow;
    CGFloat width;
    CGFloat height;
}

@property (nonatomic,retain) ContentViewController *contentView;
@property (nonatomic,retain) UITableView *itemView;

- (void)changeFrame:(CGPoint)point;
- (void)hiddenItemView:(BOOL)boolean;

@end
