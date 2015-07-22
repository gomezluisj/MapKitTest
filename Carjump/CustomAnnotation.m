//
//  CustomAnnotation.m
//  Carjump
//
//  Created by Luis Gómez on 7/22/15.
//  Copyright (c) 2015 Luis Gómez. All rights reserved.
//

#import "CustomAnnotation.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation CustomAnnotation
@synthesize title,coordinate;
+ (void) save
{
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}
- (id)initWithTitle:(NSString *)aTitle andCoordinate:(CLLocationCoordinate2D)coord
{
    self = [super init];
    title = aTitle;
    coordinate = coord;
    return self;
}
@end
