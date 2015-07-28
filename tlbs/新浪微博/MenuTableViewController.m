//
//  MenuTableViewController.m
//  新浪微博
//
//  Created by tarena6 on 15-4-2.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import "MenuTableViewController.h"
#import "AppDelegate.h"
@interface MenuTableViewController ()
@property (nonatomic,strong)NSArray *menuTitles;
@property (nonatomic, strong)NSArray *menuImageNames;
@end

@implementation MenuTableViewController

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
    self.menuImageNames = @[@"05侧滑分栏_03.png",@"05侧滑分栏_06.png",@"05侧滑分栏_12.png",@"05侧滑分栏_14.png",@"05侧滑分栏_17.png"];
    self.menuTitles = @[@"全部话题",@"周边话题",@"好友列表",@"我的资料",@"设置"];
    
    //设置背景颜色
    self.tableView.backgroundColor = [UIColor colorWithRed:30.0/255 green:30.0/255 blue:30.0/255 alpha:1];
    [self.tableView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.menuTitles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.menuImageNames[indexPath.row]];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.textLabel.textColor = [UIColor colorWithRed:86.0/255 green:86.0/255 blue:86.0/255 alpha:1];
    //设置选中背景颜色
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.bounds];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:6.0/255 green:61.0/255 blue:209.0/255 alpha:1];
    //文本高亮颜色
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.mainVC.selectedIndex = indexPath.row;
    [app.drawerController reloadCenterViewControllerUsingBlock:nil];
    
    self.tableView.userInteractionEnabled = NO;//点两下bug
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.userInteractionEnabled = YES;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
