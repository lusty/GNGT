//
//  GardenDescriptionViewController.m
//  GNGT
//
//  Created by DIANA K STANLEY on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GardenDescriptionViewController.h"
#import "GardenDescriptionView.h"
#import "GardenInfo.h"


@implementation GardenDescriptionViewController
@synthesize gardenNumberLabel = _gardenNumberLabel;
@synthesize gardenNameLabel = _gardenNameLabel;
@synthesize streetLabel = _streetLabel;
@synthesize cityLabel = _cityLabel;
@synthesize plantSaleLabel = _plantSaleLabel;
@synthesize designerLabel = _designerLabel;
@synthesize directionsLabel = _directionsLabel;
@synthesize gardenInstallerLabel = _gardenInstallerLabel;
@synthesize otherLabel = _otherLabel;
@synthesize showcaseLabel = _showcaseLabel;
@synthesize sqftLabel = _sqftLabel;
@synthesize wildlifeLabel = _wildlifeLabel;
@synthesize yearInstalledLabel = _yearInstalledLabel;
@synthesize uniqueId = _uniqueId;
@synthesize gardenDescription = _gardenDescription;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/



/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (void)viewWillAppear:(BOOL)animated {
	NSEntityDescription *gardenDescription = [NSEntityDescription entityForName:@"GardenInfo" inManagedObjectContext:_context];
	 NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:gardenDescription];
	GardenInfo *gardenDescription = [[FailedBankDatabase database] 
									  gardenDescription:_uniqueId];
    if (description != nil) {
        [_gardenNumberLabel setText:[NSString stringWithFormat:@"%d", description.gardenNumber]];
        [_gardenNameLabel setText:description.gardenName];
        [_streetLabel setText:description.street];
        [_cityLabel setText:description.city];     
    }
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
	self.gardenNumberLabel = nil;
	self.gardenNameLabel = nil;
	self.streetLabel = nil;
	self.cityLabel = nil;
    [super dealloc];
}


@end
