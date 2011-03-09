// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Garden.h instead.

#import <CoreData/CoreData.h>


@class Tour;
@class GardenLocation;
@class InfoItem;










@interface GardenID : NSManagedObjectID {}
@end

@interface _Garden : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (GardenID*)objectID;



@property (nonatomic, retain) NSString *city;

//- (BOOL)validateCity:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *hasPlantSale;

@property BOOL hasPlantSaleValue;
- (BOOL)hasPlantSaleValue;
- (void)setHasPlantSaleValue:(BOOL)value_;

//- (BOOL)validateHasPlantSale:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *isPublic;

@property BOOL isPublicValue;
- (BOOL)isPublicValue;
- (void)setIsPublicValue:(BOOL)value_;

//- (BOOL)validateIsPublic:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *hasGardenTalk;

@property BOOL hasGardenTalkValue;
- (BOOL)hasGardenTalkValue;
- (void)setHasGardenTalkValue:(BOOL)value_;

//- (BOOL)validateHasGardenTalk:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *note;

//- (BOOL)validateNote:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *isFavorite;

@property BOOL isFavoriteValue;
- (BOOL)isFavoriteValue;
- (void)setIsFavoriteValue:(BOOL)value_;

//- (BOOL)validateIsFavorite:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *isSponsor;

@property BOOL isSponsorValue;
- (BOOL)isSponsorValue;
- (void)setIsSponsorValue:(BOOL)value_;

//- (BOOL)validateIsSponsor:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) Tour* tour;
//- (BOOL)validateTour:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) GardenLocation* location;
//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSSet* info;
- (NSMutableSet*)infoSet;




@end

@interface _Garden (CoreDataGeneratedAccessors)

- (void)addInfo:(NSSet*)value_;
- (void)removeInfo:(NSSet*)value_;
- (void)addInfoObject:(InfoItem*)value_;
- (void)removeInfoObject:(InfoItem*)value_;

@end

@interface _Garden (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCity;
- (void)setPrimitiveCity:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveHasPlantSale;
- (void)setPrimitiveHasPlantSale:(NSNumber*)value;

- (BOOL)primitiveHasPlantSaleValue;
- (void)setPrimitiveHasPlantSaleValue:(BOOL)value_;




- (NSNumber*)primitiveIsPublic;
- (void)setPrimitiveIsPublic:(NSNumber*)value;

- (BOOL)primitiveIsPublicValue;
- (void)setPrimitiveIsPublicValue:(BOOL)value_;




- (NSNumber*)primitiveHasGardenTalk;
- (void)setPrimitiveHasGardenTalk:(NSNumber*)value;

- (BOOL)primitiveHasGardenTalkValue;
- (void)setPrimitiveHasGardenTalkValue:(BOOL)value_;




- (NSString*)primitiveNote;
- (void)setPrimitiveNote:(NSString*)value;




- (NSNumber*)primitiveIsFavorite;
- (void)setPrimitiveIsFavorite:(NSNumber*)value;

- (BOOL)primitiveIsFavoriteValue;
- (void)setPrimitiveIsFavoriteValue:(BOOL)value_;




- (NSNumber*)primitiveIsSponsor;
- (void)setPrimitiveIsSponsor:(NSNumber*)value;

- (BOOL)primitiveIsSponsorValue;
- (void)setPrimitiveIsSponsorValue:(BOOL)value_;





- (Tour*)primitiveTour;
- (void)setPrimitiveTour:(Tour*)value;



- (GardenLocation*)primitiveLocation;
- (void)setPrimitiveLocation:(GardenLocation*)value;



- (NSMutableSet*)primitiveInfo;
- (void)setPrimitiveInfo:(NSMutableSet*)value;


@end
