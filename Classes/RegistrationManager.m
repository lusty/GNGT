//
//  RegistrationManager.m
//  GNGT
//
//  Created by Richard Clark on 3/12/11.
//  Copyright 2011 Next Question Consulting. All rights reserved.
//

#import "GNGT.h"
#import "RegistrationManager.h"
#import "SynthesizeSingleton.h"

#import "GTMHTTPFetcher.h"
#import "UserInfo.h"

@implementation RegistrationManager
SYNTHESIZE_SINGLETON_FOR_CLASS(RegistrationManager)

/**
 * Look up the user's registration status
 * @param email user email
 * @param callback called with the registration status (REGISTERED, NOT-REGESISTERED, or nil for a network error)
 */
- (void) updateRegistrationForUser:(UserInfo*)user withEmail:(NSString*)email andCall:(void (^)(UserInfo *userInfo, NSError *error))callback
{
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@&email=%@", BASE_URL, email]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        GTMHTTPFetcher* myFetcher = [GTMHTTPFetcher fetcherWithRequest:request];
        [myFetcher beginFetchWithCompletionHandler:^(NSData* data, NSError* error){
            if (!error) {
                NSString *returnedValue = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding: NSUTF8StringEncoding];
                user.email = email;
                user.isRegisteredForTourValue = [returnedValue isEqualToString:REGISTERED];
            }
            callback(user, error);
        }];
}

@end
