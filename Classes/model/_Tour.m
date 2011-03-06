// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Tour.m instead.

#import "_Tour.h"

@implementation TourID
@end

@implementation _Tour

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Tour" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Tour";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Tour" inManagedObjectContext:moc_];
}

- (TourID*)objectID {
	return (TourID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic tourNSDate;






@dynamic hidePrivateAfterDate;






@dynamic url;






@dynamic hidePrivateBeforeDate;






@dynamic tourName;






@dynamic gardens;

	
- (NSMutableSet*)gardensSet {
	[self willAccessValueForKey:@"gardens"];
	NSMutableSet *result = [self mutableSetValueForKey:@"gardens"];
	[self didAccessValueForKey:@"gardens"];
	return result;
}
	





@end
