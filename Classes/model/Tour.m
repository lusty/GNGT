#import "Tour.h"

@interface Tour(Private)
NSDate *xsdDateTimeToNSDate (NSString *dateTime);
@end
@implementation Tour

@dynamic tourDate;

- (void)setTourDate:(NSString*)jsonDateString
{
	// Adapted from code by Jens Alfke.
	// Picked up from http://borkware.com/quickies/one?topic=NSDate
    static NSDateFormatter *xsdDateTimeFormatter;
    if (!xsdDateTimeFormatter) {
        xsdDateTimeFormatter = [[NSDateFormatter alloc] init];  // Keep around forever
        xsdDateTimeFormatter.timeStyle = NSDateFormatterFullStyle;
        xsdDateTimeFormatter.dateFormat = @"yyyy-MM-dd";
    }
	
    // Date formatters don't grok a single trailing Z, so make it "GMT".
    if ([jsonDateString hasSuffix: @"Z"]) {
        jsonDateString = [[jsonDateString substringToIndex: jsonDateString.length - 1]
						  stringByAppendingString: @"GMT"];
    }
	
    NSDate *date = [xsdDateTimeFormatter dateFromString: jsonDateString];
    if (!date) NSLog(@"could not parse date '%@'", jsonDateString);
	self.tourNSDate = date;
}

- (id)tourDate
{
    static NSDateFormatter *xsdDateTimeFormatter;
    if (!xsdDateTimeFormatter) {
        xsdDateTimeFormatter = [[NSDateFormatter alloc] init];  // Keep around forever
        xsdDateTimeFormatter.timeStyle = NSDateFormatterFullStyle;
        xsdDateTimeFormatter.dateFormat = @"yyyy-MM-dd";
    }
	return [xsdDateTimeFormatter stringFromDate:self.tourNSDate];
}


@end
