//
//  PostViewController.m
//  STDG
//
//  Created by 翟涛 on 14-3-24.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "PostViewController.h"
#import "STClient.h"

@interface PostViewController ()

@end

@implementation PostViewController

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
    CGSize size = [UIScreen mainScreen].bounds.size;
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height - 70)];
//    [webView loadHTMLString:[[[STClient sharedClient].news objectAtIndex:indexPath.row] objectForKey:@"aid"] baseURL:[NSURL fileURLWithPath: [[NSBundle mainBundle]  bundlePath]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
