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
	
	if ([key isEqualToString:@"hasPlantSaleValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hasPlantSale"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"isPublicValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isPublic"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"hasGardenTalkValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hasGardenTalk"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"isFavoriteValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isFavorite"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic city;






@dynamic name;






@dynamic hasPlantSale;



- (BOOL)hasPlantSaleValue {
	NSNumber *result = [self hasPlantSale];
	return [result boolValue];
}

- (void)setHasPlantSaleValue:(BOOL)value_ {
	[self setHasPlantSale:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveHasPlantSaleValue {
	NSNumber *result = [self primitiveHasPlantSale];
	return [result boolValue];
}

- (void)setPrimitiveHasPlantSaleValue:(BOOL)value_ {
	[self setPrimitiveHasPlantSale:[NSNumber numberWithBool:value_]];
}





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





@dynamic hasGardenTalk;



- (BOOL)hasGardenTalkValue {
	NSNumber *result = [self hasGardenTalk];
	return [result boolValue];
}

- (void)setHasGardenTalkValue:(BOOL)value_ {
	[self setHasGardenTalk:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveHasGardenTalkValue {
	NSNumber *result = [self primitiveHasGardenTalk];
	return [result boolValue];
}

- (void)setPrimitiveHasGardenTalkValue:(BOOL)value_ {
	[self setPrimitiveHasGardenTalk:[NSNumber numberWithBool:value_]];
}





@dynamic note;






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
