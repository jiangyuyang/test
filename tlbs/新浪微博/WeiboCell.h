//
//  WeiboCell.h
//  新浪微博
//
//  Created by tarena6 on 15-4-3.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weibo.h"
#import "WeiboView.h"
@interface WeiboCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nick;
@property (weak, nonatomic) IBOutlet UILabel *topicTime;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIButton *transNums;
@property (weak, nonatomic) IBOutlet UIButton *commentNum;
@property (nonatomic,strong)Weibo *weibo;
@property (nonatomic,strong)WeiboView *weiboView;
@end
