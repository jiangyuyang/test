//
//  MyAnnotation.h
//  Day16Map
//
//  Created by tarena on 15-4-1.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Weibo.h"
@interface MyAnnotation : NSObject<MKAnnotation>
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic,strong)Weibo *weibo;
// Title and subtitle for use by selection UI.
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

// Called as a result of dragging an annotation view.
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;
@end
