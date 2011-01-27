//
//  GardenInfoViewCell.h
//  GNGT
//
//  Created by Richard Clark on 1/26/11.
//  Copyright 2010 NextQuestion Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>


@class GardenInfo;
@class GardensListViewController;

@interface GardenInfoViewCell : UITableViewCell {
	GardenInfo *info;
}

- (void)setCheckboxHidden:(BOOL)visible animated:(BOOL)animate;

@property (nonatomic, retain) GardenInfo *info;

@end
