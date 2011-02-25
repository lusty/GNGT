// 
//  GardenLocation.m
//  GNGT
//
//  Created by Richard Clark on 2/24/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import "GardenLocation.h"

#import "Garden.h"

@implementation GardenLocation 

@dynamic streetAddress;
@dynamic name;
@dynamic note;
@dynamic latitude;
@dynamic longitude;
@dynamic garden;

#pragma mark -
#pragma mark MKAnnotation

- (CLLocationCoordinate2D)coordinate;
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = [self.latitude floatValue];
    theCoordinate.longitude = [self.longitude floatValue];
    return theCoordinate; 
}

- (NSString *)title
{
    return self.name;
}

/*
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
 */

@end
