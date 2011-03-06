// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to InfoItem.m instead.

#import "_InfoItem.h"

@implementation InfoItemID
@end

@implementation _InfoItem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"InfoItem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"InfoItem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"InfoItem" inManagedObjectContext:moc_];
}

- (InfoItemID*)objectID {
	return (InfoItemID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic valueType;






@dynamic itemValue;






@dynamic itemKey;






@dynamic garden;

	





@end
