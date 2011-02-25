//
//  Garden.h
//  GNGT
//
//  Created by Richard Clark on 2/24/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import <CoreData/CoreData.h>

@class GardenLocation;
@class InfoItem;
@class Tour;

@interface Garden :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSNumber * isFavorite;
@property (nonatomic, retain) NSNumber * isPublic;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) GardenLocation * location;
@property (nonatomic, retain) Tour * tour;
@property (nonatomic, retain) NSSet* info;

//- (BOOL) hasPlantSale;
//- (BOOL) hasGardenTalk;

@end


@interface Garden (CoreDataGeneratedAccessors)
- (void)addInfoObject:(InfoItem *)value;
- (void)removeInfoObject:(InfoItem *)value;
- (void)addInfo:(NSSet *)value;
- (void)removeInfo:(NSSet *)value;

@end

