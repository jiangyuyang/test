//
//  WeiboInfoTableViewController.m
//  新浪微博
//
//  Created by tarena6 on 15-4-7.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import "WeiboInfoTableViewController.h"
#import "UIImageView+AFNetworking.h"
#import "WeiboAPI.h"
#import "CommentCell.h"
#import "JsonParser.h"
@interface WeiboInfoTableViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (nonatomic,strong)NSArray *comments;
@property (nonatomic, strong)UIToolbar *toolbar;
@property (nonatomic, strong)UITextField *sendInfoTF;
@end

@implementation WeiboInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updataUI];
    [self initToolbar];
}

-(void)updataUI{
    [self.imageView setImageWithURL:[NSURL URLWithString:self.weibo.user.avatar_large]];
    self.nameLabel.text = self.weibo.user.name;
    self.timeLabel.text = self.weibo.createDate;
    self.weiboView = [[WeiboView alloc]init];
    self.countLabel.text = [NSString stringWithFormat:@"评论 %@",self.weibo.comments_count];
    self.weiboView.frame = CGRectMake(10, 50, 300, [self.weibo getWeiboHeight]);
    self.weiboView.weibo = self.weibo;
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, 320, [self.weibo getWeiboHeight]+95);
    [self.tableView.tableHeaderView addSubview:self.weiboView];
    [WeiboAPI requestCommentsWithID:self.weibo.weiboId CallBack:^(id obj) {
        self.comments = obj;
        [self.tableView reloadData];
    }];
}
-(void)initToolbar{
    
    self.toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-45, 320, 45)];
    
    self.sendInfoTF = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, 260, 35)];
    [self.sendInfoTF setPlaceholder:@"写评论"];
    [self.sendInfoTF setBorderStyle:UITextBorderStyleBezel];
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"03话题详情_11.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(sendAction)];
    bbi.tintColor = [UIColor colorWithRed:84.0/255 green:84.0/255 blue:84.0/255 alpha:1];
    UIBarButtonItem *sendInfoBBI = [[UIBarButtonItem alloc]initWithCustomView:self.sendInfoTF];
    self.toolbar.items = @[sendInfoBBI,bbi];
    
    
    [self.navigationController.view addSubview:self.toolbar];
    //监听软键盘 事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.sendInfoTF.delegate = self;
}
//离开页面的时候把toolbar删除
-(void)viewWillDisappear:(BOOL)animated{
    [self.toolbar removeFromSuperview];
}
-(void)sendAction{
    [self.sendInfoTF resignFirstResponder];
    [WeiboAPI addCommentWithWeiboID:self.weibo.weiboId andContent:self.sendInfoTF.text andCallBack:^(id obj) {
        self.comments = [JsonParser paseCommentByDictionary:obj];
        [self.tableView reloadData];
        [WeiboAPI requestCommentsWithID:self.weibo.weiboId CallBack:^(id obj) {
            self.comments = obj;
            [self.tableView reloadData];
        }];
    }];
    
    
    
    //清空文本输入框
    self.sendInfoTF.text = @"";
}
-(void)WillChangeFrame:(NSNotification *)notif{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [value CGRectValue];
    [UIView animateWithDuration:.2 animations:^{
        CGRect frame = self.toolbar.frame;
        frame.origin.y = keyboardFrame.origin.y-45;
        self.toolbar.frame = frame;
    }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CommentCell" owner:self options:nil]lastObject];
    }
    cell.comment = self.comments[indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Comment *comment = self.comments[indexPath.row];
    
    return [comment getCommentHeight]+60;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
