//
//  GardenListViewCell.h
//  GNGT
//
//  Created by Richard Clark on 1/20/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GardenInfo;

@interface GardenListViewCell : UITableViewCell {
	IBOutlet UILabel *gardenNameLabel;
	IBOutlet UILabel *gardenCityLabel;
	IBOutlet UILabel *talkLabel;
	IBOutlet UILabel *plantSaleLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *gardenNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *gardenCityLabel;
@property (nonatomic, retain) IBOutlet UILabel *talkLabel;
@property (nonatomic, retain) IBOutlet UILabel *plantSaleLabel;

- (void) useInfo:(GardenInfo *)info;

@end
