//
//  ForumViewController.m
//  AKTabBar
//
//  Created by 翟涛 on 14-3-12.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "ForumViewController.h"
#import "STClient.h"
#import "SubjectViewController.h"
#import "AppMacro.h"

@interface ForumViewController ()

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ForumViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Forum";
    }
    return self;
}

#pragma mark setTabBar image and title

- (NSString *)tabImageName
{
	return @"image-2";
}
- (NSString *)tabTitle
{
	return self.title;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height - 70)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor colorWithWhite:1 alpha:0.2];
    self.tableView.pagingEnabled = YES;
    [self.view addSubview:self.tableView];
}
#pragma mark DataSource
// 显示多少分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [STClient sharedClient].forumArray.count;
}
// 显示每个分区包含多少个元素
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [[[STClient sharedClient].forumArray objectAtIndex:section] objectForKey:@"subForums"];
    return array.count;
}
// 返回单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.layer.masksToBounds = YES;
    NSArray *array = [[[STClient sharedClient].forumArray objectAtIndex:indexPath.section] objectForKey:@"subForums"];
    cell.textLabel.text = [[array objectAtIndex:indexPath.row]objectForKey:@"name"];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[STClient sharedClient].forumArray objectAtIndex:section] objectForKey:@"name"];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString * str = [[[[[STClient sharedClient].forumArray objectAtIndex:indexPath.section] objectForKey:@"subForums"] objectAtIndex:indexPath.row] objectForKey:@"id"];
    [[STClient sharedClient] fetchWebForumPosts:[str intValue]];
    SubjectViewController *subVC = [[SubjectViewController alloc] init];
    [self.navigationController pushViewController:subVC animated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
