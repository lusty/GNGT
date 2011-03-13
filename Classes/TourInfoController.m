//
//  TourInfoController.m
//  GNGT
//
//  Created by Richard Clark on 2/4/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import "TourInfoController.h"
#import "DatabaseAccess.h"
#import "UpdateManager.h"
#import "RegistrationManager.h"
#import "UserInfo.h"

@interface TourInfoController(Private)
- (void)addPage:(UIView*)page;
- (IBAction)viewSelectorChanged:(id)sender;
- (void)updateDisplay;
@end

@implementation TourInfoController
@synthesize emailField;
@synthesize registrationCompletedPrompt;
@synthesize registrationPendingPrompt;

@synthesize updateButton, showRegistrationPageButton;
@synthesize openWebButton, updateButton2;


- (void)viewDidLoad
{
    registrationManager = [RegistrationManager sharedRegistrationManager];
    updateManager = [UpdateManager sharedUpdateManager];
    databaseAccess = [DatabaseAccess sharedDatabaseAccess];
     
    UIScrollView *sv = (UIScrollView*)self.view;
    sv.contentSize = CGSizeMake(320.0, 545.0); // TODO calculate from subview sizes
    
    emailActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    emailActivityIndicator.hidesWhenStopped = YES;
    CGFloat boxSize = emailField.bounds.size.height - 4;
    [emailActivityIndicator setBounds:CGRectMake(0, 0, boxSize, boxSize)];
    emailField.rightView = emailActivityIndicator;
    emailField.rightViewMode = UITextFieldViewModeUnlessEditing;

}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

    registrationCompletedPrompt.frame = registrationPendingPrompt.frame;
    updateButton2.hidden = YES;
    UserInfo *userInfo = databaseAccess.userInfo;
    NSString *email = userInfo.email;
    emailField.text = email;

    [self updateDisplay];
    
}

- (void)updateDisplay
{
    UserInfo *userInfo = databaseAccess.userInfo;
    NSString *email = userInfo.email;
    BOOL hasEmail = (email && email.length > 0);
    BOOL registered = userInfo.isRegisteredForTourValue;
    BOOL wantsRegistration = !registered && hasEmail;
    
    showRegistrationPageButton.hidden = registered;
    registrationButton.hidden = registered;
    openWebButton.hidden = !wantsRegistration;
    registrationCompletedPrompt.hidden = !registered;
    registrationPendingPrompt.hidden = !wantsRegistration;
    
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [emailActivityIndicator release];
    emailActivityIndicator = nil;
    
    // TODO release the rest of the IB outlets
    
    [super viewDidUnload];
}


- (void)dealloc {
    [emailField release];
    [super dealloc];
}


#pragma mark -
#pragma mark UI operations

- (void)setBadgeText:(NSString*)value;
{
	// TODO find the tab bar item as a child
//	tabBarItem.badgeValue = value;
}

#pragma mark -
#pragma mark UITextFieldDelegate for email

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedKeyboardHiddenNotification:) name:UIKeyboardDidHideNotification object:nil];
    [textField resignFirstResponder];
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    // do this to defer action until after the keyboard hides (the interaction looks better that way)
}

- (void)receivedKeyboardHiddenNotification:(NSNotification*)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [self checkEmailAddress];
    
}
#pragma mark -
#pragma mark User-selectable commands


- (IBAction)checkEmailAddress
{
    NSString *email = emailField.text;
    UserInfo *userInfo = databaseAccess.userInfo;
    if (email && email.length > 0) {
        [emailActivityIndicator startAnimating];
        [registrationManager updateRegistrationForUser:userInfo withEmail:email andCall:^(UserInfo *userInfo, NSError *error) {
            [emailActivityIndicator stopAnimating];
            if (error) { 
                // network error
                UIAlertView *someError = [[[UIAlertView alloc] initWithTitle: @"Network error" message: @"Could not communicate with the server" delegate: nil cancelButtonTitle: @"Ok" otherButtonTitles: nil] autorelease];
                [someError show];
            } else {
                NSError *saveError = nil;
                [databaseAccess.managedObjectContext save:&saveError];            
            }
            [self updateDisplay];
        }];
    }
}

- (IBAction)downloadUpdate
{
	// TODO implement
}

- (IBAction)registerForTour
{
	// TODO implement
}



@end
