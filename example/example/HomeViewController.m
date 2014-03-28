//
//  HomeViewController.m
//  example
//
//  Created by 翟涛 on 14-3-27.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "HomeViewController.h"
#import "ContentCell.h"


@interface HomeViewController ()

@end

@implementation HomeViewController

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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bar_background"] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background"]];
    self.contentView = [[PullRefreshTableView alloc]initWithFrame:CGRectMake(20, 20, kDeviceWidth - 40, KDeviceHeight - 90)];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.contentView.dataSource = self;
    self.contentView.delegate = self;
    [self.contentView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.contentView];
}

// 返回单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AppInfo";
    double height = 20;
    ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (! cell) {
        cell = [[ContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.content.numberOfLines = 0;
    cell.content.frame = CGRectMake(10, 10, 640, 2000);
    cell.content.text = @"新人第一次，不会歌…。\n今天看见朋友发空间心情，亲人去世，心情各种不好，本想评论节哀，，，没错，就是你想的那样，我特么点了个“赞”，，，背后一股淫风………";
    [cell.content sizeToFit];
  
    height += cell.content.frame.size.height;

    cell.image.image = [UIImage imageNamed:@"block_background"];
    cell.image.frame = CGRectMake(0, 0, kDeviceWidth, height+20);
    
    cell.frame = CGRectMake(0, 0, kDeviceWidth, height+20);
    

    return cell;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

// Pull操作
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_contentView performSelector:@selector(scrollViewDidScroll:) withObject:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_contentView performSelector:@selector(scrollViewWillBeginDragging:) withObject:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_contentView.isLoading)
    {
        return;
    }
    _contentView.isDragging = NO;
    // 下滑刷新
    if (scrollView.contentOffset.y <= -100)
    {
        
    }
    // 下滑加载
    if (scrollView.contentOffset.y + scrollView.frame.size.height - scrollView.contentSize.height > 100)
    {
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end