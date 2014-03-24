//
//  NewsViewController.m
//  AKTabBar
//
//  Created by 翟涛 on 14-3-12.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "NewsViewController.h"
#import "STClient.h"
#import "STGategory.h"
#import <ReactiveCocoa/ReactiveCocoa/ReactiveCocoa.h>

@interface NewsViewController ()

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation NewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"News";
    }
    return self;
}

#pragma mark setTabBar image and title
- (NSString *)tabImageName
{
	return @"image-1";
}

- (NSString *)tabTitle
{
    return self.title;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGSize size = [UIScreen mainScreen].bounds.size;

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, size.width, size.height - 70)];
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

    
    [[RACObserve([STClient sharedClient], category)
        deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSArray *newarray){
        NSMutableArray * array = [[NSMutableArray alloc]init];
        for (int i = 0; i < newarray.count; i++) {
            STGategory * gategory = [newarray objectAtIndex:i];
            [array addObject:gategory.catname];
        }
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:array];
        _segmentedControl.frame = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?CGRectMake(100, 44 + 25, size.width - 200, 50.0):CGRectMake(25, 44 + 25, size.width - 50, 40.0);
        _segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
        [_segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:(UIControlEventValueChanged)];
        [self.view addSubview:_segmentedControl];
    }];
}

-(void)segmentAction:(UISegmentedControl *)Seg
{
    NSInteger index = Seg.selectedSegmentIndex;
 
    switch (index) {
        case 0:
            [[STClient sharedClient] fetchWebNews:16];
            break;
        case 1:
            [[STClient sharedClient] fetchWebNews:17];
            break;
        case 2:
            [[STClient sharedClient] fetchWebNews:18];
            break;
    }

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
    NSLog(@"%@",[[[STClient sharedClient].news objectAtIndex:indexPath.row] objectForKey:@"aid"]);
    NSLog(@"%@",[STClient sharedClient].news);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
