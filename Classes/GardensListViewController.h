//
//  GardensListViewController.h
//  GNGT
//
//  Created by DIANA K STANLEY on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GardenDescriptionViewController;

@interface GardensListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UINavigationControllerDelegate> {
	UITableView *tableView;
	UISegmentedControl *sortControl;
	NSArray *_sortDescriptors;
	NSFetchRequest *_fetchRequest;
	NSFetchedResultsController *_fetchedResultsController;
	int sortMode;
	BOOL sortModeChanged;
	
	NSManagedObjectContext *_context;
	GardenDescriptionViewController *_description;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UISegmentedControl *sortControl;

@property (nonatomic, retain) NSArray *sortDescriptors;
@property (nonatomic, retain) NSFetchRequest *fetchRequest;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, readonly) NSString *sectionNameKeyPath;
@property (nonatomic) int sortMode;
@property (nonatomic) BOOL sortModeChanged;

@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) IBOutlet GardenDescriptionViewController *detailsController;

@end
