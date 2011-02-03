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
- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightOfValueText:(NSString *)valueText;
@end

@implementation GardenDescriptionViewController

@dynamic info;
@synthesize labels, values;

//=========================================================== 
//  info 
//=========================================================== 
- (GardenInfo *)info
{
    return [[info retain] autorelease]; 
}

- (void)setInfo:(GardenInfo *)anInfo
{
    if (info != anInfo) {
        [info release];
        info = [anInfo retain];
		
		BOOL authorized = YES;
		
		
		// Build the data used by the display table
		NSMutableArray *labelArray = [NSMutableArray arrayWithCapacity:10];
		NSMutableArray *valuesArray = [NSMutableArray arrayWithCapacity:10];
		GardenDescription *description = info.gardenDescription;

		[labelArray addObject:@"Name"];
		[valuesArray addObject:info.gardenName];
		[labelArray addObject:@"#"];
		[valuesArray addObject:[info.gardenNumber stringValue]];
		if (authorized && info.street) {
			[labelArray addObject:@"Address"];
			[valuesArray addObject:info.street];
		}
		[labelArray addObject:@"City"];
		[valuesArray addObject:info.city];
		if (authorized && description.directions) {
			[labelArray addObject:@"Directions"];
			[valuesArray addObject:description.directions];
		}
		
		// Description items, may be a secondary table
		if (description.designer) {
			[labelArray addObject:@"Designer"];
			[valuesArray addObject:description.designer];
		}
		if (description.gardenInstaller) {
			[labelArray addObject:@"Installer"];
			[valuesArray addObject:description.gardenInstaller];
		}
		if (description.sqft) {
			[labelArray addObject:@"Size"];
			[valuesArray addObject:[NSString stringWithFormat:@"%i sq. ft.", [description.sqft intValue]]];
		}
		if (description.yearInstalled) {
			[labelArray addObject:@"Installed in"];
			[valuesArray addObject:[description.yearInstalled stringValue]];
		}
		if (description.showcase) {
			[labelArray addObject:@"Showcase"];
			[valuesArray addObject:description.showcase];
		}
		if (description.other) {
			[labelArray addObject:@"Other"];
			[valuesArray addObject:description.other];
		}
		self.labels = labelArray;
		self.values = valuesArray;
		
		[((UITableView *)self.view) reloadData];
    }
}


#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	// TODO add a view header as well
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.labels == NULL ? 0 : [self.labels count];
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
	
	// Create a label for the time zone name.
	rect = CGRectMake(DETAIL_LEFT_COLUMN_OFFSET, DETAIL_ROW_TOP, DETAIL_LEFT_COLUMN_WIDTH, DETAIL_LABEL_HEIGHT);
	label = [[UILabel alloc] initWithFrame:rect];
	label.tag = NAME_TAG;
	label.font = [UIFont systemFontOfSize:DETAIL_MAIN_FONT_SIZE];
	label.textAlignment = UITextAlignmentRight;
	label.adjustsFontSizeToFitWidth = NO; // TODO wrap this too
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


// Customize the appearance of table view cells.
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
	label.text = [self.labels objectAtIndex:[indexPath row]];
	
	// Set the value.
	label = (UILabel *)[cell viewWithTag:TIME_TAG];
	NSString *valueText = [self.values objectAtIndex:[indexPath row]];
	CGFloat labelHeight = [self heightOfValueText:valueText];
	label.frame = CGRectMake(DETAIL_MIDDLE_COLUMN_OFFSET, DETAIL_ROW_TOP, DETAIL_MIDDLE_COLUMN_WIDTH, labelHeight);
	label.text = valueText;
	label.numberOfLines = 0;
//	[label sizeToFit];
}    

- (CGFloat)heightOfValueText:(NSString *)valueText 
{
	CGSize maxLabelSize = CGSizeMake(DETAIL_MIDDLE_COLUMN_WIDTH, 9999.0f);
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
	NSString *valueText = [self.values objectAtIndex:[indexPath row]];
	return [self heightOfValueText:valueText] + 2.0f * DETAIL_ROW_TOP;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
}


- (void)dealloc {
	[info release];
	info = nil;
	[labels release];
	labels = nil;
	[values release];
	values = nil;
    [super dealloc];
}


@end

