#import "_Garden.h"

@interface Garden : _Garden {
}

- (NSString*)itemForKey:(NSString*)key;
- (void)updateBeforeSave;

@end
