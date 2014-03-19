//
//  IndustryViewController.m
//  STDG
//
//  Created by 翟涛 on 14-3-13.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "IndustryViewController.h"

@interface IndustryViewController ()

@end

@implementation IndustryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.title = @"行业资讯";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	CGSize size = [UIScreen mainScreen].bounds.size;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(size.width/2 - 50, size.height/2 -25, 100, 50)];
    label.textAlignment = UITextAlignmentCenter;
    label.text = self.title;
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
