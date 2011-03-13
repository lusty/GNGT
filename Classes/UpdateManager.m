//
//  GNGTUpdateManager.m
//  GNGT
//
//  Created by Richard Clark on 3/8/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import "UpdateManager.h"
#import "SynthesizeSingleton.h"
#import "GNGT.h"

#import "DatabaseAccess.h"
#import "UserInfo.h"

#import "JSONKit.h"
#import "Importer.h"

#include "GTMHTTPFetcher.h"

@interface UpdateManager(Private)
- (void)updateCheck:(GTMHTTPFetcher *)fetcher finishedWithData:(NSData *)retrievedData error:(NSError *)error;
@end

@implementation UpdateManager
SYNTHESIZE_SINGLETON_FOR_CLASS(UpdateManager)

@synthesize updateAvailable;

- (id)init
{
    self = [super init];
    if (self) {
		updateAvailable = NO;
		databaseAccess = [DatabaseAccess sharedDatabaseAccess]; // singleton is retained by default
		context = [[databaseAccess managedObjectContext] retain];
		notificationCenter = [[NSNotificationCenter defaultCenter] retain];
    }
    return self;
}

- (void)beginCheckForUpdate
{
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:BASE_URL]];
	GTMHTTPFetcher* myFetcher = [GTMHTTPFetcher fetcherWithRequest:request];
	[myFetcher beginFetchWithDelegate:self didFinishSelector:@selector(updateCheck:finishedWithData:error:)];
}

- (void)updateCheck:(GTMHTTPFetcher *)fetcher finishedWithData:(NSData *)retrievedData error:(NSError *)error 
{
	if (error != nil) {
		[notificationCenter postNotification:[NSNotification notificationWithName:ERROR_NOTIFICATION object:error]];
	} else {
		// fetch succeeded. For now, act as if we have an update
		updateAvailable = YES;
		[notificationCenter postNotification:[NSNotification notificationWithName:UPDATE_NOTIFICATION object:nil]];
	}
}



@end
