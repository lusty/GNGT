//
//  GardenInfoViewCell.h
//  GNGT
//
//  Created by Richard Clark on 1/26/11.
//  Copyright 2010 NextQuestion Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

enum cellTags {
	CHECKBOX_TAG = 1,
	NAME_TAG,
	CITY_TAG,
	NOTES_TAG
};

@class Garden;
@class GardensListViewController;

@interface GardenInfoViewCell : UITableViewCell {
	Garden *info;
}

@property (nonatomic, retain) Garden *info;

+ (NSString *) reuseIdentifierWithNotes:(BOOL)hasNotes andCity:(BOOL)hasCity;
+ (CGFloat) heightWithNotes:(BOOL)hasNotes andCity:(BOOL)hasCity;
+ (CGFloat) heightWithReuseIdentifier:(NSString *)identifier;

- (id)initWithReuseIdentifier:(NSString *)identifier hasNotes:(BOOL)hasNotes hasCity:(BOOL)hasCity;

@end
