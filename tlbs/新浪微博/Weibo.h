//
//  Weibo.h
//  新浪微博
//
//  Created by tarena6 on 15-4-3.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonInfo.h"
#import <MapKit/MapKit.h>
@interface Weibo : NSObject
@property (nonatomic)BOOL isRepost;//是转发的微博
@property (nonatomic)CLLocationCoordinate2D coord;
@property(nonatomic,copy)NSString           *createDate;        //微博的创建时间
@property(nonatomic,copy)NSString           *weiboId;           //微博id
@property(nonatomic,copy)NSString           *text;              //微博内容
@property(nonatomic,copy)NSString           *source;            //微博来源
@property(nonatomic,copy)NSString           *thumbnailImage;    //缩略图片地址，没有时不返回此字段

@property(nonatomic,strong)Weibo       *relWeibo;          //被转发的原微博
@property(nonatomic,strong)PersonInfo        *user;              //微博的作者用户
@property (nonatomic, copy)NSString *location;
//微博经纬度
@property(nonatomic,copy)NSString *latitude;
@property(nonatomic,copy)NSString *longitude;

@property (nonatomic, copy)NSString *reposts_count;
@property (nonatomic, copy)NSString *comments_count;
@property (nonatomic, strong)NSMutableArray *pics;
-(float)getWeiboHeight;
@end
