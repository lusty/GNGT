//
//  DatabaseAccess.h
//  GNGT
//
//  Created by Richard Clark on 3/8/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UserInfo;
@interface DatabaseAccess : NSObject {

@private
    UserInfo *_userInfo;
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, readonly) UserInfo *userInfo;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;
- (void)importJSONFile:(NSString*)jsonPath error:(NSError**)error;

+ (DatabaseAccess *)sharedDatabaseAccess;

@end
