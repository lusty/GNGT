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
- (void)viewWillAppear:(BOOL)animated
{	
	MKCoordinateRegion region = {{37.33336995f, -121.9985405f}, {0.23f, 0.36f}};
//	region.center = location.coordinate;
//	region.span.longitudeDelta = 0.15f;
//	region.span.latitudeDelta = 0.15f;
	[self.mapView setRegion:region animated:NO];
}


- (void)viewDidAppear:(BOOL)animated
{
	if (![CLLocationManager locationServicesEnabled]) return;
	// get the location
	[self startStandardUpdates];
	
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
	switch (self.viewSelector.selectedSegmentIndex) {
		case viewAll:
			[filteredResults addObjectsFromArray:fetchedResultsController.fetchedObjects];
			break;
		
		case viewFavorites:
			// TODO use filteredListWithPredicate?
			for (info in fetchedResultsController.fetchedObjects) {
				if (info.isFavorite) [filteredResults addObject:info];
			}
			break;
			
		case viewPlantSales:
			for (info in fetchedResultsController.fetchedObjects) {
				if (info.hasPlantSale) [filteredResults addObject:info];
			}
			break;
			
		case viewTalks:
			// TODO implement viewTalks
			break;
			
		default:
			break;
	}
	[mapView addAnnotations:filteredResults];

}
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return YES;
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
#pragma mark View filters

-(IBAction)showAll {
	
}
-(IBAction)showFavorites {

}

-(IBAction)showPlantSales {
	
}

-(IBAction)showTalks {
	
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
	
	NSString *imageName = isFavorite ? @"favorite.png" : @"poppy.png";
	NSString *overlayImageName = hasPlantSale ? @"flowerpot.png" : NULL;
	
	NSString *annotationIdentifier = NULL;
	if (hasPlantSale) {
		annotationIdentifier = isFavorite ? @"FavoriteWithSale" : @"GardenWithSale";
	} else {
		annotationIdentifier = isFavorite ? @"Favorite" : @"Garden";
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
	
	UIImage *overlayImage = NULL;
	CGRect overlayRect = CGRectMake(0.0f, 0.0f, 0.0f, 0.0f);
	if (hasPlantSale) {
		overlayImage = [UIImage imageNamed:overlayImageName];
		overlayRect.size = annotationImage.size;
		// align to center and bottom of annotation image
		overlayRect = CGRectOffset(overlayRect, (annotationImage.size.width - overlayImage.size.width) / 2.0, annotationImage.size.height - overlayImage.size.height);
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
	if (hasPlantSale) [overlayImage drawInRect:overlayRect];
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
