    //
//  GardenMapViewController.m
//  GNGT
//
//  Created by Richard Clark on 1/24/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import "GardenMapViewController.h"
#import "GardenDescriptionViewController.h"


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
	
	[sort release];
    [fetchRequest release];
    [theFetchedResultsController release];
	
    return fetchedResultsController;    
	
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return YES;
}

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
	
	// TODO show all annotations within this region? (possible optimization)
	NSError *error = nil;
	if (mapView.annotations.count <= 1) {
		if ([self.fetchedResultsController performFetch:&error]) {
			[mapView addAnnotations:fetchedResultsController.fetchedObjects];
		}
		// TODO else, log the error
	}

	
}

#pragma mark MapKit Delegate
- (MKAnnotationView *)mapView:(MKMapView *)aMapView 
            viewForAnnotation:(id <MKAnnotation>)annotation {
	MKPinAnnotationView *view = nil;
	if(annotation != aMapView.userLocation) {
		view = (MKPinAnnotationView *)
        [aMapView dequeueReusableAnnotationViewWithIdentifier:@"annotations"];
		if(nil == view) {
			view = [[[MKPinAnnotationView alloc]
					 initWithAnnotation:annotation reuseIdentifier:@"annotations"]
					autorelease];
			view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		}
		[view setPinColor:MKPinAnnotationColorPurple];
		[view setCanShowCallout:YES];
		[view setAnimatesDrop:YES];
	} else {
		CLLocation *location = [[CLLocation alloc] 
								initWithLatitude:annotation.coordinate.latitude
								longitude:annotation.coordinate.longitude];
		[self setCurrentLocation:location];
	}
	return view;
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

@end
