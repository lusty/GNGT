//
//  GardenDescriptionViewController.h
//  GNGT
//
//  Created by Richard Clark on 2/1/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GardenInfo;
@class StarControl;

@interface GardenDescriptionViewController : UITableViewController {
	UIView		*headerView;
	StarControl *starControl;
	UILabel		*nameLabel;
	UILabel		*numberLabel;
	
	GardenInfo *info;
	NSMutableArray *labels;
	NSMutableArray *values;
}

@property (nonatomic, retain) IBOutlet UIView *headerView;
@property (nonatomic, retain) IBOutlet StarControl *starControl;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *numberLabel;
@property (nonatomic, retain) GardenInfo *info;
@property (nonatomic, retain) NSMutableArray *labels;
@property (nonatomic, retain) NSMutableArray *values;

@end
