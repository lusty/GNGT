//
//  GardenInfo.h
//  GNGT
//
//  Created by DIANA K STANLEY on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class GardenDescription;

@interface GardenInfo :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * gardenNumber;
@property (nonatomic, retain) NSString * gardenName;
@property (nonatomic, retain) NSString * street;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * plantSale;
@property (nonatomic, retain) GardenDescription * gardenDescription;

@end



