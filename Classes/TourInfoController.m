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
- (void)receivedKeyboardWillShowNotification:(NSNotification*)notification;
- (void)receivedKeyboardWillHideNotification:(NSNotification*)notification;
- (void)receivedKeyboardHiddenNotification:(NSNotification*)notification;
- (void)updateDisplay;
- (void)checkRegistrationForEmail:(NSString*)email;
- (void)openRegistrationPageWithEmail:(NSString*)email;
@end

@implementation TourInfoController
@synthesize upperView, lowerView;
@synthesize registrationView, emailField;
@synthesize updateButton;
@synthesize userInfo;

- (void)viewDidLoad
{
    registrationManager = [RegistrationManager sharedRegistrationManager];
    updateManager = [UpdateManager sharedUpdateManager];
    databaseAccess = [DatabaseAccess sharedDatabaseAccess];
    
    self.userInfo = databaseAccess.userInfo;
    isCheckingRegistration = NO;
    
    emailActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    emailActivityIndicator.hidesWhenStopped = YES;
    CGFloat boxSize = emailField.bounds.size.height - 4;
    [emailActivityIndicator setBounds:CGRectMake(0, 0, boxSize, boxSize)];
    emailField.rightView = emailActivityIndicator;
    emailField.rightViewMode = UITextFieldViewModeUnlessEditing;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedKeyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedKeyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedKeyboardHiddenNotification:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    updateButton2.hidden = YES;
//    NSString *email = userInfo.email;
//    emailField.text = email;

    [self updateDisplay];
	[super viewWillAppear:animated];    
}

- (void)updateDisplay
{
    BOOL registered = userInfo.isRegisteredForTourValue;
    
    UIScrollView *sv = (UIScrollView*)self.view;
    CGFloat w = self.view.bounds.size.width;
    CGFloat h = self.upperView.bounds.size.height;
    
    self.registrationView.hidden = registered;
    if (!registered) {
        h += 4.0 + self.registrationView.bounds.size.height;
    }
    
    self.lowerView.frame = CGRectOffset(self.lowerView.bounds, 0, h + 4.0);
    h += 4.0 + self.lowerView.bounds.size.height;
    sv.contentSize = CGSizeMake(w, h);
}

- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//}

- (void)viewDidUnload 
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil]; 
    
    self.userInfo = nil;
    
    [updateButton release];
    updateButton = nil;
    [emailActivityIndicator release];
    emailActivityIndicator = nil;
    [emailField release];
    emailField = nil;
    [upperView release];
    upperView = nil;    
    [lowerView release];
    lowerView = nil;    
    [registrationView release];
    registrationView = nil;    
    [super viewDidUnload];
}


- (void)dealloc {
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

- (void)receivedKeyboardWillShowNotification:(NSNotification*)notification
{
    // Scroll up so the registration area is visible above the keyboard
    UIScrollView *sv = (UIScrollView*)self.view;
    lastScrollPosition = sv.contentOffset.y;
    if (lastScrollPosition < 150.0) [sv setContentOffset:CGPointMake(0.0, 150.0) animated:YES];
}

- (void)receivedKeyboardWillHideNotification:(NSNotification*)notification
{
    UIScrollView *sv = (UIScrollView*)self.view;
    [sv setContentOffset:CGPointMake(0.0, lastScrollPosition) animated:YES];
}

- (void)receivedKeyboardHiddenNotification:(NSNotification*)notification
{
    NSString *email = emailField.text;
   if (isCheckingRegistration) return;
    isCheckingRegistration = YES;
    
    if (email == nil || email.length == 0) return;
    [emailActivityIndicator startAnimating];
    [registrationManager updateRegistrationForUser:userInfo withEmail:email andCall:^(UserInfo *user, NSError *error) {
        [emailActivityIndicator stopAnimating];
        if (error) { 
            // network error
            UIAlertView *someError = [[[UIAlertView alloc] initWithTitle: @"Network error" message: @"Could not communicate with the server" delegate: nil cancelButtonTitle: @"Ok" otherButtonTitles: nil] autorelease];
            [someError show];
        } else {
            NSError *saveError = nil;
            [databaseAccess.managedObjectContext save:&saveError]; 
            UIAlertView *confirmation = nil;
            if (user.isRegisteredForTourValue) {
                [self updateDisplay]; // TODO delegate back to the master controller to update the display instead
                confirmation = [[[UIAlertView alloc] initWithTitle: @"Thank you" message: @"Your registration is complete." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil] autorelease];
            } else {
                confirmation = [[[UIAlertView alloc] initWithTitle: @"Registration not found" message: @"Please go to GNGT.org to complete your registration." delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil] autorelease];
            }
            [confirmation show];
        }
        isCheckingRegistration = NO;
        
        [self updateDisplay];
    }];
}

#pragma mark -
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
 if (registrationView && !registrationView.hidden && userInfo.isRegisteredForTourValue) {
        [UIView animateWithDuration:0.25 
                         animations:^{ self.registrationView.alpha = 0.0; } 
                         completion:^(BOOL finished){ self.registrationView.hidden = finished; }];
        CGRect newLocation = CGRectOffset(lowerView.bounds, 0.0, upperView.bounds.size.height + 4.0); // TODO get the height of the upper view
        [UIView animateWithDuration:0.25 delay:0.25 options:0 
                         animations:^{lowerView.frame = newLocation; } 
                         completion:nil];
    }
}

#pragma mark -
#pragma mark User-selectable commands


- (IBAction)downloadUpdate
{
	// TODO implement
}



@end
