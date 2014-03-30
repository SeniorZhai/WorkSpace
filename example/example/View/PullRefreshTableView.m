//
//  PullRefreshTableView.m
//  example
//
//  Created by 翟涛 on 14-3-28.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "PullRefreshTableView.h"

@implementation PullRefreshTableView
@synthesize isLoading;
@synthesize isDragging;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        isDragging = NO;
        isLoading = NO;
        double width = frame.size.width;
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0,-kHeight,width,kHeight)];
        _headerLabel = [[UILabel alloc] initWithFrame:_headerView.bounds];
        _headerLabel.textAlignment = NSTextAlignmentCenter;
        _headerAI = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _headerAI.center = CGPointMake(_headerLabel.center.x - 50,_headerLabel.center.y);
        [_headerView addSubview:_headerLabel];
        [_headerView addSubview:_headerAI];
        [self addSubview:_headerView];
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0,self.contentSize.height,width,kHeight)];
        _footerLabel = [[UILabel alloc] initWithFrame:_footerView.bounds];
        _footerLabel.textAlignment = NSTextAlignmentCenter;
        _footerAI = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _footerAI.center = CGPointMake(_footerLabel.center.x - 50,_headerLabel.center.y);
        [_footerView addSubview:_footerLabel];
        [_footerView addSubview:_footerAI];
        [self addSubview:_footerView];
    }
    return self;
}

- (void)reloadData
{
    [super reloadData];
    _footerView.frame = CGRectMake(0, self.contentSize.height, self.frame.size.width, kHeight);
    [self stopRefresh];
}
// 开始拖动时回调
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (isLoading)
    {
        return;
    }
    isDragging = YES;
}
// 拖动中回调
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	if (isLoading)
	{
		return;
	}
	else if(isDragging && scrollView.contentOffset.y < 0)
	{
		[UIView beginAnimations:nil context:NULL];
		if (scrollView.contentOffset.y < kHeight)
		{
			_headerLabel.text = @"松开刷新";
		}
		else
		{
			_headerLabel.text = @"下拉可刷新";
		}
		[UIView commitAnimations];
	}
	else if (isDragging && scrollView.contentOffset.y + scrollView.frame.size.height + scrollView.contentSize.height + kHeight)
	{
		if (scrollView.contentSize.height <= 200)
		{
			return;
		}
		if (scrollView.contentOffset.y + scrollView.frame.size.height - scrollView.contentSize.height > kHeight)
		{
			_footerLabel.text = @"松开加载更多";
		}
	}
	else
	{
		if(scrollView.contentSize.height <= 200)
		{
			return;
		}
		_footerLabel.text = @"上拉可加载更多";
	}
}
// 拖动结束回调
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (isLoading)
    {
        return;
    }
    isDragging = NO;
    if (scrollView.contentOffset.y <= -kHeight)
    {
        [self refresh];
    }
    if (scrollView.contentOffset.y + scrollView.frame.size.height - scrollView.contentSize.height > kHeight)
    {
        [self loadMore];
    }
}
// 刷新动画
- (void)refresh
{
    isLoading = YES;
    // Show the header
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.8];
    self.contentInset = UIEdgeInsetsMake(kHeight, 0, 0, 0);
    _headerLabel.text = @"加载中";
    [UIView commitAnimations];
    [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:4];
}
// 加载动画
- (void)loadMore
{
    isLoading = YES;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.8];
    self.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, kHeight, 0.0f);
    _footerLabel.text = @"加载中";
    [UIView commitAnimations];
    [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:4];
}
// 停止刷新
- (void)stopRefresh
{
    isLoading = NO;
    [_headerAI stopAnimating];
    [_footerAI stopAnimating];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.8];
    self.contentInset = UIEdgeInsetsZero;
    UIEdgeInsets tableContentInset = self.contentInset;
    tableContentInset.top = 0.0;
    self.contentInset = tableContentInset;
    [UIView commitAnimations];
}
@end
