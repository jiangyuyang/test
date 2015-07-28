//
//  WeiboAPI.h
//  微博
//
//  Created by tarena6 on 15-4-1.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^MyCallback)(id obj);
@interface WeiboAPI : NSObject
+(void)requestTokenWithCode:(NSString *)code andCallback:(MyCallback)callback;
+(NSString *)getToken;
+(void)sendWeiboWithParams:(NSDictionary *)params andCallback:(MyCallback)callback;
+(void)sendWeiboWithText:(NSString *)text andImageData:(NSData *)imageData andCallback:(MyCallback)callback;
+(void)requestPersonInfoCallback:(MyCallback)callback;
+(void)requestTimelineWithUserID:(NSString *)openID andCallBack:(MyCallback)callback;
+(void)requestAllWeiboCallBack:(MyCallback)callback;
+(void)requestCommentsWithID:(NSString *)weiboID CallBack:(MyCallback)callback;
+(void)addCommentWithWeiboID:(NSString *)weiboID andContent:(NSString *)content andCallBack:(MyCallback)callback;
+(void)requestAllPlaceWeiboWithParams:(NSDictionary *)params AndCallBack:(MyCallback)callback;
@end
