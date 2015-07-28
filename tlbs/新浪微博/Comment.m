//
//  Comment.m
//  新浪微博
//
//  Created by tarena6 on 15-4-7.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import "Comment.h"

@implementation Comment
-(float)getCommentHeight{
    float height = 0;
    CGRect fream = [self.text boundingRectWithSize:CGSizeMake(200, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    height += fream.size.height;
    return height;
}
@end
