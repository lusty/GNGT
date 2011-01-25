    //
//  GardenMapViewController.m
//  GNGT
//
//  Created by Richard Clark on 1/24/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import "GardenMapViewController.h"


@implementation GardenMapViewController
@synthesize mapView;
@synthesize context;
@synthesize fetchedResultsController;
#pragma mark -
#pragma mark Initialization


- (NSFetchedResultsController *)fetchedResultsController {
	
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
	
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription 
								   entityForName:@"GardenInfo" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];

	NSSortDescriptor *sort = [[NSSortDescriptor alloc] 
							  initWithKey:@"gardenName" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
	
    [fetchRequest setFetchBatchSize:20];
	
    NSFetchedResultsController *theFetchedResultsController = 
	[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest 
										managedObjectContext:context sectionNameKeyPath:nil 
												   cacheName:@"Root"];
    self.fetchedResultsController = theFetchedResultsController;
//    fetchedResultsController.delegate = self; // TODO enable if the data will ever change
	
    [fetchRequest release];
    [theFetchedResultsController release];
	
    return fetchedResultsController;    
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSError *error = nil;
	if ([self.fetchedResultsController performFetch:&error]) {
		[mapView addAnnotations:fetchedResultsController.fetchedObjects];
	}
	// TODO else, log the error
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
