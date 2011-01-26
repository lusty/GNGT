//
//  StarControl.m
//  GNGT
//
//  Created by Richard Clark on 10/17/08, updated 1/26/11.
//  Copyright 2008, 2011 NextQuestion Consulting. All rights reserved.
//

#import "StarControl.h"

@interface StarControl(Private) 
- (CGPathRef)createStarPathAt:(CGPoint)origin;
@end

@implementation StarControl

@synthesize on;

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		tracking = NO;
		on = NO;
	}
	return self;
}

- (void) setOn:(BOOL)value {
	on = value;
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
	if (self->starPath == nil) {
		CGPoint offset = CGPointMake(6.0f, 10.0f);
		self->starPath = [self createStarPathAt:offset];
	}
	
	CGContextRef context = UIGraphicsGetCurrentContext();

	if (on) {
		CGContextSetRGBStrokeColor(context, 0.0f, 0.0f, 0.0f, 1.0f);
	} else {
		CGContextSetRGBStrokeColor(context, 0.6f, 0.6f, 0.6f, 1.0f);
	}
	
	if (tracking) {
		CGContextSetRGBFillColor(context, 0.9f, 0.9f, 0.0f, 0.3f);
	} else if (on) {
		CGContextSetRGBFillColor(context, 1.0f, 1.0f, 0.0f, 1.0f);
	} else {
		CGContextSetRGBFillColor(context, 1.0f, 1.0f, 1.0f, 1.0f);
	}
	
	CGContextSetLineWidth(context, 1.5f);
	CGContextAddPath(context, self->starPath);
	CGContextDrawPath(context, kCGPathFillStroke);
		
}

- (CGPathRef)createStarPathAt:(CGPoint)origin
{
	CGPoint vertices[] = {
		CGPointMake( 4.9f, 23.5f), CGPointMake(12.0f, 18.1f), 
		CGPointMake(19.1f, 23.5f), CGPointMake(16.4f, 14.7f), 
		CGPointMake(23.5f,  9.3f), CGPointMake(14.7f,  9.3f), 
		CGPointMake(12.0f,  0.5f), CGPointMake( 9.3f,  9.3f), 
		CGPointMake( 0.5f,  9.3f), CGPointMake( 7.6f, 14.7f)
	};
	
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL, vertices[0].x+origin.x, vertices[0].y+origin.y);
	for (int i = 1; i < 10; i++) {
		CGPathAddLineToPoint(path, NULL, vertices[i].x+origin.x, vertices[i].y+origin.y);
	}
	CGPathAddLineToPoint(path, NULL, vertices[0].x+origin.x, vertices[0].y+origin.y);
	CGPathCloseSubpath(path);
	CGPathRetain(path);
	return path;
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
	CGPoint location = [touch locationInView: self];
	if (CGRectContainsPoint(self.bounds, location)) {
		on = !on;
	}
	[self setNeedsDisplay];
}

- (void)dealloc {
	if (self->starPath) {
		CGPathRelease(self->starPath);
		self->starPath = nil;
	}
	[super dealloc];
}


@end
