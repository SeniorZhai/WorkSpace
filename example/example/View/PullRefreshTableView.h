//
//  PullRefreshTableView.h
//  example
//
//  Created by 翟涛 on 14-3-28.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kHeight 100
@interface PullRefreshTableView : UITableView

@property (nonatomic,assign) BOOL isLoading;
@property (nonatomic,assign) BOOL isDragging;
@property (nonatomic,retain) UIView *headerView;
@property (nonatomic,retain) UIView *footerView;
@property (nonatomic,retain) UILabel *headerLabel;
@property (nonatomic,retain) UILabel *footerLabel;
@property (nonatomic,retain) UIActivityIndicatorView *headerAI;
@property (nonatomic,retain) UIActivityIndicatorView *footerAI;

@end
