//
//  GardenDescriptionViewController.h
//  GNGT
//
//  Created by DIANA K STANLEY on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GardenInfo;

@interface GardenDescriptionViewController : UIViewController {
	GardenInfo *info;
}

@property (nonatomic, retain) GardenInfo *info;

@end
