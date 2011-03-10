//
//  GNGTAppDelegate.m
//  GNGT
//
//  Created by DIANA K STANLEY on 1/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GNGTAppDelegate.h"
#import "DatabaseAccess.h"
#import "UpdateManager.h"
#import "Garden.h"

@interface GNGTAppDelegate(Private)
- (void)gardenInfoChangeHandler:(NSNotification *)notification;
- (void)receivedUpdateNotification:(NSNotification *)notification;
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
	notificationCenter = [[NSNotificationCenter defaultCenter] retain];
    [notificationCenter addObserver:self selector:@selector(gardenInfoChangeHandler:) name:@"GardenInfoChanged" object:nil];
    [notificationCenter addObserver:self selector:@selector(receivedUpdateNotification:) name:UPDATE_NOTIFICATION object:nil];
	[self.window makeKeyAndVisible];
    
	updateManager = [UpdateManager sharedUpdateManager]; // retained by default
	[updateManager applicationFinishedLaunchingWithOptions:launchOptions];
    return YES;
}

- (void)gardenInfoChangeHandler:(NSNotification *)notification
{
	NSError *err = nil;
	Garden *garden = [notification object];
	[garden.managedObjectContext save:&err];
	// TODO handle the error if it's non-nil
}

- (void)receivedUpdateNotification:(NSNotification *)notification
{
	// Add a badge to the "Tour" window. That view controller will do the right thing.
	UITabBarItem *tab = [tabBarController.tabBar.items objectAtIndex:0];
	tab.badgeValue = @"1";
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
    [updateManager release];
	updateManager = nil;
    [window release];
    [super dealloc];
}


@end

