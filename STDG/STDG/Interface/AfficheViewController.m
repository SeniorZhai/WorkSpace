//
//  AfficheViewController.m
//  STDG
//
//  Created by 翟涛 on 14-3-13.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "AfficheViewController.h"
#import "STClient.h"
#import "ContentViewController.h"

@interface AfficheViewController ()

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation AfficheViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[STClient sharedClient] fetchWebNews:17];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, size.width, size.height - 70)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor colorWithWhite:1 alpha:0.2];
    self.tableView.pagingEnabled = YES;
    [self.view addSubview:self.tableView];
    [[RACObserve([STClient sharedClient],news)
      deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSArray *newForecast){
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark DataSource
#pragma mark DataSource

// 返回单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"News";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.layer.masksToBounds = YES;
    NSString *title = [[[STClient sharedClient].news objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.textLabel.text = title;
    NSString *summary = [[[STClient sharedClient].news objectAtIndex:indexPath.row] objectForKey:@"summary"];
    cell.detailTextLabel.text = summary;
    cell.layer.cornerRadius = 12;
    cell.layer.masksToBounds = YES;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [STClient sharedClient].news.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int aid = [[[[STClient sharedClient].news objectAtIndex:indexPath.row] objectForKey:@"aid"] intValue];
    [[STClient sharedClient] fetchWebNewContent:(aid)];
    ContentViewController *content = [[ContentViewController alloc] init];
    [super.navigationController pushViewController:content animated:NO];
    NSLog(@"%@",[[[STClient sharedClient].news objectAtIndex:indexPath.row] objectForKey:@"aid"]);
}


@end
