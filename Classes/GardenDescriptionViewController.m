//
//  GardenDescriptionViewController.m
//  GNGT
//
//  Created by Richard Clark on 2/1/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import "GardenDescriptionViewController.h"
#import "Garden.h"
#import "InfoItem.h"
#import "GardenLocation.h"
#import "StarControl.h"

@interface GardenDescriptionViewController (Private)
- (void)addLabel:(NSString *)labelText andText:(NSString *)valueText;
- (void)addLabel:(NSString *)labelText andNumber:(NSNumber *)value;
- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightOfText:(NSString *)valueText forWidth:(CGFloat)maxWidth;
@end

@implementation GardenDescriptionViewController

@dynamic garden;
@synthesize labels, values;
@synthesize headerView, starControl, nameLabel, numberLabel;

- (Garden *)garden
{
    return [[garden retain] autorelease]; 
}

- (void)setGarden:(Garden *)anInfo
{
    if (garden != anInfo) {
        [garden release];
        garden = [anInfo retain];
    }
}

- (void)addLabel:(NSString *)labelText forKey:(NSString *)key 
{
	NSString *valueText = [self.garden itemForKey:key];
	[self addLabel:labelText andText:valueText];
}

- (void)addLabel:(NSString *)labelText andText:(NSString *)valueText 
{
//	assert labelText && labelText.length > 0;
	if (valueText && valueText.length > 0) {
		NSString *cleanedValue = [valueText stringByReplacingOccurrencesOfString:@"\\n" withString:@"\r"];
		[self.labels addObject:labelText];
		[self.values addObject:cleanedValue];
	}
}

- (void)addLabel:(NSString *)labelText andNumber:(NSNumber *)value 
{
	if (value) [self addLabel:labelText andText:[value stringValue]];
}


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad 
{
	self.labels = [NSMutableArray arrayWithCapacity:10];
	self.values = [NSMutableArray arrayWithCapacity:10];
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	BOOL authorized = YES; // TODO have the application set this from outside
	
	// Build the data used by the display table
	[self.labels removeAllObjects];
	[self.values removeAllObjects];


	[self addLabel:@"Garden talk" forKey:@"Plant sale"];
	
	if (authorized && garden.location && garden.location.streetAddress && garden.location.streetAddress.length > 0) {
		[self addLabel:@"Address" andText:[NSString stringWithFormat:@"%@, %@", garden.location.streetAddress, garden.city]];
	} else {
		[self addLabel:@"City" andText:garden.city];
	}
	
	// Description items, may be a secondary table
	[self addLabel:@"Designer" forKey:@"designer"]; // TODO add disclosure for designer if needed
	[self addLabel:@"Installer" forKey:@"installer"];
	if ([garden itemForKey:@"sqft"])
		[self addLabel:@"Size" andText:[NSString stringWithFormat:@"%@ sq. ft.", [garden itemForKey:@"sqft"]]];
	[self addLabel:@"Installed in" forKey:@"yearInstalled"];
	[self addLabel:@"Showcase feature" forKey:@"showcase"];
	[self addLabel:@"Gardening for wildlife" forKey:@"wildlife"];
	[self addLabel:@"Other garden attractions" forKey:@"other"];

	UITableView *tview = (UITableView *)self.view;

	// Set up the view header
	self.nameLabel.text = garden.name;
	self.numberLabel.text = [garden itemForKey:@"gardenNumber"];
	starControl.on = [garden.isFavorite boolValue];
	[starControl addTarget:self action:@selector(starControlChanged:) forControlEvents:UIControlEventTouchUpInside];
	
	[tview setTableHeaderView:headerView];
	[tview scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO]; // Scroll to the top
	
	[tview reloadData];
}

- (void)starControlChanged:(id)control
{
	BOOL checked= [control on];
	self.garden.isFavorite = [NSNumber numberWithBool:checked];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	[starControl removeTarget:self action:@selector(starControlChanged:)  forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return labels == NULL ? 0 : [labels count];
}

#pragma mark -
#pragma mark Configuring table view cells

enum {
	NAME_TAG = 1,
	TIME_TAG
};

const int DETAIL_ROW_HEIGHT = 60;

const float DETAIL_ROW_TOP = 8.0;
const float DETAIL_LEFT_COLUMN_OFFSET = 10.0;
const float DETAIL_LEFT_COLUMN_WIDTH =  70.0;
const float DETAIL_LABEL_HEIGHT = 26.0;

const float DETAIL_MIDDLE_COLUMN_OFFSET = 90.0;
const float DETAIL_MIDDLE_COLUMN_WIDTH = 170.0;

const float DETAIL_MAIN_FONT_SIZE = 12.0;

- (UITableViewCell *)tableViewCellWithReuseIdentifier:(NSString *)identifier {
	
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
	UILabel *label;
	CGRect rect;
	
	// Create a label value label.
	rect = CGRectMake(DETAIL_LEFT_COLUMN_OFFSET, DETAIL_ROW_TOP, DETAIL_LEFT_COLUMN_WIDTH, DETAIL_LABEL_HEIGHT);
	label = [[UILabel alloc] initWithFrame:rect];
	label.tag = NAME_TAG;
	label.font = [UIFont systemFontOfSize:DETAIL_MAIN_FONT_SIZE];
	label.textAlignment = UITextAlignmentRight;
	label.lineBreakMode = UILineBreakModeWordWrap;
	label.adjustsFontSizeToFitWidth = NO;
	label.textColor = [UIColor blueColor];
	[cell.contentView addSubview:label];
	label.highlightedTextColor = [UIColor whiteColor];
	[label release];
	
	// Create a label for the value.
	rect = CGRectMake(DETAIL_MIDDLE_COLUMN_OFFSET, DETAIL_ROW_TOP, DETAIL_MIDDLE_COLUMN_WIDTH, DETAIL_LABEL_HEIGHT);
	label = [[UILabel alloc] initWithFrame:rect];
	label.tag = TIME_TAG;
	label.font = [UIFont systemFontOfSize:DETAIL_MAIN_FONT_SIZE];
	label.textAlignment = UITextAlignmentLeft;
	label.lineBreakMode = UILineBreakModeWordWrap;
	[cell.contentView addSubview:label];
	label.highlightedTextColor = [UIColor whiteColor];
	[label release];
		
	return cell;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [self tableViewCellWithReuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    [self configureCell:cell forIndexPath:indexPath]; 
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    	
	UILabel *label;
	
	// Set the label.
	label = (UILabel *)[cell viewWithTag:NAME_TAG];
	NSString *labelText = [labels objectAtIndex:[indexPath row]];
	CGFloat labelHeight = [self heightOfText:labelText forWidth:DETAIL_LEFT_COLUMN_WIDTH];
	label.text = labelText;
	label.frame = CGRectMake(DETAIL_LEFT_COLUMN_OFFSET, DETAIL_ROW_TOP, DETAIL_LEFT_COLUMN_WIDTH, labelHeight);
	label.numberOfLines = 0;
	
	// Set the value.
	label = (UILabel *)[cell viewWithTag:TIME_TAG];
	NSString *valueText = [values objectAtIndex:[indexPath row]];
	labelHeight = [self heightOfText:valueText forWidth:DETAIL_MIDDLE_COLUMN_WIDTH];
	label.frame = CGRectMake(DETAIL_MIDDLE_COLUMN_OFFSET, DETAIL_ROW_TOP, DETAIL_MIDDLE_COLUMN_WIDTH, labelHeight);
	label.text = valueText;
	label.numberOfLines = 0;
//	[label sizeToFit];
}    

- (CGFloat)heightOfText:(NSString *)valueText  forWidth:(CGFloat)maxWidth
{
	CGSize maxLabelSize = CGSizeMake(maxWidth, 9999.0f);
	CGSize textSize = [valueText sizeWithFont:[UIFont systemFontOfSize:DETAIL_MAIN_FONT_SIZE] 
							constrainedToSize:maxLabelSize 
								lineBreakMode:UILineBreakModeWordWrap];
	return textSize.height + DETAIL_MAIN_FONT_SIZE;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	/*
	 To conform to the Human Interface Guidelines, selections should not be persistent --
	 deselect the row after it has been selected.
	 */
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	// If this is the Address entry, show it on the map
	NSUInteger row = [indexPath row];
	NSString *chosenLabel = [labels objectAtIndex:row];
	if ([chosenLabel isEqualToString:@"Address"]) {
		NSString *searchQuery = [[values objectAtIndex:row] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
		NSString* urlString = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", searchQuery];
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {  
	NSString *labelText = [labels objectAtIndex:[indexPath row]];
	CGFloat labelHeight = [self heightOfText:labelText forWidth:DETAIL_LEFT_COLUMN_WIDTH];
	NSString *valueText = [values objectAtIndex:[indexPath row]];
	CGFloat valueHeight = [self heightOfText:valueText forWidth:DETAIL_MIDDLE_COLUMN_WIDTH];
	return  (valueHeight > labelHeight ? valueHeight : labelHeight) + 2.0f * DETAIL_ROW_TOP;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	[labels release];
	labels = nil;
	[values release];
	values = nil;
}

- (void)dealloc {
	[garden release];
	garden = nil;
    [super dealloc];
}


@end

