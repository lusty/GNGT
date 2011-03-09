// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Tour.h instead.

#import <CoreData/CoreData.h>


@class Garden;








@interface TourID : NSManagedObjectID {}
@end

@interface _Tour : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TourID*)objectID;



@property (nonatomic, retain) NSDate *hidePrivateBeforeDate;

//- (BOOL)validateHidePrivateBeforeDate:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *hidePrivateAfterDate;

//- (BOOL)validateHidePrivateAfterDate:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *url;

//- (BOOL)validateUrl:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *tourName;

//- (BOOL)validateTourName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *updatedOn;

//- (BOOL)validateUpdatedOn:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *tourNSDate;

//- (BOOL)validateTourNSDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* gardens;
- (NSMutableSet*)gardensSet;




@end

@interface _Tour (CoreDataGeneratedAccessors)

- (void)addGardens:(NSSet*)value_;
- (void)removeGardens:(NSSet*)value_;
- (void)addGardensObject:(Garden*)value_;
- (void)removeGardensObject:(Garden*)value_;

@end

@interface _Tour (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveHidePrivateBeforeDate;
- (void)setPrimitiveHidePrivateBeforeDate:(NSDate*)value;




- (NSDate*)primitiveHidePrivateAfterDate;
- (void)setPrimitiveHidePrivateAfterDate:(NSDate*)value;




- (NSString*)primitiveUrl;
- (void)setPrimitiveUrl:(NSString*)value;




- (NSString*)primitiveTourName;
- (void)setPrimitiveTourName:(NSString*)value;




- (NSDate*)primitiveUpdatedOn;
- (void)setPrimitiveUpdatedOn:(NSDate*)value;




- (NSDate*)primitiveTourNSDate;
- (void)setPrimitiveTourNSDate:(NSDate*)value;





- (NSMutableSet*)primitiveGardens;
- (void)setPrimitiveGardens:(NSMutableSet*)value;


@end
