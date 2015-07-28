//
//  WeiboView.m
//  新浪微博
//
//  Created by tarena6 on 15-4-7.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import "WeiboView.h"
#import "UIImageView+AFNetworking.h"
@implementation WeiboView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
-(NSMutableArray *)IVs{
    if (!_IVs) {
        _IVs = [NSMutableArray array];
    }
    return _IVs;
}
-(void)initUI{
    //添加文本控件
    self.textView = [[UITextView alloc]initWithFrame:CGRectZero];
    self.textView.userInteractionEnabled = NO;
    self.textView.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.textView];
    
    //添加图片控件
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:self.imageView];
    ////////////////////////////
//    for (int i = 0; i<self.weibo.pics.count; i++) {
//        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectZero];
//        [iv setContentMode:UIViewContentModeScaleAspectFit];
//        [self addSubview:iv];
//        [self.IVs addObject:iv];
//    }
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    float width = 300;
    CGRect frame = [self.weibo.text boundingRectWithSize:CGSizeMake(300, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
    self.textView.frame = CGRectMake(0, 0, width, frame.size.height+10);
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.text = self.weibo.text;
    if (self.weibo.thumbnailImage && ![@"" isEqualToString:self.weibo.thumbnailImage]) {
        self.imageView.hidden = NO;
        self.imageView.frame = CGRectMake(0, self.textView.frame.size.height, width, 110);
        [self.imageView setImageWithURL:[NSURL URLWithString:self.weibo.thumbnailImage]];
    }else{
        self.imageView.hidden = YES;
    }
    ////////////////////////////
//    if (self.IVs!=nil) {
//        for (int i = 0; i<self.IVs.count; i++) {
//            UIImageView *iv = self.IVs[i];
//            iv.frame = CGRectMake(i%3*80+5, 1/3*80+5, 80, 80);
//            [iv setImageWithURL:[NSURL URLWithString:self.weibo.pics[i]]];
//            [self addSubview:iv];
//        }
//    }
//    NSLog(@"%@",self.weibo.pics);
    //***************添加转发微博****************
    if (self.weibo.relWeibo) {
        //第一次需要穿件   之后直接复用
        if (!self.relWeiboView) {
            self.relWeiboView = [[WeiboView alloc]initWithFrame:CGRectZero];
            [self.relWeiboView setBackgroundColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:245/255.0 alpha:1]];
            [self addSubview:self.relWeiboView];
        }
        //复用时如果没有转发需要隐藏 有则显示出来
        self.relWeiboView.hidden = NO;
        self.relWeiboView.frame = CGRectMake(0, self.textView.frame.size.height, width, [self.relWeiboView.weibo getWeiboHeight]);
        self.relWeiboView.weibo = self.weibo.relWeibo;
    }else{
        self.relWeiboView.hidden = YES;
    }
}
@end
