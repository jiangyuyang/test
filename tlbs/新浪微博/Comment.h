//
//  Comment.h
//  新浪微博
//
//  Created by tarena6 on 15-4-7.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonInfo.h"
@interface Comment : NSObject
@property(nonatomic,strong)NSString *created_at;
@property(nonatomic,strong)NSString *text;
@property(nonatomic,strong)PersonInfo *user;
-(float)getCommentHeight;
@end
