//
//  NewsViewController.h
//  AKTabBar
//
//  Created by 翟涛 on 14-3-12.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AfficheViewController.h"
#import "DynamicViewController.h"
#import "IndustryViewController.h"

@interface NewsViewController : UIViewController

@property (nonatomic,strong) UISegmentedControl *segmentedControl;
@property (nonatomic,strong) AfficheViewController *view1;
@property (nonatomic,strong) DynamicViewController *view2;
@property (nonatomic,strong) IndustryViewController *view3;

- (void)segmentAction:(UISegmentedControl *)Seg;

@end
