//
//  DatabaseAccess.m
//  GNGT
//
//  Created by Richard Clark on 3/8/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import "DatabaseAccess.h"
#import "SynthesizeSingleton.h"

#import "JSONKit.h"
#import "Importer.h"

#undef REBUILD_DATABASE

@implementation DatabaseAccess
SYNTHESIZE_SINGLETON_FOR_CLASS(DatabaseAccess)

- (void)dealloc {
    [managedObjectContext_ release];
    [managedObjectModel_ release];
    [persistentStoreCoordinator_ release];
    [super dealloc];
}


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"GNGT" withExtension:@"momd"];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
	
	NSURL *documentsURL = [self applicationDocumentsDirectory];
	NSURL *storeURL = [documentsURL URLByAppendingPathComponent: @"GNGT.sqlite"];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
    NSError *error = nil;
#ifdef REBUILD_DATABASE
	// Remove database if it exists; we'll replace it with a freshly imported copy
	[fileManager removeItemAtURL:storeURL error:NULL];
#else
	// Copy starter db from bundle if it doesn't already exist
	if (![fileManager fileExistsAtPath:[storeURL path]]) {
		NSURL *defaultStorePath = [[NSBundle mainBundle] URLForResource:@"GNGT" withExtension:@"sqlite"];
		[fileManager copyItemAtURL:defaultStorePath toURL:storeURL error:NULL];
	}
#endif
	
	NSDictionary *storeOptions = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
	persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:storeOptions error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort(); // TODO do something more appropriate for a production app
    }    
    
#ifdef REBUILD_DATABASE
	// Do the import (one time only)
	Importer *importer = [[Importer alloc] initWithContext:[self managedObjectContext]];
	NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"gngt2011-public" ofType:@"json"]; 
	NSData *data = [NSData dataWithContentsOfFile:jsonPath];
	NSMutableDictionary *parsed = [data mutableObjectFromJSONData];
	if (parsed && parsed.count > 0) [importer tour:parsed error:&error];
#endif
	
    return persistentStoreCoordinator_;
}

- (void)saveContext
{
    NSError *error = nil;
	NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}    



#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
