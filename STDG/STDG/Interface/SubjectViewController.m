//
//  SubjectViewController.m
//  STDG
//
//  Created by 翟涛 on 14-3-14.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "SubjectViewController.h"
#import "STClient.h"

@interface SubjectViewController ()

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation SubjectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *bgcolor = [UIColor colorWithRed:0x0e*1.0/0xff green:0x7c*1.0/0xff blue:0xd3*1.0/0xff alpha:1.0f];
    self.navigationController.navigationBar.barTintColor = bgcolor;
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height - 70)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor colorWithWhite:1 alpha:0.2];
    self.tableView.pagingEnabled = YES;
    [self.view addSubview:self.tableView];
    
    [[RACObserve([STClient sharedClient],postTitles)
     deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSArray *newForecast){
        [self.tableView reloadData];
    }];
}
#pragma mark DataSource

// 返回单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Subject";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.layer.masksToBounds = YES;
    NSString *str = [[[STClient sharedClient].postTitles objectAtIndex:indexPath.row] objectForKey:@"subject"];
    cell.textLabel.text = str;
    return cell;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [STClient sharedClient].postTitles.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
    NSLog(@"%@",[[[STClient sharedClient].postTitles objectAtIndex:indexPath.row] objectForKey:@"id"]);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
