//
//  GardenListViewCell.m
//  GNGT
//
//  Created by Richard Clark on 1/20/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import "GardenListViewCell.h"


@implementation GardenListViewCell

@synthesize gardenNameLabel, gardenCityLabel;

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


- (void)dealloc {
    [super dealloc];
}


@end
