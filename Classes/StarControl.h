//
//  StarControl.m
//  GNGT
//
//  Created by Richard Clark on 10/17/08, updated 1/26/11.
//  Copyright 2008, 2011 NextQuestion Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StarControl : UIControl {
	BOOL on;	
	
@private
	CGPathRef starPath;
	BOOL tracking;
}

@property (nonatomic) BOOL on;


@end
