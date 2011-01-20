//
//  GardenDescription.h
//  GNGT
//
//  Created by DIANA K STANLEY on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GardenInfo;
@interface GardenDescriptionView : UIView {
	UILabel* _gardenNumberLabel;
	UILabel* _gardenNameLabel;
	UILabel* _streetLabel;
	UILabel* _cityLabel;
	UILabel* _plantSaleLabel;
	UILabel* _designerLabel;
	UILabel* _directionsLabel;
	UILabel* _gardenInstallerLabel;
	UILabel* _otherLabel;
	UILabel* _showcaseLabel;
	UILabel* _sqftLabel;
	UILabel* _wildlifeLabel;
	UILabel* _yearInstalledLabel;
}

@property (nonatomic, retain) IBOutlet UILabel* gardenNumberLabel;
@property (nonatomic, retain) IBOutlet UILabel* gardenNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* streetLabel;
@property (nonatomic, retain) IBOutlet UILabel* cityLabel;
@property (nonatomic, retain) IBOutlet UILabel* plantSaleLabel;
@property (nonatomic, retain) IBOutlet UILabel* designerLabel;
@property (nonatomic, retain) IBOutlet UILabel* directionsLabel;
@property (nonatomic, retain) IBOutlet UILabel* gardenInstallerLabel;
@property (nonatomic, retain) IBOutlet UILabel* otherLabel;
@property (nonatomic, retain) IBOutlet UILabel* showcaseLabel;
@property (nonatomic, retain) IBOutlet UILabel* sqftLabel;
@property (nonatomic, retain) IBOutlet UILabel* wildlifeLabel;
@property (nonatomic, retain) IBOutlet UILabel* yearInstalledLabel;

- (void)setGardenInfo:(GardenInfo *)info;

@end
