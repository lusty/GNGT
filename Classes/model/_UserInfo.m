// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserInfo.m instead.

#import "_UserInfo.h"

@implementation UserInfoID
@end

@implementation _UserInfo

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"UserInfo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:moc_];
}

- (UserInfoID*)objectID {
	return (UserInfoID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"isRegisteredForTourValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isRegisteredForTour"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"hasSeenIntroductionValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hasSeenIntroduction"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic email;






@dynamic isRegisteredForTour;



- (BOOL)isRegisteredForTourValue {
	NSNumber *result = [self isRegisteredForTour];
	return [result boolValue];
}

- (void)setIsRegisteredForTourValue:(BOOL)value_ {
	[self setIsRegisteredForTour:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsRegisteredForTourValue {
	NSNumber *result = [self primitiveIsRegisteredForTour];
	return [result boolValue];
}

- (void)setPrimitiveIsRegisteredForTourValue:(BOOL)value_ {
	[self setPrimitiveIsRegisteredForTour:[NSNumber numberWithBool:value_]];
}





@dynamic hasSeenIntroduction;



- (BOOL)hasSeenIntroductionValue {
	NSNumber *result = [self hasSeenIntroduction];
	return [result boolValue];
}

- (void)setHasSeenIntroductionValue:(BOOL)value_ {
	[self setHasSeenIntroduction:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveHasSeenIntroductionValue {
	NSNumber *result = [self primitiveHasSeenIntroduction];
	return [result boolValue];
}

- (void)setPrimitiveHasSeenIntroductionValue:(BOOL)value_ {
	[self setPrimitiveHasSeenIntroduction:[NSNumber numberWithBool:value_]];
}









@end
