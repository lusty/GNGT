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
	

	return keyPaths;
}




@dynamic email;










@end
