//
//  GardenDescription.m
//  GNGT
//
//  Created by DIANA K STANLEY on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GardenDescriptionView.h"
#import "GardenInfo.h"

@implementation GardenDescriptionView
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

- (void)setGardenInfo:(GardenInfo *)info {
//	self.gardenNumberLabel.text = info.gardenNumber; // TODO format this into a string
	self.gardenNameLabel.text = info.gardenName;
	self.streetLabel.text = info.street;
	self.cityLabel.text = info.city;
	self.plantSaleLabel.text = info.plantSale;
	
	// Talk to me about an alternate way of doing this (as a collection of named data items instead of one big object) -- RDC
//	GardenDescription *description = info.gardenDescription;
//	self.designer = description.designer;
//	self.directions = description.directions;
//	self.gardenInstaller = description.gardenInstaller;
//	self.other = description.other;
//	self.showcase = description.showcase;
//	self.sqft = description.sqft;
//	self.wildlife = description.wildlife;
}



- (void) dealloc {
	[super dealloc];
}

@end
