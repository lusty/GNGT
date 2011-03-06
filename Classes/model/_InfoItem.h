// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to InfoItem.h instead.

#import <CoreData/CoreData.h>


@class Garden;





@interface InfoItemID : NSManagedObjectID {}
@end

@interface _InfoItem : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (InfoItemID*)objectID;



@property (nonatomic, retain) NSString *valueType;

//- (BOOL)validateValueType:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *itemValue;

//- (BOOL)validateItemValue:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *itemKey;

//- (BOOL)validateItemKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) Garden* garden;
//- (BOOL)validateGarden:(id*)value_ error:(NSError**)error_;




@end

@interface _InfoItem (CoreDataGeneratedAccessors)

@end

@interface _InfoItem (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveValueType;
- (void)setPrimitiveValueType:(NSString*)value;




- (NSString*)primitiveItemValue;
- (void)setPrimitiveItemValue:(NSString*)value;




- (NSString*)primitiveItemKey;
- (void)setPrimitiveItemKey:(NSString*)value;





- (Garden*)primitiveGarden;
- (void)setPrimitiveGarden:(Garden*)value;


@end
