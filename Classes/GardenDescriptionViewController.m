//
//  GardenDescriptionViewController.m
//  GNGT
//
//  Created by Richard Clark on 2/1/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import "GardenDescriptionViewController.h"
#import "GardenInfo.h"
#import "GardenDescription.h"

@interface GardenDescriptionViewController (Private)
- (void)addLabel:(NSString *)labelText andText:(NSString *)valueText;
- (void)addLabel:(NSString *)labelText andNumber:(NSNumber *)value;
- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightOfText:(NSString *)valueText forWidth:(CGFloat)maxWidth;
@end

@implementation GardenDescriptionViewController

@dynamic info;
@synthesize labels, values;

- (GardenInfo *)info
{
    return [[info retain] autorelease]; 
}

- (void)setInfo:(GardenInfo *)anInfo
{
    if (info != anInfo) {
        [info release];
        info = [anInfo retain];
    }
}


- (void)addLabel:(NSString *)labelText andText:(NSString *)valueText 
{
//	assert labelText && labelText.length > 0;
	if (valueText && valueText.length > 0) {
		[self.labels addObject:labelText];
		[self.values addObject:valueText];
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
	GardenDescription *description = info.gardenDescription;
	
	[self addLabel:@"Garden name" andText:info.gardenName];
	[self addLabel:@"Garden number" andNumber:info.gardenNumber];
	[self addLabel:@"Plant sale" andText:info.plantSale];
	[self addLabel:@"Garden talk" andText:info.gardenTalk];
	
	if (authorized && info.street && info.street.length > 0) {
		[self addLabel:@"Address" andText:[NSString stringWithFormat:@"%@, %@", info.street, info.city]];
	} else {
		[self addLabel:@"City" andText:info.city];
	}
	if (authorized)
		[self addLabel:@"Directions" andText:description.directions];
	
	// Description items, may be a secondary table
	[self addLabel:@"Designer" andText:description.designer]; // TODO add disclosure for designer if needed
	[self addLabel:@"Installer" andText:description.gardenInstaller];
	if (description.sqft)
		[self addLabel:@"Size" andText:[NSString stringWithFormat:@"%i sq. ft.", [description.sqft intValue]]];
	[self addLabel:@"Installed in" andNumber:description.yearInstalled];
	[self addLabel:@"Showcase feature" andText:description.showcase];
	[self addLabel:@"Gardening for wildlife" andText:description.wildlife];
	[self addLabel:@"Other garden attractions" andText:description.other];
	
	// TODO setup the view header as well
	[((UITableView *)self.view) scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
	
	[((UITableView *)self.view) reloadData];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/

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
	[info release];
	info = nil;
    [super dealloc];
}


@end

