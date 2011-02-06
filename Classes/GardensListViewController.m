//
//  GardensListViewController.m
//  GNGT
//
//  Created by DIANA K STANLEY on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GardensListViewController.h"
#import "GardenDescriptionViewController.h"
#import "GardenInfo.h"
#import "GardenInfoViewCell.h"

@implementation GardensListViewController

@synthesize fetchRequest = _fetchRequest;
@synthesize sortDescriptors = _sortDescriptors;;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize context = _context;

@synthesize description = _description;
@synthesize lightGreen, darkGreen;

@dynamic sectionNameKeyPath;

#pragma mark -
#pragma mark Initialization

- (NSArray *)sortDescriptors
{
	if (_sortDescriptors == NULL) {
		NSSortDescriptor *citySort = [[[NSSortDescriptor alloc] 
									   initWithKey:@"city" 
									   ascending:YES
									   selector:@selector(localizedCaseInsensitiveCompare:)] autorelease];
		NSSortDescriptor *nameSort = [[[NSSortDescriptor alloc] 
									   initWithKey:@"gardenName" 
									   ascending:YES
									   selector:@selector(localizedCaseInsensitiveCompare:)] autorelease];
		_sortDescriptors = [NSArray arrayWithObjects:citySort, nameSort, nil];
	}
	return [[_sortDescriptors retain] autorelease];
}

- (NSFetchRequest *)fetchRequest 
{
	if (_fetchRequest == NULL) {
		_fetchRequest = [[NSFetchRequest alloc] init];
		NSEntityDescription *entity = [NSEntityDescription 
									   entityForName:@"GardenInfo" inManagedObjectContext:_context];
		[_fetchRequest setEntity:entity];
		
		[_fetchRequest setSortDescriptors:self.sortDescriptors];
		
		[_fetchRequest setFetchBatchSize:20];
	}
	return [[_fetchRequest retain] autorelease];
}

- (NSString *) sectionNameKeyPath
{
	return @"city";
}

- (NSFetchedResultsController *)fetchedResultsController 
{
	
    if (_fetchedResultsController == NULL) {
		_fetchedResultsController = 
		[[NSFetchedResultsController alloc] initWithFetchRequest:self.fetchRequest 
											managedObjectContext:_context sectionNameKeyPath:self.sectionNameKeyPath 
													   cacheName:nil];
		_fetchedResultsController.delegate = self;
	}
    return [[_fetchedResultsController retain] autorelease];    
	
}


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
	
	((UITableView *)self.view).sectionIndexMinimumDisplayRowCount = 500; // turn off the letters on the right-hand side
    self.title = @"Gardens";
	
	self.darkGreen = [UIColor colorWithRed:0.176f green:0.396f blue:0.204f alpha:1.0f];
	self.lightGreen = [UIColor colorWithRed:0.808f green:0.863f blue:0.816 alpha:1.0f];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { 
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo name];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.fetchedResultsController sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [self.fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}

#pragma mark -
#pragma mark Table view delegate

// Customize the appearance of table view cells.
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    GardenInfo *info = [_fetchedResultsController objectAtIndexPath:indexPath];
	((GardenInfoViewCell*)cell).info = info;
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    GardenInfo *info = [_fetchedResultsController objectAtIndexPath:indexPath];
	BOOL hasNotes = info.hasPlantSale | info.hasGardenTalk;
	NSString *CellIdentifier = hasNotes ? @"GardenListWIthNotes" : @"GardenListCell";
	
//    GardenInfoViewCell* cell = (GardenInfoViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
	GardenInfoViewCell* cell = [[[GardenInfoViewCell alloc] initWithReuseIdentifier:CellIdentifier hasNotes:hasNotes] autorelease];
//    }
	
    // Set up the cell...
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.description == nil) {
        self.description = [[[GardenDescriptionViewController alloc] initWithNibName:@"GardenDescriptionViewController" bundle:nil] autorelease];        
    }
	GardenInfo *info = (GardenInfo *)[_fetchedResultsController objectAtIndexPath:indexPath];
	self.description.info = info;
    [self.navigationController pushViewController:_description animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
	
    // Create label with section title
    UILabel *label = [[[UILabel alloc] init] autorelease];
    label.frame = CGRectMake(0, 0, 320, 20);
    label.backgroundColor = self.lightGreen;
    label.textColor = self.darkGreen;
    label.shadowColor = [UIColor lightGrayColor];
    label.shadowOffset = CGSizeMake(0.0, 1.0);
    label.font = [UIFont boldSystemFontOfSize:16];
    label.text = sectionTitle;
	
    // Create header view and add label as a subview
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20.0f)];
	view.backgroundColor = self.lightGreen;
    [view autorelease];
    [view addSubview:label];
	
    return view;
}

#pragma mark -
#pragma mark Fetched results controller delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
	
    UITableView *tableView = self.tableView;
	
    switch(type) {
			
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
			
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
			
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
			
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            // Reloading the section inserts a new row and ensures that titles are updated appropriately.
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:newIndexPath.section] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
	
    switch(type) {
			
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
			
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}

#pragma mark -
#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	// Ensure that the table is up to date on returning from a detail view (e.g. if the favorites star changed)
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	self.fetchedResultsController = nil;
}


- (void)dealloc {
	self.fetchedResultsController = nil;
	self.context = nil;
	self.description = nil;
    [super dealloc];
}


@end

