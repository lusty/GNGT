#import "_Garden.h"

@interface Garden : _Garden {
	NSDictionary *_keyedItems;
}

@property (nonatomic, readonly) NSString *subtitle;

- (NSString*)itemForKey:(NSString*)key;
- (void)updateBeforeSave;

@end
