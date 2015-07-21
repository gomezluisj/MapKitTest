//
//  MKMapView+ZoomLevel.h
//  Carjump
//
//  Created by Luis Gómez on 7/21/15.
//  Copyright (c) 2015 Luis Gómez. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)
- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;
@end
