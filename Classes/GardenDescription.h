//
//  GardenDescription.h
//  GNGT
//
//  Created by DIANA K STANLEY on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class GardenInfo;

@interface GardenDescription :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * gardenInstaller;
@property (nonatomic, retain) NSString * showcase;
@property (nonatomic, retain) NSNumber * yearInstalled;
@property (nonatomic, retain) NSString * other;
@property (nonatomic, retain) NSNumber * sqft;
@property (nonatomic, retain) NSString * wildlife;
@property (nonatomic, retain) NSString * designer;
@property (nonatomic, retain) NSString * directions;
@property (nonatomic, retain) GardenInfo * info;

@end



