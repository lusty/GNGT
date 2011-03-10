#import "Tour.h"
#import "DateFormatters.h"

@interface Tour(Private)
NSDate *xsdDateTimeToNSDate (NSString *dateTime);
@end
@implementation Tour

@dynamic tourDate;

- (void)setTourDate:(NSString*)jsonDateString
{
    NSDate *date = [[DateFormatters shortDateFormatter] dateFromString: jsonDateString];
    if (!date) NSLog(@"could not parse date '%@'", jsonDateString);
	self.tourNSDate = date;
}

- (id)tourDate
{
	return [[DateFormatters shortDateFormatter] stringFromDate:self.tourNSDate];
}

- (void)setDoNotShowPrivateBefore:(NSString*)jsonDateString
{
    NSDate *date = [[DateFormatters isoDateFormatter] dateFromString: jsonDateString];
	self.hidePrivateBeforeDate = date;
}

- (id)doNotShowPrivateBefore
{
	return [[DateFormatters isoDateFormatter] stringFromDate:self.hidePrivateBeforeDate];
}

- (void)setDoNotShowPrivateAfter:(NSString*)jsonDateString
{
    NSDate *date = [[DateFormatters isoDateFormatter] dateFromString: jsonDateString];
	self.hidePrivateAfterDate = date;
}

- (id)doNotShowPrivateAfter
{
	return [[DateFormatters isoDateFormatter] stringFromDate:self.hidePrivateAfterDate];
}


@end
