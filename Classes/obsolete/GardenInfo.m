// 
//  GardenInfo.m
//  GNGT
//
//  Created by DIANA K STANLEY on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GardenInfo.h"


@implementation GardenInfo 

@dynamic gardenNumber;
@dynamic gardenName;
@dynamic street;
@dynamic city;
@dynamic plantSale;
@dynamic gardenTalk;
@dynamic gardenDescription;
@dynamic latitude;
@dynamic longitude;
@dynamic isFavorite;

- (CLLocationCoordinate2D)coordinate;
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = [self.latitude floatValue];
    theCoordinate.longitude = [self.longitude floatValue];
    return theCoordinate; 
}

- (BOOL) hasPlantSale 
{
	return self.plantSale != NULL && self.plantSale.length > 0;
}

- (BOOL) hasGardenTalk 
{
	return self.gardenTalk != NULL && self.gardenTalk.length > 0;
}

- (NSString *)title
{
    return self.gardenName;
}

- (NSString *) subtitle
{
	NSString *result = NULL;
	if ([self hasPlantSale]) result = @"plant sale";
	
	if ([self hasGardenTalk]) {
		if (result) {
			result = [result stringByAppendingString:@", garden talk"];
		} else {
			result = @"garden talk";
		}
	}
	return result;
}

@end


