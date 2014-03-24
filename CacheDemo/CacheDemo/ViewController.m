//
//  ViewController.m
//  CacheDemo
//
//  Created by 翟涛 on 14-3-24.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _index = 0;
    _array = [[NSArray alloc]initWithObjects:@"http://img.hb.aicdn.com/35a33dc5ebeb84198a0499a9097c0ee412b66cbc1af20-K92AeE_fw658",@"http://img.hb.aicdn.com/0d625a765823ea4a00e151da149fee1a171faf9710f6c-7BUvqD_fw658",@"http://img.hb.aicdn.com/7d11f1e845837a687189399da8409d74e3fcfb02ca38-VwTSTb_fw658",@"http://img.hb.aicdn.com/97d2194c1607454e116b58a787cb40c5acc1d79612cb6-vuBwSS_fw658",nil];
    
	self.imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    [self.view addSubview:self.imageView];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)tapped{
    NSLog(@"tapped");
    if (_index >= _array.count) {
        _index = 0;
    }
    [self loadImageFromURL:[_array objectAtIndex:_index]];
    _index++;
}

- (void) loadImageFromURL:(NSString*)URL {
	NSURL *imageURL = [NSURL URLWithString:URL];
	NSString *key = [URL MD5Hash];
    NSLog(@"%@",key);
	NSData *data = [ZTCache objectForKey:key];
    // 如果存在将data传入imageView，否则添加一个异步任务
	if (data) {
		UIImage *image = [UIImage imageWithData:data];
		_imageView.image = image;
	} else {
		_imageView.image = [UIImage imageNamed:@"img_def"];
		dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
		dispatch_async(queue, ^{
			NSData *data = [NSData dataWithContentsOfURL:imageURL];
			[ZTCache setObject:data forKey:key];
			UIImage *image = [UIImage imageWithData:data];
			dispatch_sync(dispatch_get_main_queue(), ^{
				_imageView.image = image;
			});
		});
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
