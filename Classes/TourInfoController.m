//
//  TourInfoController.m
//  GNGT
//
//  Created by Richard Clark on 2/4/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import "TourInfoController.h"


@implementation TourInfoController
@synthesize registrationPage;
@synthesize sponsorPage;
@synthesize infoPage;
@synthesize viewSelector;

@synthesize updateButton, registrationButton;

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)viewDidLoad
{
    activeView = nil;
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	// TODO show and position these buttons
	updateButton.hidden = YES;
	registrationButton.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
//    if (activeView) {
//        [self.view 
//    }
    [super viewDidUnload];
}


- (void)dealloc {
    [viewSelector release];
    [infoPage release];
    [sponsorPage release];
    [sponsorPage release];
    [registrationPage release];
    [super dealloc];
}

#pragma mark -
#pragma mark UI operations

- (void)setBadgeText:(NSString*)value;
{
	// TODO find the tab bar item as a child
//	tabBarItem.badgeValue = value;
}

#pragma mark -
#pragma mark User-selectable commands

- (IBAction)downloadUpdate
{
	// TODO implement
}

- (IBAction)registerForTour
{
	// TODO implement
}


@end
