//
//  Importer.m
//  ImportJSON
//
//  Created by Richard Clark on 2/24/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import "Importer.h"
#import "JSONKit.h"
#import <CoreData/CoreData.h>

#import "Garden.h"
#import "GardenLocation.h"
#import "InfoItem.h"

@interface Importer(Private)
- (NSManagedObject*)managedObjectFromStructure:(NSDictionary*)structureDictionary withManagedObjectContext:(NSManagedObjectContext*)moc;
@end

@implementation Importer

@dynamic moc;

#pragma mark Initialization

- (id)initWithContext:(NSManagedObjectContext*)context
{
    self = [super init];
    if (self) {
        moc = [context retain];
    }
    return self;
}

#pragma mark Utility functions

- (NSManagedObject*)managedObjectFromStructure:(NSDictionary*)structureDictionary
{
	NSString *objectName = @"SimpleNamedClass";
	NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:objectName inManagedObjectContext:moc];
	[managedObject setValuesForKeysWithDictionary:structureDictionary];
	return managedObject;
}

- (NSManagedObject*)extractObject:(NSString*)entityName from:(NSDictionary*)structureDictionary
{
	NSManagedObject *managedObject = NULL;
	if (structureDictionary) {
		managedObject = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:moc];
		[managedObject setValuesForKeysWithDictionary:structureDictionary];
	}
	return managedObject;
}

- (NSManagedObject*)extractObject:(NSString*)entityName from:(NSDictionary*)parsedStructure withKey:(NSString*)key
{
	NSDictionary *structureDictionary = [parsedStructure objectForKey:key];
	return [self extractObject:entityName from:structureDictionary];
}

- (NSManagedObject*)replaceObject:(NSString*)entityName inside:(NSMutableDictionary*)parent withKey:(NSString*)key
{
	NSManagedObject *child = [self extractObject:entityName from:parent withKey:key];
	[parent setObject:child forKey:key];
	return child;
}

#pragma mark -
#pragma mark Recursive descent parser

void logValidationErrors(NSError **err) 
{
	NSError *error = *err;
	if (!error) return;
	NSLog(@"Failed to save to data store: %@", [error localizedDescription]);
    NSArray* detailedErrors = [[error userInfo] objectForKey:NSDetailedErrorsKey];
    if(detailedErrors != nil && [detailedErrors count] > 0) {
        for(NSError* detailedError in detailedErrors) {
            NSLog(@"  DetailedError: %@", [detailedError userInfo]);
        }
    }
    else {
		NSLog(@"  %@", [error userInfo]);
    }
}

- (id)tour:(NSMutableDictionary*)parsedStructure error:(NSError**)err
{
	NSMutableDictionary *tourStructure = [parsedStructure objectForKey:@"tour"];
	if (!tourStructure) {
		NSLog(@"Missing tour object in parsed JSON");
		return NULL;
	}
	NSMutableSet *allGardens = [self gardens:tourStructure error:err];
	// TODO check the error
	if (allGardens) [tourStructure setValue:allGardens forKey:@"gardens"];
	Tour *result = (Tour*)[self extractObject:@"Tour" from:parsedStructure withKey:@"tour"];
	[moc save:err];
	logValidationErrors(err);
	return result;
}

- (id)garden:(NSMutableDictionary*)parsedStructure error:(NSError**)err
{
	GardenLocation *loc = [self gardenLocation:parsedStructure error:NULL]; // this will replace the location in the parsed structure
	// can skip the error check
	NSMutableSet *info = [[self infoArray:parsedStructure error:NULL] retain];
	if (info) {
		[parsedStructure removeObjectForKey:@"infoArray"];
		[parsedStructure setValue:info forKey:@"info"];
		[info release];
	}
	Garden* result = (Garden*)[self extractObject:@"Garden" from:parsedStructure];
	loc.name = result.name;
	// TODO patch the note into the location
	[result updateBeforeSave];
	[moc save:err];
	logValidationErrors(err);
	return result;
}


- (id)gardens:(NSMutableDictionary*)parsedStructure error:(NSError**)err
{
	NSMutableSet *result = NULL;
	id gardenArray = [parsedStructure objectForKey:@"gardens"];
	if (gardenArray) {
		NSUInteger numGardens = [gardenArray count];
		result = [NSMutableSet setWithCapacity:numGardens];
		for (id gardenStructure in gardenArray) {
			Garden *garden = [self garden:gardenStructure error:err];
			if (garden) [result addObject:garden];
		}
	}
	return result;
}


- (id)gardenLocation:(NSMutableDictionary*)parsedStructure error:(NSError**)err
{
	if (![parsedStructure objectForKey:@"location"]) {
		NSLog(@"Missing location object in garden");
		return NULL;
	}
	return [self replaceObject:@"GardenLocation" inside:parsedStructure withKey:@"location"];
}

- (NSMutableSet *)infoArray:(NSMutableDictionary*)parsedStructure error:(NSError**)err
{
	NSMutableSet *result = NULL;
	NSMutableDictionary *innerStructure = [parsedStructure valueForKey:@"infoArray"];
	NSString *valueType;
	if (innerStructure) {
		result = [NSMutableSet setWithCapacity:innerStructure.count];
		for (id key in innerStructure) {
			valueType = @"NSString";
			id value = [innerStructure valueForKey:key];
			if ([value isKindOfClass:[NSNumber class]]) {
				value = [value stringValue];
				valueType = @"NSNumber";
			} else if ([value length] == 0) // assuming it's a string, which may be a bad assumption in the future
				continue;				    // skip entries with an empty value
			InfoItem *item = [InfoItem insertInManagedObjectContext:moc];
			item.itemKey = key;
			item.itemValue = value;
			item.valueType = valueType;
			[result addObject:item];
		}
	}
	return result;
}

@end
