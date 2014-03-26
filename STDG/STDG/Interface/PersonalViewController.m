//
//  PersonalViewController.m
//  AKTabBar
//
//  Created by 翟涛 on 14-3-12.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "PersonalViewController.h"
#import "STClient.h"

@interface PersonalViewController ()

@end

@implementation PersonalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Personal";
    }
    return self;
}

#pragma mark setTabBar image and title
- (NSString *)tabImageName
{
	return @"tabbar_userinfo_normal";
}

- (NSString *)tabTitle
{
    return self.title;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *bgcolor = [UIColor colorWithRed:0x0e*1.0/0xff green:0x7c*1.0/0xff blue:0xd3*1.0/0xff alpha:1.0f];
    self.navigationController.navigationBar.barTintColor = bgcolor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onClick:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登入" message:@"请输入用户名和密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UITextField* nameField = [alertView textFieldAtIndex:0];
        UITextField* passwordField = [alertView textFieldAtIndex:1];
        NSDictionary* uesrInfo = [[STClient sharedClient] login:nameField.text withPassword:passwordField.text];
        int flag = [[uesrInfo objectForKey:@"code"] intValue];
        if (flag == 3) {
            self.credit_icon.hidden = NO;
            self.email_icon.hidden = NO;
            self.user_icon.hidden = NO;
            self.credit_label.hidden = NO;
            self.user_label.hidden = NO;
            self.email_label.hidden = NO;
            if ([[uesrInfo objectForKey:@"state"] intValue] == -1) {
                self.credit_label.text = @"未申请";
            }else if ([[uesrInfo objectForKey:@"state"] intValue] == 0){
                self.credit_label.text = @"未审核";
            }else{
                self.credit_label.text = @"已认证";
            }
            self.user_label.text = nameField.text;
            self.email_label.text = [uesrInfo objectForKey:@"email"];
            self.button.hidden = YES;
        }else if(flag == 2){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.alertViewStyle = UIAlertViewStyleDefault;
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户不存在" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.alertViewStyle = UIAlertViewStyleDefault;
            [alert show];
        }
    }
}
@end
