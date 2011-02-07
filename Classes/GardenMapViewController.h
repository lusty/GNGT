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
	UISegmentedControl *viewSelector;
	
	NSFetchRequest *_fetchRequest;
	NSMutableArray *filteredResults;
	NSManagedObjectContext *context;
	CLLocationManager *locationManager;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UISegmentedControl *viewSelector;
@property (nonatomic, retain) NSFetchRequest *fetchRequest;
@property (nonatomic, retain) NSMutableArray *filteredResults;
@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) CLLocationManager *locationManager;

-(IBAction)goToCurrentLocation;

@end
