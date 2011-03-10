#import "GardenLocation.h"
#import "Garden.h"

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
    return self.garden.name;
}

 - (NSString *) subtitle
 {
	 NSString *result = NULL;
	 if (self.garden.hasPlantSaleValue) result = @"plant sale";
	 
	 if (self.garden.hasGardenTalkValue) {
		 if (result) {
			 result = [result stringByAppendingString:@", garden talk"];
		 } else {
			 result = @"garden talk";
		 }
	 }
	 return result;
 }

@end
