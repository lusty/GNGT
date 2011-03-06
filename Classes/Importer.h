//
//  Importer.h
//  ImportJSON
//
//  Created by Richard Clark on 2/24/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Importer : NSObject {
	NSManagedObjectContext *moc;
}

// Utilities
- (NSManagedObject*)extractObject:(NSString*)entityName from:(NSDictionary*)parsedStructure;
- (NSManagedObject*)extractObject:(NSString*)entityName from:(NSDictionary*)parsedStructure withKey:(NSString*)key;
- (NSManagedObject*)replaceObject:(NSString*)entityName inside:(NSMutableDictionary*)parsedStructure withKey:(NSString*)key;

@property (nonatomic, retain) NSManagedObjectContext *moc;

// Init
- (id)initWithContext:(NSManagedObjectContext*)context;

// Recursive descent parser
- (id)tour:(NSMutableDictionary*)parsedStructure error:(NSError**)err;
- (id)gardens:(NSMutableDictionary*)parsedStructure error:(NSError**)err;
- (id)garden:(NSMutableDictionary*)parsedStructure error:(NSError**)err;
- (id)gardenLocation:(NSMutableDictionary*)parsedStructure error:(NSError**)err;
- (NSMutableSet *)infoArray:(NSMutableDictionary*)parsedStructure error:(NSError**)err;

@end
