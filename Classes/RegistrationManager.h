//
//  RegistrationManager.h
//  GNGT
//
//  Created by Richard Clark on 3/12/11.
//  Copyright 2011 Next Question Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserInfo;

@interface RegistrationManager : NSObject {
    
}


+ (RegistrationManager*) sharedRegistrationManager;

- (void) updateRegistrationForUser:(UserInfo*)user withEmail:(NSString*)email andCall:(void (^)(UserInfo *userInfo, NSError *error))callback;

#define REGISTERED @"REGISTERED"
#define NOT_REGISTERED @"NOT_REGISTERED"



@end
