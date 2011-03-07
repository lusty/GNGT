#import "Garden.h"
#import "InfoItem.h"

@implementation Garden

- (BOOL)hasPlantSale
{
	return NO; // TODO implement
}

- (BOOL)hasGardenTalk
{
	return NO; // TODO implement
}

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
	return [_keyedItems objectForKey:key];
}

-(void) dealloc
{
	[_keyedItems release];
    _keyedItems = nil;
	[super dealloc];
}

@end
