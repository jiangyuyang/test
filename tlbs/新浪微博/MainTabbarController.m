//
//  MainTabbarController.m
//  新浪微博
//
//  Created by tarena6 on 15-4-2.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import "MainTabbarController.h"
#import "LoginViewController.h"
#import "WeiboAPI.h"
@interface MainTabbarController ()

@end

@implementation MainTabbarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBar.hidden = YES;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (![WeiboAPI getToken]) {
        LoginViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"weibo"];
        [self presentViewController:vc animated:YES completion:nil];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawerControllerDidOpen:(ICSDrawerController *)drawerController{
    self.view.userInteractionEnabled = NO;
}
- (void)drawerControllerDidClose:(ICSDrawerController *)drawerController{
    self.view.userInteractionEnabled = YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
