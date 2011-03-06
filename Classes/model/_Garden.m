// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Garden.m instead.

#import "_Garden.h"

@implementation GardenID
@end

@implementation _Garden

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Garden" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Garden";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Garden" inManagedObjectContext:moc_];
}

- (GardenID*)objectID {
	return (GardenID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"isPublicValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isPublic"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"isFavoriteValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isFavorite"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic name;






@dynamic isPublic;



- (BOOL)isPublicValue {
	NSNumber *result = [self isPublic];
	return [result boolValue];
}

- (void)setIsPublicValue:(BOOL)value_ {
	[self setIsPublic:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsPublicValue {
	NSNumber *result = [self primitiveIsPublic];
	return [result boolValue];
}

- (void)setPrimitiveIsPublicValue:(BOOL)value_ {
	[self setPrimitiveIsPublic:[NSNumber numberWithBool:value_]];
}





@dynamic note;






@dynamic city;






@dynamic isFavorite;



- (BOOL)isFavoriteValue {
	NSNumber *result = [self isFavorite];
	return [result boolValue];
}

- (void)setIsFavoriteValue:(BOOL)value_ {
	[self setIsFavorite:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsFavoriteValue {
	NSNumber *result = [self primitiveIsFavorite];
	return [result boolValue];
}

- (void)setPrimitiveIsFavoriteValue:(BOOL)value_ {
	[self setPrimitiveIsFavorite:[NSNumber numberWithBool:value_]];
}





@dynamic tour;

	

@dynamic location;

	

@dynamic info;

	
- (NSMutableSet*)infoSet {
	[self willAccessValueForKey:@"info"];
	NSMutableSet *result = [self mutableSetValueForKey:@"info"];
	[self didAccessValueForKey:@"info"];
	return result;
}
	





@end
