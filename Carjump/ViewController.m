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
#import "CustomAnnotation.h"

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
    UITapGestureRecognizer* tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapTapped:)];
    [self.mapView addGestureRecognizer:tapGestureRecognizer];
//    for(int i = 0; i < 10; i++) {
//        
//        // Calculamos una distancia aleatoria en latitud y longitud suficientemente corta para que se muestre en nuestra región.
//        CGFloat latDelta = rand()*.035/RAND_MAX -.02;
//        CGFloat longDelta = rand()*.03/RAND_MAX -.015;
//        
//        CGFloat newLat = GERMANY_LATITUDE + latDelta;
//        CGFloat newLon = GERMANY_LONGITUDE + longDelta;
//        
//        CLLocationCoordinate2D newCoord = {newLat, newLon};
//        
//        // Creamos la anotación
//        CustomAnnotation *annotation = [[CustomAnnotation alloc]initWithTitle: [NSString stringWithFormat:@"%d",i]
//                                                                andCoordinate:newCoord];
//        // Y la insertamos en el mapa
//        [self.mapView addAnnotation:annotation];
//        
//        
//        
//    }
}
- (void)mapTapped:(UITapGestureRecognizer*)gestureRecognizer{
    CGPoint touchPoint = [gestureRecognizer locationInView: self.mapView];
    CLLocationCoordinate2D coordinates = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.view];
    CustomAnnotation *annotation = [[CustomAnnotation alloc]initWithTitle: @""
                                    andCoordinate:coordinates];
    [self.mapView addAnnotation:annotation ];
    [CustomAnnotation save];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self drawAnnotations];
}

- (void)drawAnnotations {
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    MKMapRect mRect = self.mapView.visibleMapRect;
    NSArray* visibleBounds=[self getBoundingBox:mRect];
    NSLog(@"%@",visibleBounds);
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(latitude >= %f) AND (latitude < %f) AND (longitude >= %f) AND (longitude < %f)", visibleBounds[2], visibleBounds[0], visibleBounds[3], visibleBounds[1]];
    NSUInteger count = [MapPin MR_countOfEntitiesWithPredicate:predicate];
    if (count == 0) {
        
    } else if (count <= 2) { // We draw all of them
        NSArray* allRecords = [MapPin MR_findAllWithPredicate:predicate];
        for (MapPin* mapPin in allRecords) {
            [self addPinToMap:mapPin];
        }
    }
}
-(CLLocationCoordinate2D)getNECoordinate:(MKMapRect)mRect{
    return [self getCoordinateFromMapRectanglePoint:MKMapRectGetMaxX(mRect) y:mRect.origin.y];
}
-(CLLocationCoordinate2D)getNWCoordinate:(MKMapRect)mRect{
    return [self getCoordinateFromMapRectanglePoint:MKMapRectGetMinX(mRect) y:mRect.origin.y];
}
-(CLLocationCoordinate2D)getSECoordinate:(MKMapRect)mRect{
    return [self getCoordinateFromMapRectanglePoint:MKMapRectGetMaxX(mRect) y:MKMapRectGetMaxY(mRect)];
}
-(CLLocationCoordinate2D)getSWCoordinate:(MKMapRect)mRect{
    return [self getCoordinateFromMapRectanglePoint:mRect.origin.x y:MKMapRectGetMaxY(mRect)];
}
-(CLLocationCoordinate2D)getCoordinateFromMapRectanglePoint:(double)x y:(double)y{
    MKMapPoint swMapPoint = MKMapPointMake(x, y);
    return MKCoordinateForMapPoint(swMapPoint);
}
-(NSArray *)getBoundingBox:(MKMapRect)mRect{
    CLLocationCoordinate2D bottomLeft = [self getSWCoordinate:mRect];
    CLLocationCoordinate2D topRight = [self getNECoordinate:mRect];
    return @[[NSNumber numberWithDouble:bottomLeft.latitude ],
             [NSNumber numberWithDouble:bottomLeft.longitude],
             [NSNumber numberWithDouble:topRight.latitude],
             [NSNumber numberWithDouble:topRight.longitude]];
}
@end
