//
//  PersonInfo.h
//  新浪微博
//
//  Created by tarena6 on 15-4-3.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonInfo : NSObject
@property (nonatomic,copy)NSString *screen_name;//昵称
@property (nonatomic,copy)NSString *name;//友好显示名称
@property (nonatomic,copy)NSString *gender;//性别
@property (nonatomic,copy)NSString *avatar_large;//头像
@property (nonatomic,copy)NSString *location;
@property (nonatomic,copy)NSString *des;

@end
