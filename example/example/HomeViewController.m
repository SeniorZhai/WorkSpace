//
//  HomeViewController.m
//  example
//
//  Created by 翟涛 on 14-3-27.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "HomeViewController.h"
#import "ContentCell.h"
#import "Content.h"

@interface HomeViewController ()

@property (nonatomic,strong)NSMutableData *data;
@property (nonatomic,assign)NSInteger page;

@end

@implementation HomeViewController
@synthesize page;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _data = [[NSMutableData alloc] init];
        _qiushi = [[NSMutableArray alloc] initWithCapacity:20];
        page = 1;
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
    //
    //step 1:请求地址
    NSURL *url = [NSURL URLWithString:LastestURLString(30,page)];
    //step 2:实例化一个request
    NSURLRequest *requrst = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    //step 3：创建链接
    _connection = [[NSURLConnection alloc] initWithRequest:requrst delegate:self];
    if (_connection) {
       // NSLog(@"链接成功");
    }else {
       // NSLog(@"链接失败");
    }
    
}

#pragma mark- NSUrlConnectionDelegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //接受一个服务端回话，再次一般初始化接受数据的对象
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //连接结束
    id json = [NSJSONSerialization JSONObjectWithData:_data options:kNilOptions error:nil];
    NSArray* items = [json objectForKey:@"items"];
    for (NSDictionary* item in items) {
        Content* content = [[Content alloc]initWithDictionnary:item];
        [_qiushi addObject:content];
    }
    [_contentView reloadData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //链接错误
}

#pragma mark TableView_Delegate
// 返回单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    CGFloat offSet = 10;
    static NSString *CellIdentifier = @"AppInfo";
    ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (! cell) {
        cell = [[ContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Content* content = [_qiushi objectAtIndex:indexPath.row];
    
    cell.icon.image = [UIImage imageNamed:@"thumb_pic"];
    cell.icon.frame = CGRectMake(40, height+40, 64, 64);
    height += 40 + cell.icon.frame.size.height;
    
    cell.name.text = content.user.userName;
    cell.name.frame = CGRectMake(114, 74, 80, 30);
    
    cell.content.text = content.content;
    cell.content.frame = CGRectMake(40,height, kDeviceWidth - 120, 0);
    cell.content.numberOfLines = 0;
    cell.content.lineBreakMode = NSLineBreakByWordWrapping;
    [cell.content sizeToFit];
    height += cell.content.frame.size.height+20;

    if ((NSNull *)content.image != [NSNull null]) {

        NSURL *url = [[NSURL alloc] initWithString: ImageURLSmallString([content.aid substringToIndex:4], content.aid, content.image)];
        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
        cell.image.image = image;
        cell.image.frame = CGRectMake(40, height, image.size.width, image.size.height);
        cell.image.hidden = NO;
        height += image.size.height + 20;
    }else{
        cell.image.hidden = YES;
    }
    cell.background.frame = CGRectMake(0, 0, kDeviceWidth, height+20);
    cell.background.image = [[UIImage imageNamed:@"block_background"]stretchableImageWithLeftCapWidth:0 topCapHeight:10];
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
    return _qiushi.count;
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

@end