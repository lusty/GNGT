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
@class UserInfo;

@interface TourInfoController : UIViewController<UITextViewDelegate> {
    
    UIActivityIndicatorView *emailActivityIndicator;
    
    // Info page
	UIButton *updateButton;

    // Registration page
    UITextField *emailField;
    
    // Sponsor page
    UIButton *updateButton2;

@private
    CGFloat lastScrollPosition;
    BOOL isCheckingRegistration;
    BOOL shouldHideRegistrationView;
    RegistrationManager *registrationManager;
    UpdateManager *updateManager;
    DatabaseAccess *databaseAccess;
    UINavigationController*  navController;
}

@property (nonatomic, retain) IBOutlet UIView *upperView;
@property (nonatomic, retain) IBOutlet UIView *registrationView;
@property (nonatomic, retain) IBOutlet UIView *lowerView;

@property (nonatomic, retain) IBOutlet UIButton *updateButton;
@property (nonatomic, retain) IBOutlet UITextField *emailField;

@property (nonatomic, retain) UserInfo *userInfo;

//- (IBAction)checkEmailAddress;
- (IBAction)downloadUpdate;
- (void)setBadgeText:(NSString*)value;

@end
