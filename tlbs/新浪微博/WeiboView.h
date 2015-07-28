//
//  WeiboView.h
//  新浪微博
//
//  Created by tarena6 on 15-4-7.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weibo.h"
@interface WeiboView : UIView
@property (nonatomic,strong)Weibo *weibo;
@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)UIImageView *imageView;
//转发微博View
@property (nonatomic, strong)WeiboView *relWeiboView;
@property (nonatomic,strong)NSMutableArray *IVs;
@end
