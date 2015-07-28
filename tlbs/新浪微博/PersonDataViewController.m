//
//  PersonDataViewController.m
//  新浪微博
//
//  Created by tarena6 on 15-4-2.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import "PersonDataViewController.h"
#import "WeiboAPI.h"
#import "PersonInfo.h"
#import "UIImageView+AFNetworking.h"
#import "WeiboCell.h"
@interface PersonDataViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *LocationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerIV;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *screen_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel2;
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong)NSArray *weibos;
@end

@implementation PersonDataViewController

- (IBAction)tableHidden:(UIButton *)sender {
    if (sender.tag==0) {
        self.tableView.hidden = YES;
    }else{
        self.tableView.hidden = NO;
        //    请求个人话题
        [WeiboAPI requestTimelineWithUserID:[[NSUserDefaults standardUserDefaults]objectForKey:@"uid"] andCallBack:^(id obj) {
            self.weibos = obj;
            [self.tableView reloadData];
        }];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.tableView.hidden = YES;
    [self updataUI];
}

-(void)updataUI{
    [WeiboAPI requestPersonInfoCallback:^(id obj) {
        PersonInfo *p = obj;
        self.nameLabel.text = p.name;
        self.Name.text = p.name;
        self.genderLabel.text = p.gender;
        [self.headerIV setImageWithURL:[NSURL URLWithString:p.avatar_large]];
        self.LocationLabel.text = p.location;
        self.screen_nameLabel.text = p.screen_name;
        self.descriptionLabel.text = p.des;
        self.descriptionLabel2.text = p.des;
        self.dateLabel.text = @"无";
    }];
}
- (IBAction)goBack:(UIButton *)sender {
    
}
#pragma matk - 我的话题 TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.weibos.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"WeiboCell" owner:self options:nil]lastObject];
    }
    cell.weibo = self.weibos[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Weibo *weibo = self.weibos[indexPath.row];
    
    return [weibo getWeiboHeight]+130;
}
@end
