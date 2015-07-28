//
//  WeiboAPI.m
//  微博
//
//  Created by tarena6 on 15-4-1.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import "WeiboAPI.h"
#import "AFNetworking.h"
#import "JsonParser.h"
#import "PersonInfo.h"
#import "Comment.h"
typedef void (^MyCallback)(id obj);
@implementation WeiboAPI
+(void)requestTokenWithCode:(NSString *)code andCallback:(MyCallback)callback{
    NSString *path = @"https://api.weibo.com/oauth2/access_token";
    NSDictionary *params = @{@"client_id":@"4206385643",@"client_secret":@"170cf8b41285989882f45ecf02ff2e58",@"grant_type":@"authorization_code",@"code":code,@"redirect_uri":@"https://api.weibo.com/oauth2/default.html"};
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    [manger setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manger POST:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"请求成功");
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSString *token = [dic objectForKey:@"access_token"];
        NSString *uid = [dic objectForKey:@"uid"];

        callback(@[token,uid]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
}
//普通文本微博
+(void)sendWeiboWithParams:(NSDictionary *)params andCallback:(MyCallback)callback{
    NSString *path = @"https://api.weibo.com/2/statuses/update.json";
    //NSDictionary *params = @{@"access_token":[WeiboAPI getToken],@"status":text};
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    [manger setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manger POST:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"请求成功");
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        callback(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
}
//带图微博
+(void)sendWeiboWithText:(NSString *)text andImageData:(NSData *)imageData andCallback:(MyCallback)callback{
    NSString *path = @"https://api.weibo.com/2/statuses/upload.json";
    NSDictionary *params = @{@"access_token":[WeiboAPI getToken],@"status":text};
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    [manger setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manger POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"pic" fileName:@"aaa.jpg" mimeType:@"image/jpg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        callback(dic);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发送带图微博失败");
    }];
}
//获取个人资料
+(void)requestPersonInfoCallback:(MyCallback)callback{
    NSString *path = @"https://api.weibo.com/2/users/show.json";
    NSString *uid = [[NSUserDefaults standardUserDefaults]objectForKey:@"uid"];
    NSDictionary *parmas = @{@"uid":uid,@"access_token":[WeiboAPI getToken]};
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    [manger setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manger GET:path parameters:parmas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        PersonInfo *p = [JsonParser parseInfoByDic:dic];
        callback (p);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"qingqiushibai");
    }];
    
}
//获取个人话题
+(void)requestTimelineWithUserID:(NSString *)openID andCallBack:(MyCallback)callback{
    
    
    NSString *path = @"https://api.weibo.com/2/statuses/user_timeline.json";
    NSDictionary *params = @{@"access_token": [WeiboAPI getToken],@"uid":openID,};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    
    [manager GET:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSArray *weibosDic = [dic objectForKey:@"statuses"];
        
        NSMutableArray *weibos = [NSMutableArray array];
        for (NSDictionary *weiboDic in weibosDic) {
            Weibo *w = [JsonParser paseWeiboByDictionary:weiboDic];
            [weibos addObject:w];
        }
        callback(weibos);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发送失败");
    }];
    
}
+(NSString *)getToken{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
}
//获取全部话题
+(void)requestAllWeiboCallBack:(MyCallback)callback{
    NSString *path = @"https://api.weibo.com/2/statuses/home_timeline.json";
    NSDictionary *params = @{@"access_token": [WeiboAPI getToken]};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    
    [manager GET:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSArray *weibosDic = [dic objectForKey:@"statuses"];
        
        NSMutableArray *weibos = [NSMutableArray array];
        for (NSDictionary *weiboDic in weibosDic) {
            Weibo *w = [JsonParser paseWeiboByDictionary:weiboDic];
            [weibos addObject:w];
        }
        callback(weibos);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发送失败");
    }];
}
//获取评论
+(void)requestCommentsWithID:(NSString *)weiboID CallBack:(MyCallback)callback{
    NSString *path = @"https://api.weibo.com/2/comments/show.json";
    NSDictionary *params = @{@"access_token": [WeiboAPI getToken],@"id":weiboID};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    
    [manager GET:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSArray *comments = [JsonParser paseCommentByDictionary:dic];
        callback (comments);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发送失败");
    }];

}
+(void)addCommentWithWeiboID:(NSString *)weiboID andContent:(NSString *)content andCallBack:(MyCallback)callback{
    NSString *path = @"https://api.weibo.com/2/comments/create.json";
    NSDictionary *params = @{@"access_token": [WeiboAPI getToken],@"comment":content,@"id":weiboID};
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    
    [manager POST:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            callback(dic);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发送评论失败");
    }];
    
}
//获取周边话题
+(void)requestAllPlaceWeiboWithParams:(NSDictionary *)params AndCallBack:(MyCallback)callback{
    NSString *path = @"https://api.weibo.com/2/place/nearby_timeline.json";
    //NSDictionary *params = @{@"access_token": [WeiboAPI getToken]};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    
    [manager GET:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSArray *weibosDic = [dic objectForKey:@"statuses"];
        
        NSMutableArray *weibos = [NSMutableArray array];
        for (NSDictionary *weiboDic in weibosDic) {
            Weibo *w = [JsonParser paseWeiboByDictionary:weiboDic];
            [weibos addObject:w];
        }
        callback(weibos);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发送失败......");
    }];
}
@end
