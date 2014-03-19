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
    
//    [RACObserve([STClient sharedClient], obj) subscribeNext:^(NSArray *array){
//
//        NSMutableArray *newArray = [[NSMutableArray alloc]init];
//        for (int i = 0; i < array.count; i ++) {
//            NSDictionary *dic = array[i];
//            [newArray addObject:[dic objectForKey:@"catname"]];
//        }
//        NSArray *segmentedArray = [[NSArray alloc]initWithArray:newArray];
//        _segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
//        _segmentedControl.frame = CGRectMake(100, 44 + 25, size.width - 200, 50.0);
//        _segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
//        [self.view addSubview:_segmentedControl];
//    }];
//    [_segmentedControl addTarget:self action:@selector(segmentAction) forControlEvents:UIControlEventValueChanged];

    
//    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 40 + 25, size.width, 50.0)];
//    toolBar.barStyle = UIBarStyleDefault;
//    [self.view addSubview:toolBar];
//    UIBarButtonItem *item1    = [[UIBarButtonItem alloc]initWithTitle:@"活动公告" style:UIBarButtonItemStylePlain target:self action:nil];
//    UIBarButtonItem *item2    = [[UIBarButtonItem alloc]initWithTitle:@"开发动态" style:UIBarButtonItemStylePlain target:self action:nil];
//    UIBarButtonItem *item3    = [[UIBarButtonItem alloc]initWithTitle:@"行业咨询" style:UIBarButtonItemStylePlain target:self action:nil];
//    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    NSArray *items            = @[flexItem,item1,flexItem,item2,flexItem,item3,flexItem];
//    [toolBar setItems:items animated:YES];
    
 
    
    _view1 = [[AfficheViewController alloc] init];
    [self.view insertSubview:_view1.view atIndex:0];
    
    _view2 = [[DynamicViewController alloc] init];

    _view3 =[[IndustryViewController alloc] init];
    
    [[RACObserve([STClient sharedClient], category)
        deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSArray *newarray){
//        NSArray *array = [[NSArray alloc] initWithObjects:[[[STClient sharedClient].category objectAtIndex:0] objectForKey:@"catname"] ,[[[STClient sharedClient].category objectAtIndex:1] objectForKey:@"catname"],[[[STClient sharedClient].category objectAtIndex:2] objectForKey:@"catname"],nil];
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
            [self.view insertSubview:_view1.view atIndex:0];
            [self.view2.view removeFromSuperview];
            [self.view3.view removeFromSuperview];
            break;
        case 1:
            [self.view insertSubview:_view2.view atIndex:0];
            [self.view1.view removeFromSuperview];
            [self.view3.view removeFromSuperview];
            break;
        case 2:
            [self.view insertSubview:_view3.view atIndex:0];
            [self.view2.view removeFromSuperview];
            [self.view1.view removeFromSuperview];
            break;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
