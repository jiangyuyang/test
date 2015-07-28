//
//  MyannotationView.h
//  新浪微博
//
//  Created by tarena6 on 15-4-9.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "Weibo.h"
@interface MyannotationView : MKAnnotationView
@property (nonatomic,strong)Weibo *weibo;
@end
