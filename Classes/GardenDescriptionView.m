//
//  GardenDescription.m
//  GNGT
//
//  Created by DIANA K STANLEY on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GardenDescriptionView.h"


@implementation GardenDescriptionView
@synthesize uniqueId = _uniqueId;
@synthesize gardenNumber = _gardenNumber;
@synthesize gardenName = _gardenName;
@synthesize street = _street;
@synthesize city = _city;
@synthesize plantSale = _plantSale;
@synthesize designer = _designer;
@synthesize directions = _directions;
@synthesize gardenInstaller = _gardenInstaller;
@synthesize other = _other;
@synthesize showcase = _showcase;
@synthesize sqft = _sqft;
@synthesize wildlife = _wildlife;
@synthesize yearInstalled = _yearInstalled;

- (id)initWithUniqueId:(int)uniqueId gardenNumber:(int)gardenNumber gardenName:(NSString *)gardenName 
				street:(NSString *)street city:(NSString *)city plantSale:(NSString *)plantSale
			  designer:(NSString *)designer directions:(NSString *)directions gardenInstaller:(NSString *)gardenInstaller
				 other:(NSString *)other showcase:(NSString *)showcase sqft:(int)sqft wildlife:(NSString *)wildlife
		 yearInstalled:(int)yearInstalled {
    if ((self = [super init])) {
        self.uniqueId = uniqueId;
		self.gardenNumber = gardenNumber;
        self.gardenName = gardenName;
		self.street = street;
        self.city = city;
        self.plantSale = plantSale;
        self.designer = designer;
        self.directions = directions;
        self.gardenInstaller = gardenInstaller;
        self.other = other;
        self.showcase = showcase;
        self.sqft = sqft;
        self.wildlife = wildlife;
    }
    return self;
}

- (void) dealloc {
	self.gardenName = nil;
	self.street = nil;
	self.city = nil;
	self.plantSale = nil;
	self.designer = nil;
	self.directions = nil;
	self.gardenInstaller = nil;
	self.other = nil;
	self.showcase = nil;
	self.wildlife = nil;
	[super dealloc];
}

@end
