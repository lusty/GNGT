#import "Garden.h"
#import "InfoItem.h"

@implementation Garden


- (NSString*)itemForKey:(NSString*)key
{
		for (InfoItem *item in self.primitiveInfo) {
            if ([key isEqualToString:item.itemKey]) 
                return item.itemValue;
		}
	return nil;
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

@end
