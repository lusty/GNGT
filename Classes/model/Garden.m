#import "Garden.h"
#import "InfoItem.h"

@implementation Garden

@dynamic subtitle;

- (NSString*)subtitle
{
	return @""; // TODO implement
}

- (NSString*)itemForKey:(NSString*)key
{
	if (_keyedItems == NULL) {
		_keyedItems = [NSMutableDictionary dictionaryWithCapacity:self.primitiveInfo.count];
		for (InfoItem *item in self.primitiveInfo) {
			[_keyedItems setValue:item.itemValue forKey:item.itemKey];
		}
	}
	NSString *result = [_keyedItems objectForKey:key];
	return result;
}

/**
 * Called by the importer to copy any date from the children to here before
 * writing this to the database.
 */
- (void)updateBeforeSave
{
	BOOL hgt = ([self itemForKey:@"gardenTalk"] != nil);
	BOOL hps = ([self itemForKey:@"plantSale"] != nil);
	[self setHasGardenTalkValue:hgt];
	[self setHasPlantSaleValue:hps];
}

-(void) dealloc
{
	[_keyedItems release];
    _keyedItems = nil;
	[super dealloc];
}

@end
