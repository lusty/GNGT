//
//  GardenLocation.h
//  GNGT
//
//  Created by Richard Clark on 2/24/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>

@class Garden;

@interface GardenLocation :  NSManagedObject <MKAnnotation>  
{
}

@property (nonatomic, retain) NSString * streetAddress;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) Garden * garden;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

//- (BOOL) hasPlantSale;
//- (BOOL) hasGardenTalk;

@end



