//
//  Weibo.m
//  新浪微博
//
//  Created by tarena6 on 15-4-3.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import "Weibo.h"

@implementation Weibo
-(float)getWeiboHeight{
    //    1.拿到文本 计算文本所占高度
    //    2.如果有图片加上图片高度
    //    3.判断是否有转发 如果有转发
    //    转发微博对象也有getWeiboHeight方法
    float height = 0;
    //计算微博文本的高度
    CGRect frame = [self.text boundingRectWithSize:CGSizeMake(300, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
    height += frame.size.height;
    //加上微博图片高度
    if (self.thumbnailImage != nil && ![@"" isEqualToString:self.thumbnailImage]) {
        height += 110;
    }
    //加上转发微博的高度
    if (self.relWeibo) {
        float repostHeight = [self.relWeibo getWeiboHeight];
        height += repostHeight;
    }
    if (_isRepost == YES) {//如果有转发 多加20个像素 为了美观
        height += 10;
    }
    return height;
}

-(NSMutableArray *)pics{
    if (!_pics) {
        _pics = [NSMutableArray array];
    }
    return _pics;
}
@end
