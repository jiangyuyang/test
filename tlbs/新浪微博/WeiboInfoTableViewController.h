//
//  WeiboInfoTableViewController.h
//  新浪微博
//
//  Created by tarena6 on 15-4-7.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weibo.h"
#import "WeiboView.h"
@interface WeiboInfoTableViewController : UITableViewController<UITextFieldDelegate>
@property (nonatomic,strong)Weibo *weibo;
@property (nonatomic,strong)WeiboView *weiboView;
@end
