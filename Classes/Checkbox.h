//
//  Checkbox.h
//  MyPractice
//
//  Created by Richard Clark on 10/17/08.
//  Copyright 2008 NextQuestion Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Checkbox : UIControl {
	BOOL on;	
	UIImage *checkmark;
	
@private
	BOOL tracking;
}

@property (nonatomic) BOOL on;

@property (retain) UIImage *checkmark;

#define CHECKBOX_SIZE 44.0f

@end
