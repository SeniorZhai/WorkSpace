//
//  OrderInfoViewController.m
//  STDG
//
//  Created by 翟涛 on 14-3-27.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "OrderInfoViewController.h"

@interface OrderInfoViewController ()
@property (nonatomic,strong) NSDateFormatter * myFormatter;
@end

@implementation OrderInfoViewController
@synthesize myFormatter;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        myFormatter = [[NSDateFormatter alloc]init];
        myFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [myFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.left.inputView = self.datePickerInput;
    self.right.inputView = self.datePickerInput2;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)bn:(id)sender {
}
- (IBAction)dateChanged:(id)sender {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterShortStyle];
    [df setTimeStyle:NSDateFormatterShortStyle];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    self.left.text = [myFormatter stringFromDate:self.datePickerInput.date];
}
- (IBAction)dateChanged2:(id)sender {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterShortStyle];
    [df setTimeStyle:NSDateFormatterShortStyle];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    self.right.text = [myFormatter stringFromDate:self.datePickerInput.date];
}
@end
