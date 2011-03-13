//
//  GNGTUpdateManager.m
//  GNGT
//
//  Created by Richard Clark on 3/8/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import "UpdateManager.h"
#import "SynthesizeSingleton.h"
#import "DatabaseAccess.h"
#import "UserInfo.h"

#import "JSONKit.h"
#import "Importer.h"

#include "GTMHTTPFetcher.h"

@interface UpdateManager(Private)
- (void)updateCheck:(GTMHTTPFetcher *)fetcher finishedWithData:(NSData *)retrievedData error:(NSError *)error;
- (UserInfo *)getOrCreateUserInfoInManagedObjectContext:(NSManagedObjectContext*)moc error:(NSError**)error;
@end

@implementation UpdateManager
SYNTHESIZE_SINGLETON_FOR_CLASS(UpdateManager)

@synthesize userInfo;
@synthesize updateAvailable, registrationStatus;

- (id)init
{
    self = [super init];
    if (self) {
        userInfo = nil;
		updateAvailable = NO;
		registrationStatus = nil;
		databaseAccess = [DatabaseAccess sharedDatabaseAccess]; // singleton is retained by default
		context = [[databaseAccess managedObjectContext] retain];
		notificationCenter = [[NSNotificationCenter defaultCenter] retain];
		baseURL = @"http://www.gngt.org/GNGT/App.php?bugsbunny=29196E18F6EAA8DB2F0B2A0535CAF525";
    }
    return self;
}

- (void)applicationFinishedLaunchingWithOptions:(NSDictionary *)launchOptions 
{
	NSError *error = nil;
	self.userInfo = [self getOrCreateUserInfoInManagedObjectContext:context error:&error];
	// TODO see if there is a registration URL in the launch options
	[self runStartupChecks];
}

- (void)runStartupChecks
{
//	[self beginCheckForRegistration];
//	[self beginCheckForUpdate];
}

- (void)beginCheckForUpdate
{
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:baseURL]];
	GTMHTTPFetcher* myFetcher = [GTMHTTPFetcher fetcherWithRequest:request];
	[myFetcher beginFetchWithDelegate:self didFinishSelector:@selector(updateCheck:finishedWithData:error:)];
}

- (void)updateCheck:(GTMHTTPFetcher *)fetcher finishedWithData:(NSData *)retrievedData error:(NSError *)error {
	if (error != nil) {
		[notificationCenter postNotification:[NSNotification notificationWithName:ERROR_NOTIFICATION object:error]];
	} else {
		// fetch succeeded. For now, act as if we have an update
		updateAvailable = YES;
		[notificationCenter postNotification:[NSNotification notificationWithName:UPDATE_NOTIFICATION object:nil]];
	}
}

- (void)beginCheckForRegistration
{
	if (self.userInfo.email == nil || self.userInfo.email.length == 0) return; // no email address
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@&%@", baseURL, self.userInfo.email]];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	GTMHTTPFetcher* myFetcher = [GTMHTTPFetcher fetcherWithRequest:request];
	[myFetcher beginFetchWithDelegate:self didFinishSelector:@selector(registrationCheck:finishedWithData:error:)];
}

- (void)registrationCheck:(GTMHTTPFetcher *)fetcher finishedWithData:(NSData *)retrievedData error:(NSError *)error {
	if (error != nil) {
		[notificationCenter postNotification:[NSNotification notificationWithName:ERROR_NOTIFICATION object:error]];
	} else {
		// fetch succeeded.
		self.registrationStatus = [[NSString alloc]  initWithBytes:[retrievedData bytes]
													  length:[retrievedData length] encoding: NSUTF8StringEncoding];
		[notificationCenter postNotification:[NSNotification notificationWithName:REGISTRATION_NOTIFICATION object:self.registrationStatus]];
	}
}

/**
 * Look up the user's registration status
 * @param email user email
 * @param callback called with the registration status (REGISTERED, NOT-REGESISTERED, or nil for a network error)
 */
- (void) getRegistrationStatusForEmail:(NSString*)email andCall:(void (^)(NSString *result))callback
{
    if (email && email.length > 0) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@&email=%@", baseURL, email]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        GTMHTTPFetcher* myFetcher = [GTMHTTPFetcher fetcherWithRequest:request];
        [myFetcher beginFetchWithCompletionHandler:^(NSData* data, NSError* error){
            if (error) {
                callback(nil);
            } else {
                NSString *returnedValue = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding: NSUTF8StringEncoding];
                BOOL isRegistered = [returnedValue isEqualToString:REGISTERED];
                callback(isRegistered ? REGISTERED : NOT_REGISTERED);
            }
        }];
    }
}

#pragma mark -
#pragma mark Utility methods

- (UserInfo *)getOrCreateUserInfoInManagedObjectContext:(NSManagedObjectContext*)moc error:(NSError**)error
{
	UserInfo *result = NULL;
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:moc];
	[fetchRequest setEntity:entity];
	NSArray *fetchResults = [context executeFetchRequest:fetchRequest error:error];
	if (error == nil && fetchResults.count > 0) {
		result = [[fetchResults objectAtIndex:0] autorelease];
	} else {
		result = [UserInfo insertInManagedObjectContext:moc];
	}
	[fetchRequest release];
	return [result autorelease];
}


@end
