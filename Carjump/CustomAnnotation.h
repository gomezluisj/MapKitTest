//
//  CustomAnnotation.h
//  Carjump
//
//  Created by Luis Gómez on 7/22/15.
//  Copyright (c) 2015 Luis Gómez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecord.h>
#import <MapKit/MapKit.h>

@interface CustomAnnotation : NSManagedObject  <MKAnnotation>
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
- (id)initWithTitle:(NSString *)aTitle andCoordinate:(CLLocationCoordinate2D)coord;
+ (void) save;
@end
