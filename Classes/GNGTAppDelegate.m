//
//  GNGTAppDelegate.m
//  GNGT
//
//  Created by DIANA K STANLEY on 1/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GNGTAppDelegate.h"
#import "DatabaseAccess.h"

#import "Garden.h"
#import "GardensListViewController.h"
#import "GardenMapViewController.h"

#import "JSONKit.h"
#import "Importer.h"

#include "GTMHTTPFetcher.h"

@interface GNGTAppDelegate(Private)
- (void)beginCheckForUpdate;
- (void)updateCheck:(GTMHTTPFetcher *)fetcher finishedWithData:(NSData *)retrievedData error:(NSError *)error;
@end

@implementation GNGTAppDelegate

@synthesize window;
@synthesize navController = _navController;
@synthesize tabBarController;
//@synthesize gardenListController, gardenMapController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{ 
	[window addSubview:tabBarController.view];
    [[NSNotificationCenter defaultCenter] addObserver:self
		selector:@selector(gardenInfoChangeHandler:)
		name:@"GardenInfoChanged" object:nil];
    [self.window makeKeyAndVisible];
    
	// Kick off a check to see if we have the latest map
	[self beginCheckForUpdate];
/*
	// =================
	// TEST TEST TEST
	// Add a notification to the tab bar
	UITabBarItem *tab = [tabBarController.tabBar.items objectAtIndex:0];
	tab.badgeValue = @"1";
	// =================
*/
    return YES;
}

- (void)beginCheckForUpdate
{
	NSURL *url = [NSURL URLWithString:@"http://www.example.com/"]; // This will need to change depending on the tour
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	GTMHTTPFetcher* myFetcher = [GTMHTTPFetcher fetcherWithRequest:request];
	[myFetcher beginFetchWithDelegate:self
					didFinishSelector:@selector(updateCheck:finishedWithData:error:)];
}


- (void)updateCheck:(GTMHTTPFetcher *)fetcher finishedWithData:(NSData *)retrievedData error:(NSError *)error {
	if (error != nil) {
		// failed; either an NSURLConnection error occurred, or the server returned
		// a status value of at least 300
		//
		// the NSError domain string for server status errors is kGTMHTTPFetcherStatusDomain
//		int status = [error code];
	} else {
		// fetch succeeded
		// Add a notification to the tab bar
		UITabBarItem *tab = [tabBarController.tabBar.items objectAtIndex:0];
		tab.badgeValue = @"1";
	}
}

- (void)gardenInfoChangeHandler:(NSNotification *)notification
{
	NSError *err = nil;
	Garden *garden = [notification object];
	[garden.managedObjectContext save:&err];
	// TODO handle the error if it's non-nil
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
    [[DatabaseAccess sharedDatabaseAccess] saveContext];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
	[[NSNotificationCenter defaultCenter] removeObserver:self];	
    [[DatabaseAccess sharedDatabaseAccess] saveContext];
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	self.navController = nil;
    
    [window release];
    [super dealloc];
}


@end

