//
//  ZBMapViewController.m
//  新浪微博
//
//  Created by tarena6 on 15-4-9.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import "ZBMapViewController.h"
#import "MyAnnotation.h"
#import "WeiboAPI.h"
#import "Weibo.h"
#import "MyannotationView.h"
#import "WeiboCell.h"
@interface ZBMapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong)NSMutableDictionary *params;
@property (nonatomic,strong)WeiboCell *weiboCell;
@end

@implementation ZBMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.params = [NSMutableDictionary dictionary];
    CLLocationCoordinate2D coord;
    coord.longitude = 116.3972282409668;
    coord.latitude = 39.90960456049752;
    [self.mapView setRegion:MKCoordinateRegionMake(coord, MKCoordinateSpanMake(0.1, 0.1)) animated:YES];

    [self.params setObject:[WeiboAPI getToken] forKey:@"access_token"];
    [self.params setObject:@(coord.latitude) forKey:@"lat"];
    [self.params setObject:@(coord.longitude) forKey:@"long"];
    [WeiboAPI requestAllPlaceWeiboWithParams:self.params AndCallBack:^(id obj) {
        [self addAnnotationsByArr:obj];
    }];
    
    self.weiboCell = [[[NSBundle mainBundle]loadNibNamed:@"WeiboCell" owner:self options:nil]firstObject];
    self.weiboCell.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 100);
    self.weiboCell.backgroundColor = [UIColor whiteColor];
    [self.mapView addSubview:self.weiboCell];
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
   // NSLog(@"位置发生改变了");
    [mapView removeAnnotations:mapView.annotations];
    CLLocationCoordinate2D coord = mapView.centerCoordinate;
    
    //需要发出请求 并且把当前位置的坐标作为参数
    [self.params setObject:@(coord.longitude) forKey:@"long"];
    [self.params setObject:@(coord.latitude) forKey:@"lat"];
    [WeiboAPI requestAllPlaceWeiboWithParams:self.params AndCallBack:^(id obj) {
        [self addAnnotationsByArr:obj];
    }];
}
-(void)addAnnotationsByArr:(NSArray *)arr{
    
    
    for (Weibo *weibo in arr) {
        MyAnnotation *ann = [[MyAnnotation alloc]init];
        CLLocationCoordinate2D coord;
        coord.longitude = weibo.coord.longitude;
        coord.latitude = weibo.coord.latitude;
        ann.weibo = weibo;
        ann.coordinate = coord;
        ann.title = weibo.text;
        
        [self.mapView addAnnotation:ann];
        
    }
}
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MyannotationView *annView = (MyannotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"ann"];
    if (!annView) {
        annView = [[MyannotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"ann"];
    }
    return annView;
}
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    MyAnnotation *annotation = view.annotation;
    self.weiboCell.weibo = annotation.weibo;
    CGRect rect = self.weiboCell.frame;
    float h = [annotation.weibo getWeiboHeight]+130;
    rect = CGRectMake(0, self.view.bounds.size.height-h, self.view.bounds.size.width, h);
    [UIView animateWithDuration:.5 animations:^{
        self.weiboCell.frame = rect;
    }];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    CGRect frame = self.weiboCell.frame;
    frame.origin.y = self.view.bounds.size.height;
    [UIView animateWithDuration:.5 animations:^{
        self.weiboCell.frame = frame;
    }];
}
@end
