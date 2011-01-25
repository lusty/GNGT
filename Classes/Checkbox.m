//
//  Checkbox.m
//  MyPractice
//
//  Created by Richard Clark on 10/17/08.
//  Copyright 2008 NextQuestion Consulting. All rights reserved.
//

#import "Checkbox.h"
#define CHECK_WIDTH 19.0f
#define CHECK_HEIGHT 16.0f


@interface Checkbox(Private) 
- (void)createRoundRect:(CGRect)rrect withRadius:(CGFloat)radius inContext:(CGContextRef)context;
@end

@implementation Checkbox

@synthesize on;
@synthesize checkmark;

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		tracking = NO;
		on = NO;
		checkmark = [UIImage imageNamed:@"check.png"];
	}
	return self;
}

- (void) setOn:(BOOL)value {
	on = value;
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetRGBStrokeColor(context, 0.4f, 0.4f, 0.4f, 1.0f);
	if (tracking) {
		CGContextSetRGBFillColor(context, 0.9f, 0.9f, 0.0f, 0.3f);
	} else {
		CGContextSetRGBFillColor(context, 1.0f, 1.0f, 1.0f, 1.0f);
	}
	
	CGContextSetLineWidth(context, 3.0f);
	CGRect boxRect = CGRectMake(6.0f, 10.0f, 24.0f, 24.0f);
	[self createRoundRect:boxRect withRadius:3.0f inContext:context];
	CGContextDrawPath(context, kCGPathFillStroke);
	
	if (on) {
		CGRect imageRect = CGRectMake((36.0f - CHECK_WIDTH) / 2.0f, (44.0f - CHECK_HEIGHT)/ 2.0f, CHECK_WIDTH, CHECK_HEIGHT);
		[checkmark drawInRect:imageRect];
	}
	
}

- (void)createRoundRect:(CGRect)rrect withRadius:(CGFloat)radius inContext:(CGContextRef)context
{
	if (radius > rrect.size.width / 2 || radius > rrect.size.height / 2) {
		NSLog(@"ERROR: Radius is greater than half the height or width");
		return;
	}
	// Code from QuartzDemo
	
	// In order to draw a rounded rectangle, we will take advantage of the fact that
	// CGContextAddArcToPoint will draw straight lines past the start and end of the arc
	// in order to create the path from the current position and the destination position.
	
	CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
	CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
	
	// Next, we will go around the rectangle in the order given by the figure below.
	//       minx    midx    maxx
	// miny    2       3       4
	// midy   1 9              5
	// maxy    8       7       6
	// Which gives us a coincident start and end point, which is incidental to this technique, but still doesn't
	// form a closed path, so we still need to close the path to connect the ends correctly.
	// Thus we start by moving to point 1, then adding arcs through each pair of points that follows.
	// You could use a similar technique to create any shape with rounded corners.
	
	// Start at 1
	CGContextMoveToPoint(context, minx, midy);
	// Add an arc through 2 to 3
	CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
	// Add an arc through 4 to 5
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
	// Add an arc through 6 to 7
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
	// Add an arc through 8 to 9
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
	// Close the path
	CGContextClosePath(context);
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
	[super beginTrackingWithTouch:touch withEvent:event];
	tracking = YES;
	[self setNeedsDisplay];
	return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
	[super continueTrackingWithTouch:touch withEvent:event];
	BOOL wasTracking = tracking;
	CGPoint location = [touch locationInView: self];
	tracking = CGRectContainsPoint(self.bounds, location);
	if (tracking != wasTracking) {
		[self setNeedsDisplay];
	}
	return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
	[super endTrackingWithTouch:touch withEvent:event];
	NSLog(@"end tracking with touch in %@\n", self);
	tracking = NO;
	if (touch.tapCount == 1) {
		on = !on;
	}
	[self setNeedsDisplay];
}

- (void)dealloc {
	[super dealloc];
	[checkmark release];
}


@end
