//
//  LoginViewController.m
//  新浪微博
//
//  Created by tarena6 on 15-4-2.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import "LoginViewController.h"
#import "WeiboAPI.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation LoginViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    NSString *appKey = @"1862206288";
    //重定向地址
    NSString *uri = @"https://api.weibo.com/oauth2/default.html";
    //加载登陆界面
    NSString *path = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",appKey,uri];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
    [self.webView loadRequest:request];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlPath = request.URL.description;
    NSLog(@"%@",urlPath);
    if ([urlPath rangeOfString:@"code="].length>0) {
        NSString *code = [[urlPath componentsSeparatedByString:@"="]lastObject];
        [WeiboAPI requestTokenWithCode:code andCallback:^(id obj) {
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:obj[0] forKey:@"token"];
            [ud setObject:obj[1] forKey:@"uid"];
            [ud synchronize];
        }];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    return YES;
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
