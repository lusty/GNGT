//
//  UIConstants.h
//  GNGT
//
//  Created by Richard Clark on 2/9/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIConstants : NSObject {
	UIColor *lightGreen;
	UIColor *darkGreen;
}

@property (nonatomic, retain) UIColor *lightGreen;
@property (nonatomic, retain) UIColor *darkGreen;

- (id)init;
+ (UIConstants *)sharedUIConstants;

@end
