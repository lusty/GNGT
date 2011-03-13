//
//  TourInfoController.h
//  GNGT
//
//  Created by Richard Clark on 2/4/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegistrationManager;
@class UpdateManager;
@class DatabaseAccess;

@interface TourInfoController : UIViewController<UITextViewDelegate> {
    UIActivityIndicatorView *emailActivityIndicator;
    
    // Info page
	UIButton *updateButton;

    // Registration page
    UITextField *emailField;
    UIButton *registrationButton;
    IBOutlet UIButton *startRegistrationButton;
    
    // Sponsor page
    UIButton *updateButton2;
    UILabel *registrationCompletedPrompt;
    UILabel *registrationPendingPrompt;

@private
    RegistrationManager *registrationManager;
    UpdateManager *updateManager;
    DatabaseAccess *databaseAccess;
}

@property (nonatomic, retain) IBOutlet UIButton *updateButton;
@property (nonatomic, retain) IBOutlet UIButton *showRegistrationPageButton;

@property (nonatomic, retain) IBOutlet UITextField *emailField;
@property (nonatomic, retain) IBOutlet UIButton *openWebButton;
@property (nonatomic, retain) IBOutlet UIButton *updateButton2;

@property (nonatomic, retain) IBOutlet UILabel *registrationCompletedPrompt;
@property (nonatomic, retain) IBOutlet UILabel *registrationPendingPrompt;



- (IBAction)checkEmailAddress;
- (IBAction)downloadUpdate;
- (IBAction)registerForTour;

- (void)setBadgeText:(NSString*)value;

@end
