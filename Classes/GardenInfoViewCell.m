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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		self.info = NULL;

		CGRect rect = CGRectMake(LEFT_COLUMN_OFFSET, ((ROW_HEIGHT - STAR_CONTROL_SIZE) / 2.0f) - 3.0f, STAR_CONTROL_SIZE, STAR_CONTROL_SIZE);
		StarControl *checkbox = [[StarControl alloc] initWithFrame: rect];
		checkbox.tag = CHECKBOX_TAG;
		[checkbox setBackgroundColor: [UIColor whiteColor]];
		[self addSubview:checkbox];
		[checkbox release];
		
		UILabel *nameLabel;
		rect = CGRectMake(RIGHT_COLUMN_OFFSET, NAME_CENTERED, RIGHT_COLUMN_WIDTH, NAME_HEIGHT);
		nameLabel = [[UILabel alloc] initWithFrame:rect];
		nameLabel.tag = NAME_TAG;
		nameLabel.font = [UIFont boldSystemFontOfSize:NAME_FONT_SIZE];
		nameLabel.adjustsFontSizeToFitWidth = NO;
		[self addSubview:nameLabel];
		nameLabel.highlightedTextColor = [UIColor whiteColor];
		[nameLabel release];

		UILabel *noteLabel;
		rect = CGRectMake(RIGHT_COLUMN_OFFSET, NOTE_TOP, RIGHT_COLUMN_WIDTH, NOTE_HEIGHT);
		noteLabel = [[UILabel alloc] initWithFrame:rect];
		noteLabel.tag = NOTES_TAG;
		noteLabel.font = [UIFont systemFontOfSize:NOTE_FONT_SIZE];
		noteLabel.textColor = [UIColor colorWithWhite:0.498 alpha:1.000];
		noteLabel.adjustsFontSizeToFitWidth = NO;
		noteLabel.hidden = YES;
		[self addSubview:noteLabel];
		noteLabel.highlightedTextColor = [UIColor whiteColor];
		[noteLabel release];
		
		self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	return self;
}

- (void)setInfo:(GardenInfo *)newInfo {
	if (self.info == newInfo) return;
	[info release];
	info = [newInfo retain];

	// Configure contents...
	StarControl *checkbox = (StarControl *)[self viewWithTag:CHECKBOX_TAG];
	checkbox.on = info.isFavorite.boolValue;
	[checkbox addTarget:self action:@selector(checkboxChanged:) forControlEvents:UIControlEventTouchUpInside];
	
	UILabel *nameLabel= (UILabel *)[self viewWithTag:NAME_TAG];
	nameLabel.text = info.gardenName;

	// flag plant sales and talks, adjusting the name label if needed
	NSString *labelString = NULL;
	if ([info hasPlantSale]) {
		labelString = @"plant sale";
	}
	
	if ([info hasGardenTalk]) {
		if (labelString) {
			labelString = [labelString stringByAppendingString:@", garden talk"];
		} else {
			labelString = @"garden talk";
		}
	}
	
	if (labelString) {
		nameLabel.frame = CGRectOffset(nameLabel.frame, 0, -6.0f);
		UILabel *notesLabel = (UILabel *)[self viewWithTag:NOTES_TAG];
		notesLabel.text = labelString;
		notesLabel.hidden = NO;
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated 
{
	[super setSelected:selected animated:animated];
	// Configure the view for the selected state
}

- (void) setCheckboxHidden:(BOOL)hidden animated:(BOOL)animate
{
	StarControl *checkbox = (StarControl *)[self viewWithTag:CHECKBOX_TAG];
	[checkbox setHidden:hidden];
}


- (void)dealloc 
{
	[info release];
	[super dealloc];
}
	
#pragma mark Responding to control events
	
- (void)checkboxChanged:(id)checkbox 
{
	BOOL checked= [checkbox on];
	NSLog(@"Checkbox \"%@\" state changed to %d", info.gardenName, checked);
	self.info.isFavorite = [NSNumber numberWithBool:checked];
	[self setNeedsDisplay];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"GardenInfoChanged" object:info];
}


@end
