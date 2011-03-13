// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserInfo.h instead.

#import <CoreData/CoreData.h>







@interface UserInfoID : NSManagedObjectID {}
@end

@interface _UserInfo : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (UserInfoID*)objectID;



@property (nonatomic, retain) NSString *email;

//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *isRegisteredForTour;

@property BOOL isRegisteredForTourValue;
- (BOOL)isRegisteredForTourValue;
- (void)setIsRegisteredForTourValue:(BOOL)value_;

//- (BOOL)validateIsRegisteredForTour:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *hasSeenIntroduction;

@property BOOL hasSeenIntroductionValue;
- (BOOL)hasSeenIntroductionValue;
- (void)setHasSeenIntroductionValue:(BOOL)value_;

//- (BOOL)validateHasSeenIntroduction:(id*)value_ error:(NSError**)error_;





@end

@interface _UserInfo (CoreDataGeneratedAccessors)

@end

@interface _UserInfo (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;




- (NSNumber*)primitiveIsRegisteredForTour;
- (void)setPrimitiveIsRegisteredForTour:(NSNumber*)value;

- (BOOL)primitiveIsRegisteredForTourValue;
- (void)setPrimitiveIsRegisteredForTourValue:(BOOL)value_;




- (NSNumber*)primitiveHasSeenIntroduction;
- (void)setPrimitiveHasSeenIntroduction:(NSNumber*)value;

- (BOOL)primitiveHasSeenIntroductionValue;
- (void)setPrimitiveHasSeenIntroductionValue:(BOOL)value_;




@end
