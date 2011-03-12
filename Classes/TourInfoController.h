//
//  TourInfoController.h
//  GNGT
//
//  Created by Richard Clark on 2/4/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TourInfoController : UIViewController {
    UISegmentedControl *viewSelector;
    UIView *activeView;
    
    // Info page
    UIView *infoPage;
	UIButton *updateButton;

    // Registration page
    UIView *registrationPage;
    UIButton *registrationButton;
    
    // Sponsor page
    UIView *sponsorPage;
}

@property (nonatomic, retain) IBOutlet UISegmentedControl *viewSelector;

@property (nonatomic, retain) IBOutlet UIView *infoPage;
@property (nonatomic, retain) IBOutlet UIButton *updateButton;

@property (nonatomic, retain) IBOutlet UIView *registrationPage;
@property (nonatomic, retain) IBOutlet UIButton *registrationButton;

@property (nonatomic, retain) IBOutlet UIView *sponsorPage;


- (IBAction)downloadUpdate;
- (IBAction)registerForTour;

- (void)setBadgeText:(NSString*)value;

@end
