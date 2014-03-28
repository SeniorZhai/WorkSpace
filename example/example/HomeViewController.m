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
    self.contentView = [[PullRefreshTableView alloc]initWithFrame:CGRectMake(10, 20, kDeviceWidth - 40, KDeviceHeight - 90)];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.contentView.dataSource = self;
    self.contentView.delegate = self;
    [self.contentView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.contentView];
}

// 返回单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    double height = 0;
    static NSString *CellIdentifier = @"AppInfo";
    ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (! cell) {
        cell = [[ContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.icon.image = [UIImage imageNamed:@"thumb_pic"];
    cell.icon.frame = CGRectMake(40, height+40, 64, 64);
    height += 104;
    cell.name.text = @"用户名";
    cell.name.frame = CGRectMake(114, 74, 80, 30);
    cell.content.text = @"从认识到现在4年了，委屈过，失望过，但从没放弃过，年前我家人也带他见过，父母为了我没敢说个不字，为了他，甚至和亲哥哥都闹翻了，前段时间为了见他父母的事一直吵架，一直不肯让我见，今天才发现他和我最好的闺蜜好上了，突然自己变成了小三，现在想死的心都有了";
    cell.content.frame = CGRectMake(40,height, kDeviceWidth - 120, 0);
    cell.content.numberOfLines = 0;
    cell.content.lineBreakMode = NSLineBreakByWordWrapping;
    [cell.content sizeToFit];
    height += cell.content.frame.size.height+20;
   
    cell.image.frame = CGRectMake(0, 0, kDeviceWidth, height+20);
    cell.image.image = [[UIImage imageNamed:@"block_background"]stretchableImageWithLeftCapWidth:0 topCapHeight:10];
    cell.frame = CGRectMake(0, 0, kDeviceWidth, height+20);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
// cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
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