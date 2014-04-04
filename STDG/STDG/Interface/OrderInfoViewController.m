//
//  OrderInfoViewController.m
//  STDG
//
//  Created by 翟涛 on 14-3-27.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "OrderInfoViewController.h"
#import "AppMacro.h"
@interface OrderInfoViewController ()
@property (nonatomic,strong) NSDateFormatter * myFormatter;
@property (nonatomic,strong) NSMutableData* data;
@property (nonatomic,strong) NSMutableArray* infos;
@property (nonatomic,strong) NSURLConnection* connection;

@property (nonatomic,assign) int aid;
@end

@implementation OrderInfoViewController
@synthesize myFormatter;
- (id)initWithId:(int)aid
{
    if([super init])
    {
        self.aid = aid;
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        myFormatter = [[NSDateFormatter alloc]init];
        myFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [myFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return self;
}
#pragma mark
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [((UIView*)obj) resignFirstResponder];
    }];
}

#pragma mark

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.left.inputView = self.datePickerInput;
    self.right.inputView = self.datePickerInput2;
    self.right.text = [myFormatter stringFromDate:[NSDate date]];
    self.left.text = [myFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-3600*24*7]] ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)bn:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefaults stringForKey:@"username"];
    NSString *urlStr = [NSString stringWithFormat:STCLIENT_ORDERINFO,self.aid,userName,[self.right.text stringByReplacingOccurrencesOfString:@" "withString:@""],[self.left.text stringByReplacingOccurrencesOfString:@" " withString:@""],1];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
  
    // 状态请求
    NSLog(@"%@\n%@",urlStr,url);
    NSURLResponse *response;
    
    // 链接一个请求
   
    NSData *resultData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
   
    // 返回数据转为字符串
    
//    NSString *dataString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:resultData options:kNilOptions error:nil];
    _infos = [json objectForKey:@"orderlist"];
    NSLog(@"%@", _infos);

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (IBAction)dateChanged:(id)sender {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterShortStyle];
    [df setTimeStyle:NSDateFormatterShortStyle];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    self.left.text = [myFormatter stringFromDate:self.datePickerInput.date];
}
- (IBAction)dateChanged2:(id)sender {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterShortStyle];
    [df setTimeStyle:NSDateFormatterShortStyle];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    self.right.text = [myFormatter stringFromDate:self.datePickerInput.date];
}
@end
