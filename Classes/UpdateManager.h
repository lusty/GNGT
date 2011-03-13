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
	UserInfo *userInfo;
	BOOL updateAvailable;
	NSString *registrationStatus;

@private
	DatabaseAccess *databaseAccess;
	NSManagedObjectContext *context;
	NSNotificationCenter *notificationCenter;
	NSString *baseURL;
}

@property (nonatomic, retain) UserInfo *userInfo;
@property (nonatomic) BOOL updateAvailable;
@property (nonatomic, retain) NSString *registrationStatus;

+ (UpdateManager*) sharedUpdateManager;

- (void)applicationFinishedLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void)runStartupChecks;
- (void)beginCheckForRegistration;
- (void)beginCheckForUpdate;

- (void) getRegistrationStatusForEmail:(NSString*)email andCall:(void (^)(NSString *result))callback;

#define ERROR_NOTIFICATION @"NetworkError"
#define UPDATE_NOTIFICATION @"FileUpdateAvailable"
#define REGISTRATION_NOTIFICATION @"RegistrationStatus"

#define REGISTERED @"REGISTERED"
#define NOT_REGISTERED @"NOT_REGISTERED"

@end

