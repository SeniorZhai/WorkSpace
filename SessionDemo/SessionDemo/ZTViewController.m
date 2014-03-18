//
//  ZTViewController.m
//  SessionDemo
//
//  Created by 翟涛 on 14-3-9.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "ZTViewController.h"
#import "ZTClient.h"
@interface ZTViewController ()

@end

@implementation ZTViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
    ZTClient *clent = [[ZTClient alloc]init];
    UITextView *field = [[UITextView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    field.backgroundColor = [UIColor clearColor];
    field.textColor = [UIColor blackColor];
    field.text = @"\nLoading...";
    field.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    field.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:field];
    [clent fetchJSONFormURL:[NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/weather?lat=37.785834&lon=-122.406417&units=imperial"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
@end
