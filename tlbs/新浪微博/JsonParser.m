//
//  JsonParser.m
//  新浪微博
//
//  Created by tarena6 on 15-4-3.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import "JsonParser.h"
#import "PersonInfo.h"
#import "Comment.h"
@implementation JsonParser
+(PersonInfo *)parseInfoByDic:(NSDictionary *)dic{
    PersonInfo *p = [[PersonInfo alloc]init];
    p.name = [dic objectForKey:@"name"];
    p.screen_name = [dic objectForKey:@"screen_name"];
    
    NSString *gender = [dic objectForKey:@"gender"];
    if ([gender isEqualToString:@"m"]) {
        gender = @"男";
    }else if([gender isEqualToString:@"f"]){
        gender = @"女";
    }else{
        gender = @"未知";
    }
    
    p.gender = gender;
    p.avatar_large = [dic objectForKey:@"avatar_large"];
    p.location = [dic objectForKey:@"location"];
    p.des = [dic objectForKey:@"description"];
    
//    @property (nonatomic,copy)NSString *screen_name;//昵称
//    @property (nonatomic,copy)NSString *name;//友好显示名称
//    @property (nonatomic,copy)NSString *gender;//性别
//    @property (nonatomic,copy)NSString *profile_image_url;//头像
//    @property (nonatomic,copy)NSString *location;
//    @property (nonatomic,copy)NSString *description;
    return p;
}
//解析微博对象
+(Weibo *)paseWeiboByDictionary:(NSDictionary *)dic{
    Weibo *myWeibo = [[Weibo alloc]init];
    myWeibo.createDate = [JsonParser fomateString:[dic objectForKey:@"created_at"]];
    
    myWeibo.text = [dic objectForKey:@"text"];
    
    myWeibo.source = [dic objectForKey:@"source"];
    myWeibo.reposts_count = [NSString stringWithFormat:@"%@",[dic objectForKey:@"reposts_count"]];
    myWeibo.comments_count = [NSString stringWithFormat:@"%@",[dic objectForKey:@"comments_count"]];
    NSDictionary *locationDic = [dic objectForKey:@"geo"];
    if (locationDic&&![locationDic isMemberOfClass:[NSNull class]]) {
        NSArray *coordArr = [locationDic objectForKey:@"coordinates"];
        CLLocationCoordinate2D coord;
        coord.latitude = [coordArr[0] doubleValue];
        coord.longitude = [coordArr[1]doubleValue];
        myWeibo.coord = coord;
        
    }
    myWeibo.longitude = [dic objectForKey:@"long"];
    myWeibo.latitude = [dic objectForKey:@"lat"];
    
    myWeibo.thumbnailImage = [dic objectForKey:@"bmiddle_pic"];//中等图片
    NSArray *pic_urls = [dic objectForKey:@"pic_urls"];
    for (NSDictionary *dic in pic_urls) {
        NSString *url = [dic objectForKey:@"thumbnail_pic"];
        [myWeibo.pics addObject:url];
    }
    //NSLog(@"%@",myWeibo.pics);
    id weiboID  = [dic objectForKey:@"id"];
    myWeibo.weiboId = [NSString stringWithFormat:@"%@",weiboID];
    //获取用户信息
    NSDictionary *userDic = [dic objectForKey:@"user"];
    PersonInfo *userInfo = [JsonParser parseInfoByDic:userDic];
    myWeibo.user = userInfo;
    
    NSDictionary *reWeiboDic = [dic objectForKey:@"retweeted_status"];
    //判断是否有转发
    if (reWeiboDic && ![reWeiboDic isMemberOfClass:[NSNull class]]) {
        
        //如果发现有转发 调用自身
        myWeibo.relWeibo = [JsonParser paseWeiboByDictionary:reWeiboDic];
        myWeibo.relWeibo.isRepost = YES;
    }
    return myWeibo;
}
//获取评论信息
+(NSMutableArray *)paseCommentByDictionary:(NSDictionary *)dic{
    NSArray *commntsDic = [dic objectForKey:@"comments"];
    NSMutableArray *comments = [NSMutableArray array];
    for (NSDictionary *dic in commntsDic) {
        Comment *comment = [[Comment alloc]init];
        comment.text = [dic objectForKey:@"text"];
        //获取用户信息
        NSDictionary *userDic = [dic objectForKey:@"user"];
        PersonInfo *userinfo = [JsonParser parseInfoByDic:userDic];
        comment.user = userinfo;
        comment.created_at = [JsonParser fomateString:[dic objectForKey:@"created_at"]];
        [comments addObject:comment];
    }
    
    return comments;
}
//转换时间格式
+ (NSString *)fomateString:(NSString *)datestring {
    NSString *formatString = @"E MMM d HH:mm:ss Z yyyy";
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:formatString];
    NSDate *date = [format dateFromString:datestring];
    formatString = @"MM-dd HH:mm";
    [format setDateFormat:formatString];
    
    return [format stringFromDate:date];
}
@end
