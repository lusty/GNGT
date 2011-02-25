//
//  InfoItem.h
//  GNGT
//
//  Created by Richard Clark on 2/24/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Garden;

@interface InfoItem :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * itemValue;
@property (nonatomic, retain) NSString * valueType;
@property (nonatomic, retain) NSString * itemKey;
@property (nonatomic, retain) Garden * garden;

@end



