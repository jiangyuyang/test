//
//  MapViewController.h
//  新浪微博
//
//  Created by tarena6 on 15-4-9.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "NewSendViewController.h"
@interface MapViewController : UIViewController<MKMapViewDelegate>
@property (nonatomic,weak)NewSendViewController *delegate;

@end
