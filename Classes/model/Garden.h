#import "_Garden.h"

@interface Garden : _Garden {
	NSDictionary *_keyedItems;
}

- (NSString*)itemForKey:(NSString*)key;
- (void)updateBeforeSave;

@end
