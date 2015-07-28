//
//  MapViewController.m
//  新浪微博
//
//  Created by tarena6 on 15-4-9.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CLLocationCoordinate2D coord;
    coord.longitude = 116.3972282409668;
    coord.latitude = 39.90960456049752;
    [self.mapView setRegion:MKCoordinateRegionMake(coord, MKCoordinateSpanMake(0.001, 0.001)) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.view];
    CLLocationCoordinate2D coord = [self.mapView convertPoint:point toCoordinateFromView:self.view];
    self.delegate.coord = coord;
    
    [self.mapView setRegion:MKCoordinateRegionMake(coord, MKCoordinateSpanMake(0.001, 0.001)) animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
