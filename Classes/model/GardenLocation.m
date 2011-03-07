#import "GardenLocation.h"

@implementation GardenLocation

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
