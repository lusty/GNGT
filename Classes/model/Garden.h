#import "_Garden.h"

@interface Garden : _Garden {
	NSDictionary *_keyedItems;
}

@property (nonatomic, readonly) BOOL hasPlantSale;
@property (nonatomic, readonly) BOOL hasGardenTalk;
@property (nonatomic, readonly) NSString *subtitle;

- (NSString*)itemForKey:(NSString*)key;

@end
