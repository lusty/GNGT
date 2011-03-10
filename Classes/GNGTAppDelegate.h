//
//  GNGTAppDelegate.h
//  GNGT
//
//  Created by DIANA K STANLEY on 1/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UpdateManager;

@interface GNGTAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
	UINavigationController *_navController;
	UITabBarController *tabBarController;
    NSNotificationCenter *notificationCenter;
	
@private
	UpdateManager *updateManager;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end

