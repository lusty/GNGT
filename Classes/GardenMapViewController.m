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
- (NSArray *)performFetch;
- (void)setPredicateForFilter:(int)filterType;
- (void)changeViewFilterTo:(int)newFilterValue;
@end

@implementation GardenMapViewController
@synthesize mapView, viewSelector;
@synthesize filteredResults;
@synthesize context;
@synthesize fetchRequest = _fetchRequest;
@synthesize locationManager;
@synthesize lastView;

enum viewFilter {
	viewAll = 0,
	viewFavorites,
	viewPlantSales,
	viewTalks
};

#pragma mark -
#pragma mark Initialization


- (NSFetchRequest *)fetchRequest {
	
    if (_fetchRequest == NULL) {
		_fetchRequest = [[NSFetchRequest alloc] init];
		NSEntityDescription *entity = [NSEntityDescription 
									   entityForName:@"GardenInfo" inManagedObjectContext:context];
		[_fetchRequest setEntity:entity];
		[_fetchRequest setResultType:NSManagedObjectResultType];
	}	
    return [[_fetchRequest retain] autorelease];    
}

#pragma mark View setup
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
//- (void)viewWillAppear:(BOOL)animated
- (void)viewDidLoad 
{	
	[super viewDidLoad];
	[self showDefaultMapAnimated:NO];
	[self goToCurrentLocation];
	self.lastView = self.viewSelector.selectedSegmentIndex = viewAll;
	[self.viewSelector addTarget:self action:@selector(viewSelectorChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)showDefaultMapAnimated:(BOOL)animated 
{
	MKCoordinateRegion region = {{37.33336995f, -121.9985405f}, {0.23f, 0.36f}};
	//	region.center = location.coordinate;
	//	region.span.longitudeDelta = 0.15f;
	//	region.span.latitudeDelta = 0.15f;
	[self.mapView setRegion:region animated:animated];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated]; 
	[mapView removeAnnotations:mapView.annotations]; // Drop them here and return in viewWillAppear -- let's see if that solves the problem with annotations disappearing
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	NSArray *fetchResults = [self performFetch];
	if (fetchResults)
		[mapView addAnnotations:fetchResults];
}

- (NSArray *)performFetch
{
	// Add annotations
	NSError *error = nil;
	NSArray *fetchResults = [context executeFetchRequest:self.fetchRequest error:&error];
	if (error) {
		// TODO log the error
	}
	return fetchResults;
}

- (void)setPredicateForFilter:(int)filterType
{
	// TODO if this doesn't work, go to in-memory filtering
	NSPredicate *predicate = NULL;
	switch (filterType) {
		case viewAll:
			predicate = NULL;
			break;
		
		case viewFavorites:
			predicate = [NSPredicate predicateWithFormat:@"isFavorite == %@", [NSNumber numberWithBool:YES]];
			break;
		
		case viewPlantSales:
			predicate = [NSPredicate predicateWithFormat:@"plantSale > ''"];
			break;
		
		case viewTalks:
			predicate = [NSPredicate predicateWithFormat:@"gardenTalk > ''"];
			break;
	}
	[self.fetchRequest setPredicate:predicate];
}

- (IBAction)viewSelectorChanged:(id)sender
{
	int newFilterValue = self.viewSelector.selectedSegmentIndex;
	if (newFilterValue != lastView)
		[self changeViewFilterTo:newFilterValue];
}

- (void)changeViewFilterTo:(int)newFilterValue;
{

	[self setPredicateForFilter:newFilterValue];
	// TODO save last value and bounce back to it if nothing found
	NSArray *fetchResults = [self performFetch];
	if (fetchResults) {
		if (fetchResults.count > 0) {
			[mapView removeAnnotations:mapView.annotations];
			[mapView addAnnotations:fetchResults];
			// show the annotated values if they exist but nothing is on screen
			if ([[mapView annotationsInMapRect:mapView.visibleMapRect] count] == 0) 
				[self showDefaultMapAnimated:YES];
			lastView = newFilterValue;
		} else if (newFilterValue != viewAll) { // fetchResults.count == 0
			UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"" message:@"No matching gardens found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
			[alert show];
		}
	}
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return YES;
}
*/

#pragma mark -
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
//	[self changeViewFilterTo:lastView];
	self.viewSelector.selectedSegmentIndex = self.lastView;
}

#pragma mark -
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
	[self.viewSelector removeTarget:self action:@selector(viewSelectorChanged:) forControlEvents:UIControlEventValueChanged];
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
