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
#endif
    BOOL needsInitialImport = ![fileManager fileExistsAtPath:[storeURL path]];
	
	NSDictionary *storeOptions = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
	persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:storeOptions error:&error]) {
        // That failed, sop rebuild the database
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        needsInitialImport = YES; 
        if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort(); // TODO do something more appropriate for a production app
        }
    }    
    
    if (needsInitialImport) {
        NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"gngt2011-public" ofType:@"json"]; 
        [self importJSONFile:jsonPath error:&error];
    }
	
    return persistentStoreCoordinator_;
}

- (void)importJSONFile:(NSString*)jsonPath error:(NSError**)error
{
	NSData *data = [NSData dataWithContentsOfFile:jsonPath];
	NSMutableDictionary *parsed = [data mutableObjectFromJSONData];
	if (parsed && parsed.count > 0) {
        Importer *importer = [[Importer alloc] initWithContext:[self managedObjectContext]];
        [importer tour:parsed error:error];
        [importer release];
    }
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
