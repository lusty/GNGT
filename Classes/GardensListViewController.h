//
//  GardensListViewController.h
//  GNGT
//
//  Created by DIANA K STANLEY on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GardenDescriptionViewController;

@interface GardensListViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
	NSFetchedResultsController *_fetchedResultsController;
	NSManagedObjectContext *_context;
	GardenDescriptionViewController *_description;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) GardenDescriptionViewController *description;

@end
