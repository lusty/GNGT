//
//  UIConstants.m
//  GNGT
//
//  Created by Richard Clark on 2/9/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import "UIConstants.h"
#import "SynthesizeSingleton.h"

@implementation UIConstants

SYNTHESIZE_SINGLETON_FOR_CLASS(UIConstants);

@synthesize lightGreen, darkGreen;

//=========================================================== 
// - (id)init
//
//=========================================================== 
- (id)init
{
    self = [super init];
    if (self) {
		darkGreen = [[UIColor colorWithRed:0.176f green:0.396f blue:0.204f alpha:1.0f] retain];
		lightGreen = [[UIColor colorWithRed:0.808f green:0.863f blue:0.816 alpha:1.0f] retain];
    }
    return self;
}


@end
