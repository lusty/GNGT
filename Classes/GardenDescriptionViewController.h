//
//  GardenDescriptionViewController.h
//  GNGT
//
//  Created by Richard Clark on 2/1/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GardenInfo;
@interface GardenDescriptionViewController : UITableViewController {
	GardenInfo *info;
	NSMutableArray *labels;
	NSMutableArray *values;
}

@property (nonatomic, retain) GardenInfo *info;
@property (nonatomic, copy) NSMutableArray *labels;
@property (nonatomic, copy) NSMutableArray *values;

@end
