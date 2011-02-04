//
//  GardenInfo.h
//  GNGT
//
//  Created by DIANA K STANLEY on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>

@class GardenDescription;

@interface GardenInfo :  NSManagedObject <MKAnnotation> 
{
}

@property (nonatomic, retain) NSNumber * gardenNumber;
@property (nonatomic, retain) NSString * gardenName;
@property (nonatomic, retain) NSString * street;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * plantSale;
@property (nonatomic, retain) NSString * gardenTalk;
@property (nonatomic, retain) GardenDescription * gardenDescription;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * isFavorite;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (BOOL) hasPlantSale;
- (BOOL) hasGardenTalk;
@end



