//
//  HomeViewController.h
//  example
//
//  Created by 翟涛 on 14-3-27.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshTableView.h"

@interface HomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)PullRefreshTableView* contentView;

@end
