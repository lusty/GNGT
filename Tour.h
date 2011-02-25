//
//  Tour.h
//  GNGT
//
//  Created by Richard Clark on 2/24/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Garden;

@interface Tour :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * tourName;
@property (nonatomic, retain) NSDate * tourDate;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSSet* gardens;

@end


@interface Tour (CoreDataGeneratedAccessors)
- (void)addGardensObject:(Garden *)value;
- (void)removeGardensObject:(Garden *)value;
- (void)addGardens:(NSSet *)value;
- (void)removeGardens:(NSSet *)value;

@end

