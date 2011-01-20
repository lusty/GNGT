//
//  GardenDescription.h
//  GNGT
//
//  Created by DIANA K STANLEY on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GardenDescriptionView : NSObject {
	int _uniqueId;
	int _gardenNumber;
	NSString *_gardenName;
	NSString *_street;
	NSString *_city;
	NSString *_plantSale;
	NSString *_designer;
	NSString *_directions;
	NSString *_gardenInstaller;
	NSString *_other;
	NSString *_showcase;
	int _sqft;
	NSString *_wildlife;
	int _yearInstalled;
}

@property (nonatomic, assign) int uniqueId;
@property (nonatomic, assign) int gardenNumber;
@property (nonatomic, copy) NSString *gardenName;
@property (nonatomic, copy) NSString *street;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *plantSale;
@property (nonatomic, copy) NSString *designer;
@property (nonatomic, copy) NSString *directions;
@property (nonatomic, copy) NSString *gardenInstaller;
@property (nonatomic, copy) NSString *other;
@property (nonatomic, copy) NSString *showcase;
@property (nonatomic, assign) int sqft;
@property (nonatomic, copy) NSString *wildlife;
@property (nonatomic, assign) int yearInstalled;

- (id)initWithUniqueId:(int)uniqueId gardenNumber:(int)gardenNumber gardenName:(NSString *)gardenName 
				street:(NSString *)street city:(NSString *)city plantSale:(NSString *)plantSale
			  designer:(NSString *)designer directions:(NSString *)directions gardenInstaller:(NSString *)gardenInstaller
				 other:(NSString *)other showcase:(NSString *)showcase sqft:(int)sqft wildlife:(NSString *)wildlife
		 yearInstalled:(int)yearInstalled;

@end
