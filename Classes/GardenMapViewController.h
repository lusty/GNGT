//
//  GardenMapViewController.h
//  GNGT
//
//  Created by Richard Clark on 1/24/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h> 
#import <MapKit/MapKit.h>

@interface GardenMapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> {
	MKMapView	*mapView;
	
	NSFetchedResultsController *fetchedResultsController;
	NSManagedObjectContext *context;
	CLLocationManager *locationManager;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) CLLocationManager *locationManager;

@end
