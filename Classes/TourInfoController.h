//
//  TourInfoController.h
//  GNGT
//
//  Created by Richard Clark on 2/4/11.
//  Copyright 2011 NextQuestion Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TourInfoController : UIViewController {
	UIButton *updateButton;
	UIButton *registrationButton;
}

@property (nonatomic, retain) IBOutlet UIButton *updateButton;
@property (nonatomic, retain) IBOutlet UIButton *registrationButton;

- (IBAction)downloadUpdate;
- (IBAction)registerForTour;

- (void)setBadgeText:(NSString*)value;

@end
