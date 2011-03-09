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





@end

@interface _UserInfo (CoreDataGeneratedAccessors)

@end

@interface _UserInfo (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;




@end
