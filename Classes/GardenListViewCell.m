//
//  GardenListViewCell.m
//  GNGT
//
//  Created by Richard Clark on 1/20/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import "GardenListViewCell.h"
#import "GardenInfo.h"

@implementation GardenListViewCell

@synthesize gardenNameLabel, gardenCityLabel, plantSaleLabel, talkLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

- (void) useInfo:(GardenInfo *)info {
    self.gardenNameLabel.text  = info.gardenName;
    self.gardenCityLabel.text = info.city;
	self.plantSaleLabel.hidden = info.plantSale == nil || info.plantSale.length == 0;
	// TODO add label for talks
}

- (void)dealloc {
    [super dealloc];
}


@end
