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
#import "GardenInfo.h"

const CGFloat STAR_CONTROL_SIZE = 44.0f;

const CGFloat ROW_HEIGHT = 48.0f;
const CGFloat ROW_WIDTH = 320.0f;

const CGFloat LEFT_COLUMN_OFFSET = 14.0f;
const CGFloat LEFT_COLUMN_WIDTH = 35.0f;

const CGFloat RIGHT_COLUMN_OFFSET = 54.0f;
const CGFloat RIGHT_COLUMN_WIDTH = 246.0f;

const CGFloat NAME_FONT_SIZE = 18.0f;
const CGFloat NAME_CENTERED = 9.0f;
const CGFloat NAME_AT_TOP = 1.0f;
const CGFloat NAME_HEIGHT = 26.0f;

const CGFloat NOTE_FONT_SIZE = 12.0f;
const CGFloat NOTE_TOP =  24.0f;
const CGFloat NOTE_HEIGHT = 19.0f;

const int CHECKBOX_TAG = 1;
const int NAME_TAG = 2;
const int NOTES_TAG = 3;
// TODO add plant sale, talk

@implementation GardenInfoViewCell

@synthesize info;

- (id)initWithReuseIdentifier:(NSString *)identifier hasNotes:(BOOL)hasNotes
{
	self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	self.info = NULL;

	CGRect rect = CGRectMake(LEFT_COLUMN_OFFSET, ((ROW_HEIGHT - STAR_CONTROL_SIZE) / 2.0f) - 3.0f, STAR_CONTROL_SIZE, STAR_CONTROL_SIZE);
	StarControl *checkbox = [[StarControl alloc] initWithFrame: rect];
	checkbox.tag = CHECKBOX_TAG;
	[checkbox setBackgroundColor: [UIColor whiteColor]];
	[self addSubview:checkbox];
	[checkbox release];
	
	UILabel *nameLabel;
	rect = CGRectMake(RIGHT_COLUMN_OFFSET, (hasNotes ? NAME_AT_TOP : NAME_CENTERED), RIGHT_COLUMN_WIDTH, NAME_HEIGHT);
	nameLabel = [[UILabel alloc] initWithFrame:rect];
	nameLabel.tag = NAME_TAG;
	nameLabel.font = [UIFont boldSystemFontOfSize:NAME_FONT_SIZE];
	nameLabel.adjustsFontSizeToFitWidth = NO;
	[self addSubview:nameLabel];
	nameLabel.highlightedTextColor = [UIColor whiteColor];
	[nameLabel release];

	if (hasNotes) {
		UILabel *noteLabel;
		rect = CGRectMake(RIGHT_COLUMN_OFFSET, NOTE_TOP, RIGHT_COLUMN_WIDTH, NOTE_HEIGHT);
		noteLabel = [[UILabel alloc] initWithFrame:rect];
		noteLabel.tag = NOTES_TAG;
		noteLabel.font = [UIFont systemFontOfSize:NOTE_FONT_SIZE];
		noteLabel.textColor = [UIColor colorWithWhite:0.498 alpha:1.000];
		noteLabel.adjustsFontSizeToFitWidth = NO;
		noteLabel.hidden = NO;
		[self addSubview:noteLabel];
		noteLabel.highlightedTextColor = [UIColor whiteColor];
		[noteLabel release];
	}
	
	self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return self;
}

- (void)setInfo:(GardenInfo *)newInfo {
	if (self.info == newInfo) return;
	[info release];
	info = [newInfo retain];

	// Configure contents...
	StarControl *checkbox = (StarControl *)[self viewWithTag:CHECKBOX_TAG];
	checkbox.on = info.isFavorite.boolValue;
	[checkbox addTarget:self action:@selector(starControlChanged:) forControlEvents:UIControlEventTouchUpInside];
	
	UILabel *nameLabel= (UILabel *)[self viewWithTag:NAME_TAG];
	nameLabel.text = info.gardenName;

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
