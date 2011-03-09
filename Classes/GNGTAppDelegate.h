//
//  GNGTAppDelegate.h
//  GNGT
//
//  Created by DIANA K STANLEY on 1/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class GardensListViewController;
@class GardenMapViewController;

@interface GNGTAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
	UINavigationController *_navController;
	UITabBarController *tabBarController;
//	GardensListViewController *gardenListController;
//	GardenMapViewController *gardenMapController;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
//@property (nonatomic, retain) IBOutlet GardensListViewController *gardenListController;
//@property (nonatomic, retain) IBOutlet GardenMapViewController *gardenMapController;

@end

