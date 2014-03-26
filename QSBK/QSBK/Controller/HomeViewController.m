//
//  HomeViewController.m
//  QSBK
//
//  Created by 翟涛 on 14-3-26.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "HomeViewController.h"

@implementation HomeViewController

@synthesize contentView;
@synthesize itemView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CGSize winSize = [UIScreen mainScreen].bounds.size;
        width = winSize.width;
        height = winSize.height;
    }
    return self;
}
- (void)loadView
{
    [super loadView];
    
    UITableView *itemView_ = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width/2, height)];
    itemView_.backgroundColor = [UIColor redColor];
    itemView = itemView_;
    [self.view addSubview:itemView_];
    
    UITableView *contentView_ = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    contentView_.backgroundColor = [UIColor yellowColor];
    contentView = contentView_;
    [self.view addSubview:contentView];
    
    UIPanGestureRecognizer *pinGesture = [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(userPinned:)];
    [self.view addGestureRecognizer: pinGesture];
    
}

- (void)userPinned:(UIGestureRecognizer *)gesture
{
    UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *) gesture;
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint velocityPoint = [panGesture translationInView:contentView];
        int x = velocityPoint.x;
       
        if (x <= width/4)
        {
            [self hiddenItemView:YES];
        }
        else
        {
            [self hiddenItemView:NO];
        }
        return;
    }
    
    CGPoint translatePoint = [panGesture translationInView:contentView];
    if (isItemViewShow)
    {
        translatePoint.x += width/2;
    }

    [self changeFrame:translatePoint];
}
- (void)changeFrame:(CGPoint)point
{
    // 滑动后将contentView左移
    if (point.x < 0)
    {
        point.x = 0;
    }
    else if (point.x > width/2)
    {
        point.x = width/2;
    }
    CGRect newFrame = CGRectMake(point.x, contentView.frame.origin.y, width, height);
    contentView.frame = newFrame;
}
- (void)hiddenItemView:(BOOL)boolean
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    // 显示
    if (boolean)
    {
        contentView.frame = CGRectMake(0, 0, width, height);
        isItemViewShow = NO;
    }
    else
    {
        contentView.frame = CGRectMake(width/2, 0, width, height);
        isItemViewShow = YES;
    }
    [UIView commitAnimations];
}

@end
