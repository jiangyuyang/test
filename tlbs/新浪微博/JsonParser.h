//
//  JsonParser.h
//  新浪微博
//
//  Created by tarena6 on 15-4-3.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonInfo.h"
#import "Weibo.h"
#import "Comment.h"
@interface JsonParser : NSObject
+(PersonInfo *)parseInfoByDic:(NSDictionary *)dic;

+(Weibo *)paseWeiboByDictionary:(NSDictionary *)dic;
+(NSMutableArray *)paseCommentByDictionary:(NSDictionary *)dic;
@end
