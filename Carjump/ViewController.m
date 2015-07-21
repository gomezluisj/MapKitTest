//
//  ViewController.m
//  Carjump
//
//  Created by Luis Gómez on 7/21/15.
//  Copyright (c) 2015 Luis Gómez. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "MKMapView+ZoomLevel.h"

#define GERMANY_LATITUDE 52.5
#define GERMANY_LONGITUDE 13.4

#define ZOOM_LEVEL 10

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a
    CLLocationCoordinate2D centerCoord = { GERMANY_LATITUDE, GERMANY_LONGITUDE };
    [self.mapView setCenterCoordinate:centerCoord zoomLevel:ZOOM_LEVEL animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
