//
//  GardenInfoViewCell.m
//  GNGT
//
//  Created by Richard Clark on 1/26/11.
//  Copyright 2010 NextQuestion Consulting. All rights reserved.
//

#import "GardenInfoViewCell.h"
#import "GardensListViewController.h"
#import "StarControl.h"
#import "Garden.h"
#import "UIConstants.h"

const CGFloat STAR_CONTROL_SIZE = 42.0f;

const CGFloat ROW_HEIGHT = 48.0f;
const CGFloat ROW_HEIGHT_WITH_CITY = 68.0f;
const CGFloat ROW_WIDTH = 320.0f;

const CGFloat LEFT_COLUMN_OFFSET = 14.0f;
const CGFloat LEFT_COLUMN_WIDTH = 35.0f;

const CGFloat RIGHT_COLUMN_OFFSET = 54.0f;
const CGFloat RIGHT_COLUMN_WIDTH = 246.0f;

const CGFloat NAME_FONT_SIZE = 18.0f;
const CGFloat NAME_CENTERED = 12.0f;
const CGFloat NAME_AT_TOP = 6.0f;
const CGFloat NAME_HEIGHT = 20.0f;

const CGFloat CITY_FONT_SIZE = 14.0f;
const CGFloat CITY_TOP =  32.0f;
const CGFloat CITY_HEIGHT = 16.0f;

const CGFloat NOTE_FONT_SIZE = 12.0f;
const CGFloat NOTE_TOP =  24.0f;
const CGFloat NOTE_TOP_WITH_CITY =  44.0f;
const CGFloat NOTE_HEIGHT = 14.0f;

const CGFloat LABEL_SPACING = 2.0f;

@implementation GardenInfoViewCell

@synthesize info;

+ (NSString *) reuseIdentifierWithNotes:(BOOL)hasNotes andCity:(BOOL)hasCity
{
	return hasCity ? (hasNotes ? @"GardenListWithNotesAndCity" : @"GardenListWithCity") : (hasNotes ? @"GardenListWithNotes" : @"GardenList");
}

+ (CGFloat) heightWithNotes:(BOOL)hasNotes andCity:(BOOL)hasCity
{
	return hasCity ? ROW_HEIGHT_WITH_CITY : ROW_HEIGHT;
}

+ (CGFloat) heightWithReuseIdentifier:(NSString *)identifier
{
	return (identifier == @"GardenList" || identifier == @"GardenListWithNotes") ? ROW_HEIGHT : ROW_HEIGHT_WITH_CITY;
}

- (id)initWithReuseIdentifier:(NSString *)identifier hasNotes:(BOOL)hasNotes hasCity:(BOOL)hasCity
{
	self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	self.info = NULL;
	
	CGFloat rowHeight = hasCity ? ROW_HEIGHT_WITH_CITY : ROW_HEIGHT;
	CGFloat nameY = hasNotes ? NAME_AT_TOP : NAME_CENTERED;
//	CGFloat noteY = hasCity ? NOTE_TOP_WITH_CITY : NOTE_TOP;
	
	// TODO three sizes: [name only, name with notes], [name with city], [name with city and notes]
	
	UIConstants *constants = [UIConstants sharedUIConstants];

	CGRect rect = CGRectMake(LEFT_COLUMN_OFFSET, ((rowHeight - STAR_CONTROL_SIZE) / 2.0f)-2.0f, STAR_CONTROL_SIZE, STAR_CONTROL_SIZE);
	StarControl *checkbox = [[StarControl alloc] initWithFrame: rect];
	checkbox.tag = CHECKBOX_TAG;
	[checkbox setBackgroundColor: [UIColor whiteColor]];
	[self addSubview:checkbox];
	[checkbox release];
	
	UILabel *nameLabel;
	rect = CGRectMake(RIGHT_COLUMN_OFFSET, nameY, RIGHT_COLUMN_WIDTH, NAME_HEIGHT);
	nameLabel = [[UILabel alloc] initWithFrame:rect];
	nameLabel.tag = NAME_TAG;
	nameLabel.font = [UIFont boldSystemFontOfSize:NAME_FONT_SIZE];
	nameLabel.adjustsFontSizeToFitWidth = NO;
	[self addSubview:nameLabel];
	nameLabel.highlightedTextColor = [UIColor whiteColor];
	[nameLabel release];

	if (hasCity) {
		UILabel *cityLabel;
		CGFloat newTop = rect.origin.y + rect.size.height + LABEL_SPACING;
		rect = CGRectMake(RIGHT_COLUMN_OFFSET, newTop, RIGHT_COLUMN_WIDTH, CITY_HEIGHT);
		cityLabel = [[UILabel alloc] initWithFrame:rect];
		cityLabel.tag = CITY_TAG;
		cityLabel.font = [UIFont systemFontOfSize:CITY_FONT_SIZE];
		cityLabel.textColor = constants.darkGreen;
//		cityLabel.shadowColor = constants.lightGreen;
		cityLabel.adjustsFontSizeToFitWidth = NO;
		cityLabel.hidden = NO;
		[self addSubview:cityLabel];
		[cityLabel release];
	}
	
	if (hasNotes) {
		UILabel *cityLabel;
		CGFloat newTop = rect.origin.y + rect.size.height + LABEL_SPACING;
		rect = CGRectMake(RIGHT_COLUMN_OFFSET, newTop, RIGHT_COLUMN_WIDTH, NOTE_HEIGHT);
		cityLabel = [[UILabel alloc] initWithFrame:rect];
		cityLabel.tag = NOTES_TAG;
		cityLabel.font = [UIFont systemFontOfSize:NOTE_FONT_SIZE];
		cityLabel.textColor = constants.darkGreen;
		cityLabel.shadowColor = constants.lightGreen;
		cityLabel.adjustsFontSizeToFitWidth = NO;
		cityLabel.hidden = NO;
		[self addSubview:cityLabel];
		[cityLabel release];
	}
	
	self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return self;
}

- (void)setInfo:(Garden *)newInfo {
	if (self.info == newInfo) return;
	[info release];
	info = [newInfo retain];

	// Configure contents...
	StarControl *checkbox = (StarControl *)[self viewWithTag:CHECKBOX_TAG];
	checkbox.on = info.isFavorite.boolValue;
	[checkbox addTarget:self action:@selector(starControlChanged:) forControlEvents:UIControlEventTouchUpInside];
	
	UILabel *nameLabel= (UILabel *)[self viewWithTag:NAME_TAG];
	nameLabel.text = info.name;
	
	UILabel *cityLabel= (UILabel *)[self viewWithTag:CITY_TAG];
	if (cityLabel) cityLabel.text = info.city;
	
	// flag plant sales and talks, adjusting the name label if needed
	NSString *labelString = [info subtitle];	
	if (labelString) {
		UILabel *notesLabel = (UILabel *)[self viewWithTag:NOTES_TAG];
		notesLabel.text = labelString;
	}
}


- (void)dealloc 
{
	[info release];
	info = nil;
	[super dealloc];
}
	
#pragma mark Responding to control events
	
- (void)starControlChanged:(id)checkbox 
{
	BOOL checked= [checkbox on];
	self.info.isFavorite = [NSNumber numberWithBool:checked];
	[self setNeedsDisplay];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"GardenInfoChanged" object:info];
}


@end
