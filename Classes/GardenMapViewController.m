    //
//  GardenMapViewController.m
//  GNGT
//
//  Created by Richard Clark on 1/24/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import "GardenMapViewController.h"
#import "GardenDescriptionViewController.h"
#import "GardenInfo.h"

@interface GardenMapViewController (Private)
- (void)startStandardUpdates;
- (void)showDefaultMapAnimated:(BOOL)animated;
@end

@implementation GardenMapViewController
@synthesize mapView, viewSelector;
@synthesize filteredResults;
@synthesize context;
@synthesize fetchedResultsController;
@synthesize locationManager;

enum {
	viewAll = 0,
	viewFavorites,
	viewPlantSales,
	viewTalks
};

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
	
	[sort release];
    [fetchRequest release];
    [theFetchedResultsController release];
	
    return fetchedResultsController;    
	
}

#pragma mark View setup
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
//- (void)viewWillAppear:(BOOL)animated
- (void)viewDidLoad 
{	
	[super viewDidLoad];
	[self showDefaultMapAnimated:NO];
	[self goToCurrentLocation];
}

- (void)showDefaultMapAnimated:(BOOL)animated 
{
	MKCoordinateRegion region = {{37.33336995f, -121.9985405f}, {0.23f, 0.36f}};
	//	region.center = location.coordinate;
	//	region.span.longitudeDelta = 0.15f;
	//	region.span.latitudeDelta = 0.15f;
	[self.mapView setRegion:region animated:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
	// Add annotations
	NSError *error = nil;
	if (self.filteredResults == nil) {
		if ([self.fetchedResultsController performFetch:&error]) {
			self.filteredResults = [NSMutableArray arrayWithArray:fetchedResultsController.fetchedObjects];
			self.viewSelector.selectedSegmentIndex = viewAll;
			[mapView addAnnotations:self.filteredResults];
			[self.viewSelector addTarget:self
								  action:@selector(changeViewFilter:)
						forControlEvents:UIControlEventValueChanged];
		}
		// TODO else, log the error
	}
	
}

- (IBAction)changeViewFilter:(id)sender
{
	GardenInfo *info;
	
	[mapView removeAnnotations:filteredResults];
	[filteredResults removeAllObjects];
	NSString *searchType = NULL;
	switch (self.viewSelector.selectedSegmentIndex) {
		case viewAll:
			[filteredResults addObjectsFromArray:fetchedResultsController.fetchedObjects];
			break;
		
		case viewFavorites:
			// TODO use filteredListWithPredicate?
			searchType = @"favorites";
			for (info in fetchedResultsController.fetchedObjects) {
				if (info.isFavorite) [filteredResults addObject:info];
			}
			break;
			
		case viewPlantSales:
			searchType = @"plant sales";
			for (info in fetchedResultsController.fetchedObjects) {
				if (info.hasPlantSale) [filteredResults addObject:info];
			}
			break;
			
		case viewTalks:
			searchType = @"garden talks";
			for (info in fetchedResultsController.fetchedObjects) {
				if (info.hasGardenTalk) [filteredResults addObject:info];
			}
			break;
			
		default:
			break;
	}
	[mapView addAnnotations:filteredResults];
	if (filteredResults.count == 0 && self.viewSelector.selectedSegmentIndex != viewAll) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"UIAlertView" message:[NSString stringWithFormat:@"No %@ found", searchType]
													   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];	
		[alert release];
	} else {
		// If nothing will be visible, rescale to show the found items
 		if ([[mapView annotationsInMapRect:mapView.visibleMapRect] count] == 0) 
			[self showDefaultMapAnimated:YES];
	}

}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return YES;
}

#pragma mark -
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	self.viewSelector.selectedSegmentIndex = viewAll;
	// TODO send a change event or call the view filter function?
}


#pragma mark Shutdown

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

#pragma mark -
#pragma mark Map adjustments

- (void)setCurrentLocation:(CLLocation *)location {
	MKCoordinateRegion region = {{0.0f, 0.0f}, {0.0f, 0.0f}};
	region.center = location.coordinate;
	region.span.longitudeDelta = 0.15f;
	region.span.latitudeDelta = 0.15f;
	[self.mapView setRegion:region animated:YES];
	
	// TODO show just the annotations within this region? (possible optimization)
//	NSError *error = nil;
//	if (mapView.annotations.count <= 1) {
//		if ([self.fetchedResultsController performFetch:&error]) {
//			[mapView addAnnotations:fetchedResultsController.fetchedObjects];
//		}
//		// TODO else, log the error
//	}

	
}

#pragma mark MapKit Delegate
- (MKAnnotationView *)mapView:(MKMapView *)aMapView 
            viewForAnnotation:(id <MKAnnotation>)annotation {
	if(annotation == aMapView.userLocation) return nil;
	
	BOOL isFavorite = [((GardenInfo *)annotation).isFavorite boolValue];
	BOOL hasPlantSale = ((GardenInfo *)annotation).hasPlantSale;
	BOOL hasGardenTalk = ((GardenInfo *)annotation).hasGardenTalk;
		
	NSString *imageName = isFavorite ? @"favorite.png" : @"poppy.png";
	
	NSString *annotationIdentifier = isFavorite ? @"Favorite" : @"Garden";
	if (hasPlantSale) {
		annotationIdentifier = [annotationIdentifier stringByAppendingString:@"WithSale"];
	}
	if (hasGardenTalk) {
		annotationIdentifier = [annotationIdentifier stringByAppendingString:@"WithTalk"];
	}
	
	MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
	if (annotationView != nil) {
		annotationView.annotation = annotation;
		return annotationView;
	}																 
	
	annotationView = [[[MKAnnotationView alloc] initWithAnnotation:annotation
												reuseIdentifier:annotationIdentifier] autorelease];
	
	CGRect annotationRect = CGRectMake(0.0f, 0.0f, 0.0f, 0.0f);
	UIImage *annotationImage = [UIImage imageNamed:imageName];
	annotationRect.size = annotationImage.size;
	
	UIImage *flowerpot = NULL;
	CGRect flowerpotRect = CGRectMake(0.0f, 0.0f, 0.0f, 0.0f);
	if (hasPlantSale) {
		flowerpot = [UIImage imageNamed:@"flowerpot.png"];
		flowerpotRect.size = flowerpot.size;
		// align to center and bottom of annotation image
		flowerpotRect = CGRectOffset(flowerpotRect, (annotationImage.size.width - flowerpot.size.width) / 2.0, annotationImage.size.height - flowerpot.size.height);
	}
	
	UIImage *speechBubble = NULL;
	CGRect speechRect = CGRectMake(0.0f, 0.0f, 0.0f, 0.0f);
	if (hasGardenTalk) {
		speechBubble = [UIImage imageNamed:@"talk.png"];
		speechRect.size = speechBubble.size;
		// align to center and a corresponding point down in the annotation image
		speechRect = CGRectOffset(speechRect, annotationImage.size.width / 2.0,  (annotationImage.size.width / 2.0) - speechRect.size.height);
	}
	
	//	CGSize maxSize = CGRectInset(self.view.bounds, 10.0f, 10.0f).size;
//	maxSize.height -= self.navigationController.navigationBar.frame.size.height + 40.0f;
//	if (resizeRect.size.width > maxSize.width)
//		resizeRect.size = CGSizeMake(maxSize.width, resizeRect.size.height / resizeRect.size.width * maxSize.width);
//	if (resizeRect.size.height > maxSize.height)
//		resizeRect.size = CGSizeMake(resizeRect.size.width / resizeRect.size.height * maxSize.height, maxSize.height);
//	
	UIGraphicsBeginImageContext(annotationImage.size);
	[annotationImage drawInRect:annotationRect];
	if (hasPlantSale) [flowerpot drawInRect:flowerpotRect];
	if (hasGardenTalk) [speechBubble drawInRect:speechRect];
	UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	annotationView.image = resizedImage;
	annotationView.opaque = NO;
	annotationView.canShowCallout = YES;
	
	UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	annotationView.rightCalloutAccessoryView = rightButton;
	
	return annotationView;
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control { 
	GardenDescriptionViewController *detailController = [[[GardenDescriptionViewController alloc] init] autorelease]; 
	UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:detailController]
																																																										   autorelease];
	detailController.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]
												  initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self
												  action:@selector(stopShowingDetails)]
												 autorelease];
	detailController.info = (GardenInfo *)view.annotation; 
	[self presentModalViewController:nav animated:YES];
}

- (void)stopShowingDetails {
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Location updates

-(IBAction)goToCurrentLocation
{
	if (![CLLocationManager locationServicesEnabled]) return;
	// get the location
	[self startStandardUpdates];
}

- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == locationManager)
        self.locationManager = [[CLLocationManager alloc] init];
	
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
	
    // Set a movement threshold for new events.
    locationManager.distanceFilter = 500;
	
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
	[self setCurrentLocation:newLocation];
	[manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error;
{
	// TODO report the error
	[manager stopUpdatingLocation];
}

@end
