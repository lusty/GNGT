//
//  DateFormatters.m
//  GNGT
//
//  Created by Richard Clark on 3/9/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import "DateFormatters.h"


@implementation DateFormatters

static NSDateFormatter *shortDateFormatter = nil;
static NSDateFormatter *isoDateFormatter = nil;

+ (NSDateFormatter*) shortDateFormatter
{
	@synchronized(self) {
		if (shortDateFormatter == nil) {
			shortDateFormatter = [[NSDateFormatter alloc] init];
			shortDateFormatter.timeStyle = NSDateFormatterNoStyle;
			shortDateFormatter.dateFormat = @"yyyy-MM-dd";
		}
	}
	return [[shortDateFormatter retain] autorelease];
}

+ (NSDateFormatter*) isoDateFormatter
{
	@synchronized(self) {
		if (isoDateFormatter == nil) {
			isoDateFormatter = [[NSDateFormatter alloc] init];
			isoDateFormatter.timeStyle = NSDateFormatterFullStyle;
			isoDateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZ";
		}
	}
	return [[isoDateFormatter retain] autorelease];
}


@end
