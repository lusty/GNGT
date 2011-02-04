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

@property (nonatomic, retain) GardenInfo *info;

- (id)initWithReuseIdentifier:(NSString *)identifier hasNotes:(BOOL)hasNotes;

@end
