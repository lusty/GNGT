//
//  GNGTUpdateManager.h
//  GNGT
//
//  Created by Richard Clark on 3/8/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserInfo;
@class DatabaseAccess;

@interface UpdateManager : NSObject {
//	UserInfo *userInfo;
	BOOL updateAvailable;

@private
	DatabaseAccess *databaseAccess;
	NSManagedObjectContext *context;
	NSNotificationCenter *notificationCenter;
}

//@property (nonatomic, retain) UserInfo *userInfo;
@property (nonatomic) BOOL updateAvailable;

+ (UpdateManager*) sharedUpdateManager;

- (void)beginCheckForUpdate;

#define ERROR_NOTIFICATION @"NetworkError"
#define UPDATE_NOTIFICATION @"FileUpdateAvailable"



@end

