// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GardenLocation.h instead.

#import <CoreData/CoreData.h>


@class Garden;







@interface GardenLocationID : NSManagedObjectID {}
@end

@interface _GardenLocation : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (GardenLocationID*)objectID;



@property (nonatomic, retain) NSString *note;

//- (BOOL)validateNote:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *longitude;

@property float longitudeValue;
- (float)longitudeValue;
- (void)setLongitudeValue:(float)value_;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *streetAddress;

//- (BOOL)validateStreetAddress:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *latitude;

@property float latitudeValue;
- (float)latitudeValue;
- (void)setLatitudeValue:(float)value_;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) Garden* garden;
//- (BOOL)validateGarden:(id*)value_ error:(NSError**)error_;




@end

@interface _GardenLocation (CoreDataGeneratedAccessors)

@end

@interface _GardenLocation (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveNote;
- (void)setPrimitiveNote:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSNumber*)value;

- (float)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(float)value_;




- (NSString*)primitiveStreetAddress;
- (void)setPrimitiveStreetAddress:(NSString*)value;




- (NSNumber*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSNumber*)value;

- (float)primitiveLatitudeValue;
- (void)setPrimitiveLatitudeValue:(float)value_;





- (Garden*)primitiveGarden;
- (void)setPrimitiveGarden:(Garden*)value;


@end
