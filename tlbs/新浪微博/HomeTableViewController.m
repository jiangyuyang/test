//
//  HomeTableViewController.m
//  新浪微博
//
//  Created by tarena6 on 15-4-2.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import "HomeTableViewController.h"
#import "AppDelegate.h"
#import "WeiboAPI.h"
#import "WeiboCell.h"
#import "UIImageView+AFNetworking.h"
#import "Weibo.h"
#import "WeiboInfoTableViewController.h"
@interface HomeTableViewController ()
@property (nonatomic,strong)NSArray *weibos;
@end

@implementation HomeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [WeiboAPI requestAllWeiboCallBack:^(id obj) {
        self.weibos = obj;
        [self.tableView reloadData];
    }];
}
- (IBAction)sendAction:(UIBarButtonItem *)sender {
    
}
- (IBAction)menuAction:(UIBarButtonItem *)sender {
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app.drawerController open];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.weibos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identfier = @"cell";
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"WeiboCell" owner:self options:nil] lastObject];
    }
    cell.weibo = self.weibos[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Weibo *weibo = self.weibos[indexPath.row];
    
    return [weibo getWeiboHeight]+130;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"cellSegue" sender:self.weibos[indexPath.row]];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"cellSegue"]) {
        WeiboInfoTableViewController *vc = segue.destinationViewController;
        vc.weibo = sender;
    }
}


@end
