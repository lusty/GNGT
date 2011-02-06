//
//  GardensListViewController.h
//  GNGT
//
//  Created by DIANA K STANLEY on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GardenDescriptionViewController;

@interface GardensListViewController : UITableViewController <NSFetchedResultsControllerDelegate, UINavigationControllerDelegate> {
	NSArray *_sortDescriptors;
	NSFetchRequest *_fetchRequest;
	NSFetchedResultsController *_fetchedResultsController;
	NSManagedObjectContext *_context;
	GardenDescriptionViewController *_description;
	UIColor *lightGreen;
	UIColor *darkGreen;
}

@property (nonatomic, retain) NSArray *sortDescriptors;
@property (nonatomic, retain) NSFetchRequest *fetchRequest;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, readonly) NSString *sectionNameKeyPath;

@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) GardenDescriptionViewController *description;
@property (nonatomic, retain) UIColor *lightGreen;
@property (nonatomic, retain) UIColor *darkGreen;

@end
