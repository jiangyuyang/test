//
//  WeiboCell.m
//  新浪微博
//
//  Created by tarena6 on 15-4-3.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import "WeiboCell.h"
#import "UIImageView+AFNetworking.h"
@implementation WeiboCell
//通过纯代码创建自定义的控件的时候调用此方法
//-(id)initWithFrame:(CGRect)frame
//通过storyboard或xib创建控件时调用此方法 此时子控件没有初始化  为nil
//-(id)initWithCoder:(NSCoder *)aDecoder
//通过storyboard或xib创建控件时调用此方法 此时子控件有值
//-(void)awakeFromNib
- (void)awakeFromNib
{
    self.weiboView = [[WeiboView alloc]initWithFrame:CGRectZero];
    [self addSubview:self.weiboView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.nick.text = self.weibo.user.name;
    self.topicTime.text = self.weibo.createDate;
    self.address.text = self.weibo.user.location;
    [self.commentNum setTitle:[NSString stringWithFormat:@" %@",self.weibo.comments_count] forState:UIControlStateNormal];
    [self.transNums setTitle:[NSString stringWithFormat:@" %@",self.weibo.reposts_count] forState:UIControlStateNormal];
    
    [self.headImageView setImageWithURL:[NSURL URLWithString:self.weibo.user.avatar_large]];
    //更新每一条微博的高度
    self.weiboView.frame = CGRectMake(10, 45, 300, [self.weibo getWeiboHeight]);
    self.weiboView.weibo = self.weibo;
}
@end
